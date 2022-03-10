import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:treat/api/api.dart';

class DynamicRedeemController extends GetxController {
  final ApiRepository apiRepository;

  DynamicRedeemController({required this.apiRepository});

  var _loading = false.obs;

  get loading => _loading.value;

  var _couponDesc = Rxn<dynamic>();

  var _cardDeatails = Rxn<dynamic>();

  get couponDesc => _couponDesc.value;

  get cardDeatails => _cardDeatails.value;

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
  RxInt selectedTip = 0.obs;
  RxInt selectedCard = 0.obs;
  RxBool tipIn = true.obs;

  RxBool _isExpand = false.obs;
  RxBool _isRated = false.obs;
  RxDouble _rating = 0.0.obs;
  String couponPin = '';
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: .85,
  );

  set selectedTips(int value) {
    selectedTip.value = value;
    selectedTip.refresh();
  }
  set selectedCards(int value) {
    selectedCard.value = value;
    selectedCard.refresh();
  }

  set setTipIn(bool value) {
    tipIn.value = value;
    tipIn.refresh();
  }

  bool get isExpand => _isExpand.value;

  bool get isRated => _isRated.value;

  int get cPage => _cPage.value;

  double get rating => _rating.value;

  int couponID = Get.arguments[0];

  String storeID = Get.arguments[1];
  String storeName = Get.arguments[2];

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

  redeemCoupon(var amount) {
    try {
      var data = {
        'storeId': int.parse(storeID),
        'couponId': couponID,
        'amount': int.parse(amount)
      };
      data.toString().printInfo();
      apiRepository.redeemDynamicCoupon(data).then((value) {
        if (value == -1) {
          // CommonWidget.toast('Invalid Pin');
        } else {
          /*{"success":true,"message":"","errorCode":"TREATAPP_SUCCESS","respData":
          {"referenceCode":"56565","savedAmount":25,"savedThisMonth":10,
          "savedThisYear":15}}*/
          _couponDesc.value = {...couponDesc, ...value as Map};
          _couponDesc.refresh();
          animatePage(1);
          print("data---${_couponDesc}");
        }
      });
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  getCardDetails() {

    setLoading(true);
    apiRepository.getCards().then((value) {
      setLoading(false);
      if (value != -1) {
        try {
          _cardDeatails.value = value['savedCardList'];
          _cardDeatails.refresh();
        } catch (e, s) {
          e.printError();
          s.printInfo();
        }
      }
    });
  }


  animatePage(int index) {
    // pageController.nextPage(
    //     duration: Duration(milliseconds: 300), curve: Curves.linear);
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }
}
