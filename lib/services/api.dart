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
    bool paginate = false,
    int paginationPage = 1,
    int paginationSize = ConstLib.defaultPageSize,
    bool useToken = true,
    bool encodedData = true,
    bool showLog = false,
    bool showPostToast = true,
  }) async {
    String label = '${page}_api';
    String path = '${Env.apiURL}/$page';

    Map<String, dynamic> header = {};
    Map<String, dynamic> defaultParams = {};
    Map<String, dynamic> defaultData = {};

    if (useToken) {
      header[HttpHeaders.authorizationHeader] = 'Bearer ${Env.apiSecret}';
    }

    Options options = Options(
        headers: header
    );

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

    if (paginate) {
      defaultParams['pagination[page]'] = paginationPage;
      defaultParams['pagination[pageSize]'] = paginationSize;
    }

    if (params != null) defaultParams.addAll(params);
    if (files != null) defaultData.addAll(files);
    if (data != null) defaultData['data'] = data;

    logInfo(path, logLabel: '${label}_url');
    if (showLog) logInfo(header, logLabel: '${label}_header');
    if (showLog) logInfo(defaultParams, logLabel: '${label}_params');
    if (showLog) logInfo(defaultData, logLabel: '${label}_data');

    final finalData = encodedData ? jsonEncode(defaultData) : FormData.fromMap(defaultData);

    try {
      Response response;
      String successMessage = 'OK';

      switch (method) {
        case APIPostMethod.get:
          response = await Dio().get(
              path,
              queryParameters: defaultParams,
              options: options
          );
          break;
        case APIPostMethod.post:
          successMessage = 'Success add to $page';
          response = await Dio().post(
              path,
              queryParameters: defaultParams,
              data: finalData,
              options: options
          );
          break;
        case APIPostMethod.put:
          successMessage = 'Success update from ${page.split('/')[0]}';
          response = await Dio().put(
              path,
              queryParameters: defaultParams,
              data: finalData,
              options: options
          );
          break;
        case APIPostMethod.patch:
          response = await Dio().patch(
              path,
              queryParameters: defaultParams,
              data: finalData,
              options: options
          );
          break;
        case APIPostMethod.delete:
          successMessage = 'Success delete from ${page.split('/')[0]}';
          response = await Dio().delete(
              path,
              queryParameters: defaultParams,
              data: finalData,
              options: options
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
          Fluttertoast.showToast(msg: successMessage, gravity: ToastGravity.TOP);
        }

        if (showLog) {
          if (newData is List) {
            logInfo((newData as List).first.toString(), logLabel: '${label}_response_data');
          } else {
            logInfo(newData.toString(), logLabel: '${label}_response_data');
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
        Fluttertoast.showToast(msg: msg, gravity: ToastGravity.TOP);
        // logError(response.error?.toJson(), logLabel: 'error');
      }

      return response;
    }
  }

  static Future<StrapiResponse> get({
    required String page,
    Map<String, dynamic>? params,
    Map<String, dynamic>? files,
    APIPopulate populateMode = APIPopulate.none,
    List<String>? populateList,
    bool paginate = false,
    int paginationPage = 1,
    int paginationSize = ConstLib.defaultPageSize,
    bool useToken = true,
    bool encodedData = true,
    bool showLog = false,
  }) async {
    return await request(
      page: page,
      method: APIPostMethod.get,
      params: params,
      encodedData: encodedData,
      files: files,
      populateList: populateList,
      populateMode: populateMode,
      paginate: paginate,
      paginationPage: paginationPage,
      paginationSize: paginationSize,
      showLog: showLog,
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