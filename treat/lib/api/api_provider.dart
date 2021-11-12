import 'dart:convert';

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

  Future<Response> getconsumeraddresses(String path) {
    return get('${ApiConstants.baseUrl}$path');
  }

  Future<Response> searchStores(String path, Map data) {
    return post('${ApiConstants.storeBaseUrl}$path', data);
  }

  Future<Response> storeAmenities(String path) {
    return get('${ApiConstants.storeBaseUrl}$path');
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

  Future<Response> toggleFavourite(String path, Map data) {
    return post('${ApiConstants.baseUrl}$path', data);
  }

  Future<Response> loadStores(String path) {
    return get('${ApiConstants.storeBaseUrl}$path');
  }

  Future<Response> favoriteStoreDetails(String path) {
    return get('${ApiConstants.baseUrl}$path');
  }
}
