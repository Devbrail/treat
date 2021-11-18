import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:treat/models/models.dart';
import 'package:treat/models/response/addresses.dart';
import 'package:treat/models/response/everyday_store.detail.dart';
import 'package:treat/models/response/favourite_response.dart';
import 'package:treat/models/response/intial_token_response.dart';
import 'package:treat/models/response/search_response.dart';
import 'package:treat/models/response/store_dasboard.dart';
import 'package:treat/models/response/store_details.dart';
import 'package:treat/models/response/users_response.dart';

import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<IntialTokenResponse?> initialtoken() async {
    final res = await apiProvider.initialtoken(ApiConstants.initialtoken);
    if (res.statusCode == 200) {
      return IntialTokenResponse.fromJson(res.body);
    }
  }

  Future<LoginResponse?> authToken(String initialToken) async {
    final res =
        await apiProvider.authToken('${ApiConstants.skiplogin}/$initialToken');
    if (res.statusCode == 200) {
      return LoginResponse.fromJson(res.body);
    }
  }

  Future<StoreDashboardResponse?> loadStores(
      {required String lat,
      required String lng,
      required String storeType}) async {
    final res = await apiProvider
        .loadStores('${ApiConstants.stores}/$storeType/$lat/$lng');
    if (res.statusCode == 200) {
      return StoreDashboardResponse.fromJson(res.body);
    }
  }

  Future<FavouriteResponse?> favoriteStoreDetails({
    required String lat,
    required String lng,
  }) async {
    final res = await apiProvider
        .favoriteStoreDetails('${ApiConstants.favoritestoredetails}/$lat/$lng');
    if (res.statusCode == 200) {
      return FavouriteResponse.fromJson(res.body['respData']);
    }
  }

  Future<Either<String, Map>?> sendOtpPhone({required Map data}) async {
    printInfo(info: 'suhail');

    final res = await apiProvider.sentOtpPhone(ApiConstants.phone, data);
    printInfo(info: 'res.body');
    printInfo(info: res.body.runtimeType.toString());

    if (res.statusCode == 200) {
      return Right(res.body);
    } else {
      // printInfo(info: res.body['message']);

      return Left(res.body);
    }
  }

  Future<Either<String, Map>?> sendOtpEmail({required Map data}) async {
    final res = await apiProvider.sentOtpEmail(ApiConstants.email, data);
    if (res.statusCode == 200) {
      return Right(res.body);
    } else
      return Left(res.body);
  }

  Future<Either<String, Map>?> verifyOTP({required Map data}) async {
    final res = await apiProvider.sentOtpEmail(ApiConstants.verify, data);
    if (res.statusCode == 200) {
      return Right(res.body);
    } else
      return Left(res.body);
  }

  Future<Either<String, Map>?> resendOtp({required Map data}) async {
    final res = await apiProvider.resentOTP(ApiConstants.resendotp, data);
    if (res.statusCode == 200) {
      return Right(res.body);
    } else
      return Left(res.body);
  }

  Future<Either<int, Addresses>?> getconsumeraddresses() async {
    final res = await apiProvider
        .getconsumeraddresses(ApiConstants.getconsumeraddresses);

    if (res.statusCode == 200) {
      if (res.body['success'])
        return Right(Addresses.fromJson(res.body['respData']));
      else
        return Left(0);
    }
    return Left(-1);
  }

  Future<Either<int, SearchResult>?> searchStores(Map body) async {
    final res = await apiProvider.searchStores(ApiConstants.searchStores, body);

    if (res.statusCode == 200) {
      if (res.body['success'])
        return Right(SearchResult.fromJson(res.body['respData']));
      else
        return Left(0);
    }
    return Left(-1);
  }

  Future<List> searchSuggestions(String query) async {
    final res = await apiProvider.searchSuggestions(
        '${ApiConstants.searchSuggestions}?searchtext=$query');

    if (res.statusCode == 200) {
      if (res.body['success'])
        return res.body['respData']['searchSuggestions'];
      else
        return [];
    }
    return [];
  }

  Future<Either<int, List<dynamic>>> storeAmenities() async {
    final res = await apiProvider.storeAmenities(ApiConstants.storeAmenities);

    if (res.statusCode == 200) {
      if (res.body['success'])
        return Right(res.body['respData']['storeAmnetyDetails']);
      else
        return Left(0);
    }
    return Left(-1);
  }

  Future<Either<bool, bool>?> makeDefaultAddress(int addressID) async {
    final res = await apiProvider.getconsumeraddresses(
        ApiConstants.makeDefaultAddress + '?DefaultAddressId=$addressID');
    '${res.statusCode}  ${res.statusText}'.printInfo();
    if (res.statusCode == 200) {
      return Right(true);
    }
    return Left(false);
  }

  Future<Either<String, Map>?> toggleFavourite({required Map data}) async {
    final res =
        await apiProvider.toggleFavourite(ApiConstants.toggleFavourite, data);
    if (res.statusCode == 200) {
      return Right(res.body);
    } else
      return Left(res.body ?? '');
  }

  Future<Either<String, EveryDayStore>?> loadEveryDayStoreDetail(
      String storeID) async {
    final res = await apiProvider
        .getStoreDetails('${ApiConstants.storedetails}/$storeID');

    if (res.statusCode == 200) {
      return Right(EveryDayStore.fromJson(res.body['respData']));
    } else
      return Left(res.statusCode.toString() +
          "  " +
          res.status.isUnauthorized.toString());
  }

  Future<Either<String, StoreDetails>?> getStoreDetails(String storeID) async {
    final res = await apiProvider
        .getStoreDetails('${ApiConstants.storedetails}/$storeID');

    if (res.statusCode == 200) {
      return Right(StoreDetails.fromJson(res.body['respData']));
    } else
      return Left(res.statusCode.toString() +
          "  " +
          res.status.isUnauthorized.toString());
  }

  Future<Either<String, Map>?> completeProfile({required Map data}) async {
    final res = await apiProvider.completeProfile(ApiConstants.capture, data);
    if (res.statusCode == 200)
      return Right(res.body);
    else
      return Left(res.body);
  }

  Future<LoginResponse?> login(LoginRequest data) async {
    final res = await apiProvider.login(ApiConstants.login, data);
    if (res.statusCode == 200) {
      return LoginResponse.fromJson(res.body);
    }
  }

  Future<UsersResponse?> getUsers() async {
    final res = await apiProvider.getUsers('/api/users?page=1&per_page=12');
    if (res.statusCode == 200) {
      return UsersResponse.fromJson(res.body);
    }
  }
}
