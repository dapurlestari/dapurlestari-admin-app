import 'dart:io';

import 'package:admin/env/env.dart';
import 'package:dio/dio.dart';

import 'logger.dart';
import 'strapi_response.dart';

enum APIPopulate {
  none,
  all,
  deep,
  custom
}

class API {
  static Future<StrapiResponse> get({
    required String page,
    Map<String, dynamic>? params,
    APIPopulate populateMode = APIPopulate.none,
    List<String>? populateList,
    bool useToken = true,
    bool showLog = false,
  }) async {
    String label = '${page}_api';
    String path = '${Env.apiURL}/$page';

    Map<String, dynamic> header = {};
    Map<String, dynamic> defaultParams = {};

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

    if (params != null) defaultParams.addAll(params);
    if (showLog) logInfo(header, logLabel: '${label}_header');
    if (showLog) logInfo(defaultParams, logLabel: '${label}_params');

    logInfo(path, logLabel: '${label}_url');
    Response response = await Dio().get(
      path,
      queryParameters: defaultParams,
      options: options
    );

    logInfo(response.data.runtimeType.toString(), logLabel: '${label}_response_type');
    StrapiResponse strapiResponse = StrapiResponse();
    if (response.data != null) {
      strapiResponse = StrapiResponse.response(response.data);

      if (showLog) {
        if (response.data is List) {
          logInfo((response.data as List).first.toString(), logLabel: '${label}_response_data');
        } else {
          logInfo(response.data.toString(), logLabel: '${label}_response_data');
        }
      }
    }

    return strapiResponse;
  }
}