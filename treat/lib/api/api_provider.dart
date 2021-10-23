import 'package:get/get.dart';
import 'package:treat/api/base_provider.dart';
import 'package:treat/models/models.dart';

import 'api_constants.dart';

class ApiProvider extends BaseProvider {
  Future<Response> login(String path, LoginRequest data) {
    return post('${ApiConstants.baseUrl}$path', data.toJson());
  }

  Future<Response> sentOtpPhone(String path, Map data) {
    return post('${ApiConstants.baseUrl}$path', data);
  }

  Future<Response> sentOtpEmail(String path, Map data) {
    return post('${ApiConstants.baseUrl}$path', data);
  }

  Future<Response> resentOTP(String path, Map data) {
    return post('${ApiConstants.baseUrl}$path', data);
  }

  Future<Response> initialtoken(String path) {
    return get('${ApiConstants.baseUrl}$path');
  }

  Future<Response> authToken(String path) {
    return get('${ApiConstants.baseUrl}$path');
  }

  Future<Response> completeProfile(String path, Map data) {
    return post('${ApiConstants.baseUrl}$path', data);
  }

  Future<Response> getUsers(String path) {
    return get('${ApiConstants.baseUrl}$path');
  }

  Future<Response> getStoreDetails(String path) {
    return get('${ApiConstants.storeBaseUrl}$path');
  }

  Future<Response> loadStores(String path) {
    return get('${ApiConstants.storeBaseUrl}$path');
  }
}
