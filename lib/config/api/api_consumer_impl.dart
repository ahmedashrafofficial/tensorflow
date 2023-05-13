import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'app_interceptors.dart';
import 'api_consumer.dart';
import 'status_code.dart';

class ApiConsumerImpl implements ApiConsumer {
  final Dio client;

  ApiConsumerImpl({required this.client}) {
    (client.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.options
      // ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      // ..connectTimeout = 5000
      // ..receiveTimeout = 5000
      // ..sendTimeout = 5000
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };

    client.interceptors.add(AppInterceptors());
    if (kDebugMode) {
      client.interceptors.add(LogInterceptor());
    }
  }

  @override
  Future get(String path,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await client.get(path,
          queryParameters: queryParameters, options: options);
      return _handleResponseAsJson(response);
      // return response;
    } on DioError {
      return null;
    }
  }

  @override
  Future post(
    String path, {
    FormData? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response =
          await client.post(path, data: body, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
      // return response;
    } on DioError {
      return null;
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await client.put(path, data: body, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
      // return response;
    } on DioError {
      return null;
    }
  }
}

dynamic _handleResponseAsJson(Response<dynamic> response) {
  final responseJson = json.decode(response.data);
  return responseJson;
}
