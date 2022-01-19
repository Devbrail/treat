import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:treat/modules/auth/widgets/pin_input_fields.dart';
import 'package:treat/modules/redeem/redeem.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/rating_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class StaticRedemption extends StatefulWidget {
  const StaticRedemption({Key? key}) : super(key: key);

  @override
  _StaticRedemptionState createState() => _StaticRedemptionState();
}

class _StaticRedemptionState extends State<StaticRedemption>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  TextEditingController _controller = TextEditingController();
  RedeemController _rc = Get.put(RedeemController(apiRepository: Get.find()));

  @override
  void initState() {
    _rc.getCouponSummary();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (_rc.cPage == 2) Get.offNamedUntil(Routes.HOME, (route) => false);
          return true;
        },
        child: Scaffold(
          backgroundColor: ColorConstants.redemptionBackground,
          body: Container(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('$IMAGE_PATH/redem_bck.png'),
                        fit: BoxFit.fill),
                  ),
                ),
                CommonWidget.actionbutton(
                  onTap: () {
                    if (_rc.cPage == 2)
                      Get.offNamedUntil(Routes.HOME, (route) => false);
                    else
                      Get.back();
                  },
                  text: 'BACK',
                  height: 22,
                  buttoncolor: ColorConstants.backButton,
                  textColor: ColorConstants.white,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 54),
                ),
                Obx(() {
                  if (_rc.loading)
                    return Center(child: CircularProgressIndicator());
                  else {
                    List<dynamic> icons = _rc.couponDesc['couponDescIcons'];
                    Map header = _rc.couponDesc['staticCouponProperties'];
                    return Container(
                      margin: EdgeInsets.only(top: 64),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            header['assetId'],
                            height: 76,
                            width: 76,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          NormalText(
                            text: header['title'],
                            fontSize: 20,
                            textColor: ColorConstants.white,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: _rc.cHeight,
                            child: PageView(
                              controller: _rc.pageController,
                              pageSnapping: false,
                              allowImplicitScrolling: true,
                              reverse: false,
                              physics: NeverScrollableScrollPhysics(),
                              onPageChanged: (value) {
                                setState(() {
                                  _controller = TextEditingController();
                                  _rc.cPage = value;
                                });
                              },
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  width: double.infinity,
                                  height: _rc.cHeight,
                                  margin: EdgeInsets.only(
                                    right: 6,
                                  ),
                                  decoration: BoxDecoration(
                                      color: ColorConstants.white,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: buildFirstPage(header, icons),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  width: Get.width,
                                  height: Get.height * .7,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  decoration: BoxDecoration(
                                      color: ColorConstants.white,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: buildSecondPage(header, icons),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  width: Get.width,
                                  height: Get.height * .7,
                                  decoration: BoxDecoration(
                                      color: ColorConstants.white,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: buildThirdPage(header, icons),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFirstPage(Map<dynamic, dynamic> header, List<dynamic> icons) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: NormalText(
            text: header['couponDescription'],
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textColor: ColorConstants.redemptionTextBlack,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...icons.map(
              (e) => Column(
                children: [
                  Image.network(
                    e['assetId'],
                    width: 35,
                    height: 42,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  NormalText(
                    text: e['couponDescIconCategory'],
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE6E6E6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              NormalText(
                text: 'Please ask ${_rc.storeName} for their pin',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: ColorConstants.redemptionTextBlack,
              ),
              SizedBox(
                height: 8,
              ),
              PinInputField(
                completed: (String otp) {},
                onTap: () {
                  _rc.adjustKeyboard();
                },
                inactiveFillColor: ColorConstants.white,
                activeColor: ColorConstants.white,
                activeFillColor: ColorConstants.white,
                selectedFillColor: ColorConstants.white,
                selectedColor: ColorConstants.white,
                inactiveColor: ColorConstants.white,
                hzMargin: 30,
                hideKeyboard: true,
                controller: _controller,
                radius: 12,
              )
            ],
          ),
        ),
        NormalText(
          text: 'Valid till 12-31-2021',
          fontSize: 12,
          textColor: const Color(0xFF8D8D8D),
        ),
        if (!_rc.isExpand)
          Container(
            margin: EdgeInsets.only(top: 34),
            child: NormalText(
              text: '*Offers are subject to rules of use',
              fontSize: 12,
              textColor: const Color(0xFF9B56C8),
            ),
          ),
        if (_rc.isExpand)
          Container(
            child: NumericKeyboard(
                onKeyboardTap: (text) {
                  text.printInfo();
                  if (_controller.text.length < 4) {
                    _controller.text = _controller.text + '*';
                    _rc.updatePin(text);
                  }
                  if (_controller.text.length == 4) {
                    _rc.redeemCoupon();
                  }
                },
                textColor: ColorConstants.redemptionTextBlack,
                rightButtonFn: () {
                  String text = _controller.text;
                  if (text.length > 0) {
                    text = text.substring(0, text.length - 1);
                    _rc.clearPin(length: 1);
                  }
                  _controller.text = text;
                },
                rightIcon: Icon(
                  Icons.backspace,
                  color: ColorConstants.redemptionTextBlack,
                ),
                mainAxisAlignment: MainAxisAlignment.spaceAround),
          )
      ],
    );
  }

  Widget buildSecondPage(Map<dynamic, dynamic> header, List<dynamic> icons) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: NormalText(
              text: header['couponDescription'],
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: ColorConstants.redemptionTextBlack,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...icons.map(
                (e) => Column(
                  children: [
                    Image.network(
                      e['assetId'],
                      width: 35,
                      height: 42,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    NormalText(
                      text: e['couponDescIconCategory'],
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: Get.width * 0.27,
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 24),
            decoration: BoxDecoration(
                color: ColorConstants.containerAshBackgroundColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                NormalText(
                  text: 'Reference Code',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: ColorConstants.redemptionTextBlack,
                ),
                Container(
                  height: 37,
                  width: 241,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: NormalText(
                    text: _rc.couponDesc['referenceCode'] ?? '',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    textColor: Color(0xFF9855C4),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            width: 241,
            child: Divider(
              color: const Color(0xFFBCBCBC),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
             margin: EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                     Flexible(
                      child: Column(
                        children: <Widget>[
                          NormalText(
                            text: 'Enjoyed your experience?',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            textColor: Color(0xFF2B2B2B),
                          ),
                          NormalText(
                            text: 'Leave ${_rc.storeName} a review!',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            textColor: Color(0xFF2B2B2B),
                            textOverflow: null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 80,
            width: 304,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorConstants.containerAshBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Rating(
              rating: 0,
              size: 35,
              isTapOnly: false,
              itemPadding: EdgeInsets.symmetric(horizontal: 4),
              unratedColor: const Color(0xFFB7B7B7),
              onRatingUpdate: (rating) {
                if (mounted)
                  setState(() {
                    _rc.rating = rating;
                  });
                print(rating);
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          if (_rc.isRated)
            NormalText(
              text: 'Rating submitted. Thank you!',
              fontSize: 14,
              textColor: ColorConstants.redemptionTextBlack,
            )
          else
            InkWell(
              onTap: _rc.postRating,
              child: Container(
                decoration: BoxDecoration(
                  color: _rc.hasRated
                      ? const Color(0xFFB063E3)
                      : const Color(0xFFB7B7B7),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: NormalText(
                  text: 'SUBMIT',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textColor: ColorConstants.white,
                ),
              ),
            ),
          SizedBox(
            height: 16,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF707070),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildThirdPage(Map<dynamic, dynamic> header, List<dynamic> icons) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: NormalText(
              text: 'My Savings',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: ColorConstants.redemptionTextBlack,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NormalText(
                    text: 'Bingo!\nYou saved',
                    fontSize: 19,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold,
                    textColor: const Color(0xFF696969),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  NormalText(
                    text: '\$${_rc.couponDesc['savedAmount']}',
                    fontSize: 66,
                    fontWeight: FontWeight.bold,
                    textColor: Color(0xFF5BAF88),
                  )
                ],
              ),
              Column(
                children: [
                  Image.asset('$IMAGE_PATH/dollar.png'),
                  SizedBox(
                    height: 24,
                  ),
                  Image.asset('$IMAGE_PATH/pig.png')
                ],
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 35,
            width: 249,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                9.0,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              onTap: (value) {
                setState(() {});
              },
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  9.0,
                ),
                color: Colors.green,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xFF959595),
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: 'This Month',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'This Year',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            height: 160,
            width: 249,
            decoration: BoxDecoration(
              color: ColorConstants.containerAshBackgroundColor,
              borderRadius: BorderRadius.circular(
                9.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NormalText(
                  text: 'Total Savings',
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
                NormalText(
                  text: _tabController!.index == 0
                      ? '\$${_rc.couponDesc['savedThisMonth']}'
                      : '\$${_rc.couponDesc['savedThisYear']}',
                  fontSize: 66,
                  fontWeight: FontWeight.bold,
                  textColor: const Color(0xFF5BAF88),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF707070),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
}
