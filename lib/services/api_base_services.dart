import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/model/api_response_model/api_response_model.dart';
import 'package:mpma_assignment/model/my_response.dart';

abstract class BaseServices {
  BaseServices() {
    _init();
  }

  static BaseServices? _instance;
  static String? youtubeHostUrl = EnvValues.youtubeHostUrl;
  static String? youtubeApiKey = EnvValues.youtubeApiKey;

  String apiUrl() => youtubeHostUrl ?? '';
  String apiKey() => youtubeApiKey ?? '';

  Dio? _dio;

  Dio? get dio {
    if (_instance == null || _instance?._dio == null) {
      _instance?._init();
    }
    return _instance?._dio;
  }

  void _init() {
    _instance = this;
    _dio = Dio(
      BaseOptions(
        headers: <String, String>{'Content-Type': ContentType.json.value},
      ),
    );
  }

  Future<MyResponse> callAPI({
    required HttpMethod httpMethod,
    required String path,
    dynamic postBody,
  }) async {
    try {
      Response? response;

      switch (httpMethod) {
        case HttpMethod.get:
          print('calling get');
          response = await dio?.get(path);
          break;
        case HttpMethod.post:
          print('calling post');
          response = await dio?.post(path, data: postBody);
          break;
        case HttpMethod.put:
          response = await dio?.put(path, data: postBody);
          break;
        case HttpMethod.delete:
          response = await dio?.delete(path);
          break;
      }

      debugPrint('Response: ${response?.statusCode}');

      if (response?.statusCode == HttpStatus.ok ||
          response?.statusCode == HttpStatus.created) {
        debugPrint('OK');
        return MyResponse.complete(response?.data);
      } else {
        debugPrint('Error: ${response?.statusCode}');
      }
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        var processedError = ApiResponseModel.fromJson(
          e.response?.data,
        ).copyWith(status: e.response?.statusCode);

        debugPrint('error status code: ${e.response?.statusCode}');
        debugPrint('error: ${e.response?.data}');

        debugPrint('API Call Error: ${processedError.message}');

        return MyResponse.error(processedError.toJson());
      } else if (e is DioException) {
        String? message;

        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            message = 'Opps, something went wrong. Please try again later.';
            debugPrint('Connection timeout');
          case DioExceptionType.connectionError:
            message =
                'Network connection failed. Please check your internet connection.';
            debugPrint('Network connection failed');
          default:
            message = e.message;
            debugPrint('Error: ${e.message}');
        }

        debugPrint('Error calling API: $message');

        return MyResponse.error(
          ApiResponseModel(
            status: e.response?.statusCode,
            message: message,
          ).toJson(),
        );
      }
      return MyResponse.error(e.toString());
    }

    debugPrint('Error calling API');
    return MyResponse.error(
      DioException(requestOptions: RequestOptions(path: path)),
    );
  }
}
