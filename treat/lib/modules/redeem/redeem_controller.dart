import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:treat/api/api.dart';
import 'package:treat/routes/routes.dart';
import 'package:treat/shared/shared.dart';

class RedeemController extends GetxController {
  final ApiRepository apiRepository;

  RedeemController({required this.apiRepository});

  var _loading = false.obs;

  get loading => _loading.value;

  var _couponDesc = Rxn<dynamic>();

  get couponDesc => _couponDesc.value;

  @override
  void onInit() {
    super.onInit();
    clearPin();
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

  double get cHeight => isExpand ? Get.height * .72 : Get.height * .41;

  set cPage(int value) {
    _cPage.value = value;
    _cPage.refresh();
  }

  set rating(double value) {
    _rating.value = value;
    _rating.refresh();
  }

  adjustKeyboard() {
    _isExpand.value = !_isExpand.value;
    _isExpand.refresh();
  }

  updatePin(String abc) {
    couponPin += abc;
  }

  clearPin({int length = 4}) {
    length = couponPin.length >= 4 ? length : couponPin.length;
    couponPin = couponPin.substring(0, couponPin.length - length);
  }

  @override
  void dispose() {
    super.dispose();
  }

  redeemCoupon() {
    try {
      var data = {
        'storeId': int.parse(storeID),
        'couponId': couponID,
        'storePin': couponPin
      };
      data.toString().printInfo();
      apiRepository.redeemCoupon(data).then((value) {
        if (value == -1) {
          CommonWidget.toast('Invalid Pin');
        } else {
          /*{"success":true,"message":"","errorCode":"TREATAPP_SUCCESS","respData":
          {"referenceCode":"56565","savedAmount":25,"savedThisMonth":10,
          "savedThisYear":15}}*/
          _couponDesc.value = {...couponDesc, ...value as Map};
          _couponDesc.refresh();
          animatePage(1);
        }
      });
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  getCouponSummary() {
    clearPin();
    setLoading(true);
    apiRepository.getCouponSummary(couponID).then((value) {
      setLoading(false);
      if (value != -1) {
        try {
          _couponDesc.value = value['staticCouponSummary'];
          _couponDesc.refresh();
        } catch (e, s) {
          e.printError();
          s.printInfo();
        }
      }
    });
  }

  postRating() {
    '${{
      'storeId': int.parse(storeID),
      'rating': rating.toInt(),
      'remarks': ''
    }}'
        .printInfo();
    if (rating == 0)
      proceedAfterRating(0);
    else
      apiRepository.postRating({
        'storeId': int.parse(storeID),
        'rating': rating.toInt(),
        'remarks': 'string'
      }).then((value) {
        proceedAfterRating(3);
      });

    // apiRepository.postRating({
    //   'storeId': int.parse(storeID),
    //   'rating': rating,
    //   'remarks': ''
    // }).then((value) {
    //   if (value != -1) {
    //     _isRated.value = true;
    //     _isRated.refresh();
    //   }
    // });
  }

  proceedAfterRating(initDelay) {
    _isRated.value = true;
    _isRated.refresh();
    Future.delayed(Duration(seconds: initDelay)).then((value) {
      animatePage(2);
    });
  }

  animatePage(int index) {
    pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.linear);
    // pageController.animateToPage(index,
    //     duration: Duration(milliseconds: 300), curve: Curves.linear);
  }
}
