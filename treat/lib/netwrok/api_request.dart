import 'package:dio/dio.dart';

class ApiRequest {
  final String url;
  final Map<String, dynamic> data;

  ApiRequest({
    required this.url,
    required this.data,
  });

  Dio _dio() {
    // Put your authorization token here
    // Interceptors and handlers are need to impliment

    return Dio(BaseOptions(headers: {
      'Authorization': 'Bearer ....',
    }));
  }

  void get({
    Function()? beforeSend,
    required Function(dynamic data) onSuccess,
    Function(dynamic error)? onError,
  }) {
    _dio().get(this.url, queryParameters: this.data).then((res) {
      onSuccess(res.data);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }
}
