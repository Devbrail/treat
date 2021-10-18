import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'base_response.dart';
import 'error_handle.dart';

late int _connectTimeout = 30000;
late int _receiveTimeout = 15000;
late int _sendTimeout = 10000;
late String _baseUrl;
late List<Interceptor> _interceptors = [];

void setInitDio({
  required int connectTimeout,
  required int receiveTimeout,
  required int sendTimeout,
  required String baseUrl,
  required List<Interceptor> interceptors,
}) {
  _connectTimeout = connectTimeout ?? _connectTimeout;
  _receiveTimeout = receiveTimeout ?? _receiveTimeout;
  _sendTimeout = sendTimeout ?? _sendTimeout;
  _baseUrl = baseUrl ?? _baseUrl;
  _interceptors = interceptors ?? _interceptors;
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}

typedef NetSuccessCallback<T> = Function(T data);
typedef NetSuccessListCallback<T> = Function(List<T> data);
typedef NetErrorCallback = Function(int code, String msg);
typedef NetProgressCallback = Function(double percentage);

class DioUtils {
  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  factory DioUtils() => _singleton;

  static late Dio _dio;

  Dio get dio => _dio;

  DioUtils._() {
    BaseOptions _options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      responseType: ResponseType.plain,
      validateStatus: (_) {
        return true;
      },
      baseUrl: _baseUrl,
    );
    _dio = Dio(_options);
    _interceptors.forEach((interceptor) {
      _dio.interceptors.add(interceptor);
    });
  }

  // The data return format is unified, and exceptions are handled uniformly
  Future<BaseResponse<T>> _request<T>(
    String method,
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    NetProgressCallback? onProgressUpdate,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final Response<String> response = await _dio.request<String>(
      url,
      data: data is File ? data.openRead() : data,
      queryParameters: queryParameters,
      options: _checkOptions(method, options!),
      cancelToken: cancelToken,
      onSendProgress: (int sent, int total) {
        print("$sent $total");
        if (onProgressUpdate != null && total > 0)
          onProgressUpdate(sent / total);
      },
    );
    try {
      if (response.statusCode != 204) {
        Map<String, dynamic> _map =
            await compute(parseData, response.data.toString());
        return BaseResponse<T>.fromJson(_map, response.statusCode!);
      } else {
        return BaseResponse<T>.fromJson(null, response.statusCode!);
      }
    } catch (e) {
      return BaseResponse<T>(
          ExceptionHandle.parse_error, 'Data parsing error！', null);
    }
  }

  Options _checkOptions(String method, Options options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  Future requestNetwork<T>(
    Method method,
    String url, {
    NetSuccessCallback<T>? onSuccess,
    NetErrorCallback? onError,
    NetProgressCallback? onProgressUpdate,
    dynamic params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    return _request<T>(method.value, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onProgressUpdate: onProgressUpdate)
        .then((BaseResponse<T> result) {
      if (result.code == 200 || result.code == 201) {
        if (onSuccess != null) {
          onSuccess(result.data!);
        }
      } else {
        _onError(result.code, result.message, onError!);
      }
    }, onError: (dynamic e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError!);
    });
  }

  void _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {}
  }

  void _onError(int code, String msg, NetErrorCallback onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = 'Unknown exception';
    }
    if (onError != null) {
      onError(code, msg);
    }
  }
}

enum Method { get, post, put, patch, delete, head }

extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
