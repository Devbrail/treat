import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:treat/api/api.dart';

class PlatinumController extends GetxController {
  final ApiRepository apiRepository;

  PlatinumController({required this.apiRepository});

  var _loading = false.obs;

  get loading => _loading.value;

  var _couponDesc = Rxn<dynamic>();

  get couponDesc => _couponDesc.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _isRated.value = false;
    _isExpand.value = false;
    _rating.value = 0.0;
  }

  setLoading(bool value) {
    _loading.value = value;
  }

  RxInt _cPage = 0.obs;

  RxBool _isExpand = false.obs;
  RxBool _isRated = false.obs;
  RxDouble _rating = 0.0.obs;
  String couponPin = '';
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: .85,
  );

  bool get isExpand => _isExpand.value;

  bool get isRated => _isRated.value;

  int get cPage => _cPage.value;

  double get rating => _rating.value;

  int get couponID => Get.arguments[0];

  String get storeID => Get.arguments[1];
  String get storeName => Get.arguments[2];

  bool get hasRated => rating > 0;

  double get cHeight => isExpand ? Get.height * .72 : Get.height * .65;

  set cPage(int value) {
    _cPage.value = value;
    _cPage.refresh();
  }

  adjustKeyboard() {
    _isExpand.value = !_isExpand.value;
    _isExpand.refresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  animatePage(int index) {
    // pageController.nextPage(
    //     duration: Duration(milliseconds: 300), curve: Curves.linear);
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }
}
