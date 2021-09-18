import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:treat/models/models.dart';
import 'package:treat/models/response/intial_token_response.dart';
import 'package:treat/models/response/users_response.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<IntialTokenResponse?> initialtoken() async {
    final res = await apiProvider.initialtoken('/initialtoken');
    if (res.statusCode == 200) {
      return IntialTokenResponse.fromJson(res.body);
    }
  }

  Future<Either<String, Map>?> sendOtpPhone({required Map data}) async {
    printInfo(info: 'suhail');

    final res = await apiProvider.sentOtpPhone('/otp/phone', data);
    printInfo(info: 'res.body');
    printInfo(info: res.body.runtimeType.toString());

    if (res.statusCode == 200) {
      return Right(res.body);
    } else {
      printInfo(info: res.body['message']);

      return Left(res.body['message']);
    }
  }

  Future<Either<String, Map>?> sendOtpEmail({required Map data}) async {
    final res = await apiProvider.sentOtpEmail('/otp/email', data);
    if (res.statusCode == 200) {
      return Right(res.body);
    } else
      return Left(res.body['message']);
  }

  Future<Either<String, Map>?> verifyOTP({required Map data}) async {
    final res = await apiProvider.sentOtpEmail('/otp/verify', data);
    if (res.statusCode == 200) {
      return Right(res.body);
    } else
      return Left(res.body['message']);
  }

  Future<Either<String, Map>?> completeProfile({required Map data}) async {
    final res =
        await apiProvider.completeProfile('/additionaldetails/capture', data);
    if (res.statusCode == 200) {
      return Right(res.body);
    } else
      return Left(res.body!['message']);
  }

  Future<LoginResponse?> login(LoginRequest data) async {
    final res = await apiProvider.login('/api/login', data);
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
