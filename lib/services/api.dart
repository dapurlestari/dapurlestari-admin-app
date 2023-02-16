import 'dart:convert';
import 'dart:io';

import 'package:admin/env/env.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'logger.dart';
import 'strapi_response.dart';

enum APIPopulate {
  none,
  all,
  deep,
  custom
}

enum APIPostMethod {
  get,
  post,
  put,
  patch,
  delete,
}

class API {

  static Future<StrapiResponse> request({
    required String page,
    APIPostMethod method = APIPostMethod.post,
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    Map<String, dynamic>? files,
    APIPopulate populateMode = APIPopulate.none,
    List<String>? populateList,
    List<String>? sortList,
    List<String>? filterList,
    bool paginate = false,
    bool paginateAlt = false,
    int paginationPage = 1,
    int paginationSize = ConstLib.defaultPageSize,
    int start = 0,
    int limit = ConstLib.defaultPageSize,
    bool useToken = true,
    bool encodedData = true,
    bool showLog = false,
    bool showPostToast = true,
    bool showErrorToast = true,
  }) async {
    String label = '${page}_api';
    String path = '${Env.apiURL}/$page';

    Map<String, dynamic> headers = {};
    Map<String, dynamic> defaultParams = {};
    Map<String, dynamic> defaultData = {};

    if (useToken) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer ${Env.apiSecret}';
    }

    String populateKey = 'populate';
    switch (populateMode) {
      case APIPopulate.none:
        defaultParams.remove(populateKey);
        break;
      case APIPopulate.all:
        defaultParams[populateKey] = '*';
        break;
      case APIPopulate.deep:
        defaultParams[populateKey] = 'deep';
        break;
      case APIPopulate.custom:
        if (populateList != null) {
          populateList.asMap().forEach((key, value) {
            defaultParams['$populateKey[$key]'] = value;
          });
        }
        break;
    }

    /* ============= Filters
    * Example:
    * filters[id][$in][0] = 1
    * filters[id][$in][1] = 2
    *
    * Input
    * id:in:1,2,3,4
    *
    *  */
    String filtersKey = 'filters';
    if (filterList != null) {
      filterList.asMap().forEach((key, value) {
        List<String> array = value.split(':');
        String filterKey = array[0];
        String filterCondition = array[1];
        String filterValue = array[2];
        if (filterValue.contains(',')) {
          List<String> values = filterValue.split(',');
          values.asMap().forEach((key, value) {
            defaultParams['$filtersKey[$filterKey][\$$filterCondition][$key]'] = value;
          });
        } else {
          defaultParams['$filtersKey[$filterKey][\$$filterCondition]'] = filterValue;
        }
      });
    }

    /* ============= Sorts
    * Example:
    * sort[0] = field1:asc
    * sort[1] = field1:desc
    *
    * Input
    * field1:asc
    * field2:asc
    *
    *  */
    String sortsKey = 'sort';
    if (sortList != null) {
      sortList.asMap().forEach((key, value) {
        defaultParams['$sortsKey[$key]'] = value;
      });
    }

    if (paginate) {
      defaultParams['pagination[page]'] = paginationPage;
      defaultParams['pagination[pageSize]'] = paginationSize;
    } else if (paginateAlt) {
      defaultParams['start'] = start;
      defaultParams['limit'] = limit;
    }

    if (params != null) defaultParams.addAll(params);
    if (files != null) defaultData.addAll(files);
    if (data != null) defaultData['data'] = data;

    logInfo(path, logLabel: '${label}_url');
    if (showLog) logInfo(headers, logLabel: '${label}_header');
    if (showLog) logInfo(defaultParams, logLabel: '${label}_params');
    if (showLog) logInfo(defaultData, logLabel: '${label}_data');

    final finalData = encodedData ? jsonEncode(defaultData) : FormData.fromMap(defaultData);

