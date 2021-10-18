import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:treat/models/models.dart';
import 'package:treat/models/response/everyday_store.detail.dart';
import 'package:treat/models/response/intial_token_response.dart';
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

  Future<Either<String, Map>?> sendOtpPhone({required Map data}) async {
    printInfo(info: 'suhail');

    final res = await apiProvider.sentOtpPhone(ApiConstants.phone, data);
    printInfo(info: 'res.body');
    printInfo(info: res.body.runtimeType.toString());

    if (res.statusCode == 200) {
      return Right(res.body);
    } else {
      printInfo(info: res.body['message']);

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
