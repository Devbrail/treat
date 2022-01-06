import 'dart:convert';

import 'package:get/get.dart';
import 'package:treat/api/base_provider.dart';

import 'api_constants.dart';

class ApiProvider extends BaseProvider {
  Future<Response> getProfileDetails(String path) {
    return get('${ApiConstants.baseUrl}$path');
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

  Future<Response> addRemoveCart(
    String path,
  ) {
    return post('${ApiConstants.baseUrl}$path', {});
  }

  Future<Response> searchSuggestions(String path) {
    return post('${ApiConstants.storeBaseUrl}$path', {});
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

  Future<Response> editProfileDetails(String path, Map data) {
    return post('${ApiConstants.baseUrl}$path', data);
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

  Future<Response> uploadAsset(String path, FormData form) {
    return post('${ApiConstants.miscBaseUrl}$path', form);
  }

  Future<Response> getCouponSummary(String path) {
    return get('${ApiConstants.couponBaseUrl}$path');
  }

  Future<Response> redeemCoupon(String path, Map data) {
    return post('${ApiConstants.baseUrl}$path', data);
  }

  Future<Response> postRating(String path, Map data) {
    '${ApiConstants.baseUrl}$path\n ${json.encode(data)}'.printInfo();
    return post('${ApiConstants.baseUrl}$path', data);
  }

  Future<Response> getSavings(String path) {
    '${ApiConstants.baseUrl}$path'.printInfo();
    return get('${ApiConstants.baseUrl}$path');
  }
}
