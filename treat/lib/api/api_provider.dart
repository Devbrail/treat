import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat/api/base_provider.dart';
import 'package:treat/models/models.dart';

class ApiProvider extends BaseProvider {
  Future<Response> login(String path, LoginRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> sentOtpPhone(String path, Map data) {
    return post(path, data);
  }

  Future<Response> sentOtpEmail(String path, Map data) {
    return post(path, data);
  }

  Future<Response> initialtoken(String path) {
    return get(path);
  }

  Future<Response> completeProfile(String path, Map data) {
    return post(path, data);
  }

  Future<Response> getUsers(String path) {
    return get(path);
  }
}