    try {
      Response response;
      String successMessage = 'OK';
      final dio = Dio(BaseOptions(
        baseUrl: '${Env.apiURL}/$page',
        headers: headers,
        queryParameters: defaultParams,
      ));

      switch (method) {
        case APIPostMethod.get:
          response = await dio.get(
              path,
          );
          break;
        case APIPostMethod.post:
          successMessage = 'Success add to $page';
          response = await dio.post(
              path,
              data: finalData,
          );
          break;
        case APIPostMethod.put:
          successMessage = 'Success update from ${page.split('/')[0]}';
          response = await dio.put(
              path,
              data: finalData,
          );
          break;
        case APIPostMethod.patch:
          response = await dio.patch(
              path,
              data: finalData,
          );
          break;
        case APIPostMethod.delete:
          successMessage = 'Success delete from ${page.split('/')[0]}';
          response = await dio.delete(
              path,
              data: finalData,
          );
          break;
      }


      logInfo(response.data.runtimeType.toString(), logLabel: '${label}_response_type');
      StrapiResponse strapiResponse = StrapiResponse();
      if (response.data != null) {
        Map<String, dynamic> newData = {};
        if (response.data is List) {
          newData['data'] = response.data;
        } else {
          newData = response.data;
        }

        strapiResponse = StrapiResponse.response(newData);
        if (showPostToast &&
            method == APIPostMethod.post ||
            method == APIPostMethod.put ||
            method == APIPostMethod.delete
        ) {
          Fluttertoast.showToast(msg: successMessage, gravity: ToastGravity.TOP_RIGHT);
        }

        if (showLog) {
          if (newData is List) {
            logInfo((newData as List).first.toString(), logLabel: '${label}_response_list');
          } else {
            logInfo(newData.toString(), logLabel: '${label}_response_map');
          }
        }
      }

      return strapiResponse;
    } on DioError catch (e) {
      logError(e.response?.data);
      StrapiResponse response = StrapiResponse.errorDefault();
      if (e.response != null) {
        response = StrapiResponse.response(e.response!.data);
        String msg = '${response.error!.status}. ${response.error!.name}, ${response.error!.message}';
        if (showErrorToast) Fluttertoast.showToast(msg: msg, gravity: ToastGravity.TOP);
        // logError(response.error?.toJson(), logLabel: 'error');
      }

      return response;
    } on Exception catch (e) {
      logError(e, logLabel: 'exception');
      return StrapiResponse.errorDefault();
    }
  }

  static Future<StrapiResponse> get({
    required String page,
    Map<String, dynamic>? params,
    Map<String, dynamic>? files,
    APIPopulate populateMode = APIPopulate.none,
    List<String>? populateList,
    List<String>? sortList,
    List<String>? filterList,
    bool paginate = false,
    bool paginateAlt = false,
    int paginationPage = 1,
    int paginationSize = ConstLib.defaultPageSize,
    int start = 0,
    int limit = ConstLib.defaultPageSize,
    bool useToken = true,
    bool encodedData = true,
    bool showLog = false,
    bool showErrorToast = false,
  }) async {
    return await request(
      page: page,
      method: APIPostMethod.get,
      params: params,
      encodedData: encodedData,
      files: files,
      populateList: populateList,
      sortList: sortList,
      filterList: filterList,
      populateMode: populateMode,
      paginate: paginate,
      paginateAlt: paginateAlt,
      paginationPage: paginationPage,
      paginationSize: paginationSize,
      start: start,
      limit: limit,
      showLog: showLog,
      showErrorToast: showErrorToast,
      useToken: useToken
    );
  }

  static Future<StrapiResponse> post({
    required String page,
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    Map<String, dynamic>? files,
    APIPopulate populateMode = APIPopulate.none,
    List<String>? populateList,
    bool useToken = true,
    bool encodedData = true,
    bool showLog = false,
  }) async {
    return await request(
      page: page,
      method: APIPostMethod.post,
      params: params,
      data: data,
      encodedData: encodedData,
      files: files,
      populateList: populateList,
      populateMode: populateMode,
      showLog: showLog,
      useToken: useToken
    );
  }

  static Future<StrapiResponse> put({
    required String page,
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    Map<String, dynamic>? files,
    APIPopulate populateMode = APIPopulate.none,
    List<String>? populateList,
    bool useToken = true,
    bool encodedData = true,
    bool showLog = false,
  }) async {
    return await request(
      page: page,
      method: APIPostMethod.put,
      params: params,
      data: data,
      encodedData: encodedData,
      files: files,
      populateList: populateList,
      populateMode: populateMode,
      showLog: showLog,
      useToken: useToken
    );
  }
}