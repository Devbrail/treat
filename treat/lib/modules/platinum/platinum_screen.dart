import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:treat/modules/auth/widgets/pin_input_fields.dart';
import 'package:treat/modules/platinum/platinum_controller.dart';
import 'package:treat/modules/redeem/redeem.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/action_button.dart';
import 'package:treat/shared/widgets/rating_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class PlatinumScreen extends StatefulWidget {
  const PlatinumScreen({Key? key}) : super(key: key);

  @override
  _PlatinumScreenState createState() => _PlatinumScreenState();
}

class _PlatinumScreenState extends State<PlatinumScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  TextEditingController _controller = TextEditingController();
  PlatinumController _rc =
      Get.put(PlatinumController(apiRepository: Get.find()));

  @override
  void initState() {
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
          backgroundColor: ColorConstants.yellow,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    '$IMAGE_PATH/redem_bck_yellow.png',
                  ),
                  fit: BoxFit.fill),
            ),
            child: Stack(
              children: [
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
                  return Container(
                    margin: EdgeInsets.only(top: 64),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstants.white),
                          child: Image.asset(
                            '$IMAGE_PATH/platinum_offer.png',
                            height: 76,
                            width: 76,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: NormalText(
                            text: 'My Treat 15% Off',
                            fontSize: 30,
                            textColor: ColorConstants.redemptionTextBlack,
                            fontWeight: FontWeight.bold,
                          ),
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
                                height: Get.height * .8,
                                margin: EdgeInsets.only(
                                  right: 6,
                                ),
                                decoration: BoxDecoration(
                                    color: ColorConstants.white,
                                    borderRadius: BorderRadius.circular(24)),
                                child: buildFirstPage(),
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
                                child: buildSecondPage(),
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
                                child: buildTransactionSuccessful1(),
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
                                child: buildTransactionSuccessful(),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: Get.width,
                                height: Get.height * .7,
                                decoration: BoxDecoration(
                                    color: ColorConstants.white,
                                    borderRadius: BorderRadius.circular(24)),
                                child: buildThirdPage(),
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
                                child: PaymentMethodsPage(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFirstPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: NormalText(
              text: 'Sake Halifax',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textColor: ColorConstants.redemptionTextBlack,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalText(
                  text: 'Total Bill Amount',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  textColor: ColorConstants.redemptionTextBlack,
                ),
                Container(
                  width: 80,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: TextFormField(
                      // controller: _controller,
                      initialValue: "100",
                      decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          prefixText: "\$",
                          prefixStyle: TextStyle(
                              color: ColorConstants.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalText(
                  text: '15% off entire bill',
                  fontSize: 13,
                  textColor: ColorConstants.redemptionTextViolet,
                ),
                NormalText(
                  text: '-\$15.00',
                  fontSize: 13,
                  textColor: ColorConstants.redemptionTextViolet,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalText(
                  text: 'Service Fee',
                  fontSize: 13,
                  textColor: ColorConstants.black,
                ),
                NormalText(
                  text: '-\$1.00',
                  fontSize: 13,
                  textColor: ColorConstants.black,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalText(
                  text: 'Taxes',
                  fontSize: 13,
                  textColor: ColorConstants.black,
                ),
                NormalText(
                  text: '-\$1.00',
                  fontSize: 13,
                  textColor: ColorConstants.black,
                ),
              ],
            ),
          ),
          Container(
            height: 79,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            decoration: BoxDecoration(
              color: ColorConstants.redemptionTextViolet,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NormalText(
                  text: 'Save \$xxx with',
                  fontSize: 13,
                  textColor: ColorConstants.white,
                ),
                SizedBox(width: 8),
                Image.asset(
                  '$IMAGE_PATH/logo.png',
                ),
                Icon(
                  Icons.add,
                  color: Color(0xFFFFD731),
                  size: 30,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalText(
                  text: 'Grand Total',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textColor: ColorConstants.black,
                ),
                NormalText(
                  text: '\$46.75',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textColor: ColorConstants.black,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NormalText(
                  text: 'Total Savings',
                  fontSize: 12,
                  textColor: ColorConstants.redemptionTextViolet,
                ),
                NormalText(
                  text: '\$12.00',
                  fontSize: 12,
                  textColor: ColorConstants.redemptionTextViolet,
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xFFC7C7C7),
            indent: 16,
            endIndent: 16,
            height: 32,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: NormalText(
              text: 'Select payment method',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              textColor: ColorConstants.black,
            ),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () {
              _rc.animatePage(5);
            },
            child: Container(
              height: 51,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: ColorConstants.black)),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.asset(
                      '$IMAGE_PATH/visa.png',
                    ),
                  ),
                  NormalText(
                    text: 'Visa 9090',
                    fontSize: 15,
                    textColor: ColorConstants.black,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        '$IMAGE_PATH/right_arrow.png',
                        color: Colors.black,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          InkWell(
            onTap: () {
              _rc.animatePage(1);
            },
            child: Container(
              height: 51,
              width: Get.width,
              decoration: BoxDecoration(
                color: ColorConstants.redemptionTextViolet,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: NormalText(
                      text: 'NEXT',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textColor: ColorConstants.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget PaymentMethodsPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: NormalText(
              text: 'Sake Halifax',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textColor: ColorConstants.redemptionTextBlack,
            ),
          ),
          ExpansionTile(
            title: Row(
              children: [
                NormalText(
                  text: "Payment Methods",
                ),
              ],
            ),
            children: [
              InkWell(
                // onTap: _rc.postRating,
                child: Container(
                  height: 51,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset(
                          '$IMAGE_PATH/visa.png',
                        ),
                      ),
                      NormalText(
                        text: 'Visa 9090',
                        fontSize: 15,
                        textColor: ColorConstants.black,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                // onTap: _rc.postRating,
                child: Container(
                  height: 51,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset(
                          '$IMAGE_PATH/visa.png',
                        ),
                      ),
                      NormalText(
                        text: 'Visa 9090',
                        fontSize: 15,
                        textColor: ColorConstants.black,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                // onTap: _rc.postRating,
                child: Container(
                  height: 51,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: ColorConstants.black)),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset(
                          '$IMAGE_PATH/visa.png',
                        ),
                      ),
                      NormalText(
                        text: 'Visa 9090',
                        fontSize: 15,
                        textColor: ColorConstants.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 25,
                ),
                NormalText(
                  text: "Add Payment Method",
                ),
              ],
            ),
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.ADDCARD);
                },
                child: Container(
                  height: 51,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset(
                          '$IMAGE_PATH/credit-card.png',
                        ),
                      ),
                      NormalText(
                        text: 'Credit or Debit Card',
                        fontSize: 15,
                        textColor: ColorConstants.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          InkWell(
            onTap: () {
              // _rc.animatePage(2);
            },
            child: Container(
              height: 51,
              width: Get.width,
              decoration: BoxDecoration(
                color: ColorConstants.redemptionTextViolet,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: NormalText(
                      text: 'NEXT',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textColor: ColorConstants.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget buildSecondPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: NormalText(
              text: 'Add a Tip',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textColor: ColorConstants.redemptionTextBlack,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(
              '$IMAGE_PATH/Add_tip.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Tipping is optional, it is an act of appreciation, which is why 100% of all tips go towards supporting the staff.",
              style: TextStyle(
                fontSize: 12,
                color: ColorConstants.redemptionTextBlack,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                var tip = ['10%', '15%', '20%', 'Other'];
                var tipAmount = ['\$10.00', '\$15.00', '\$20.00'];
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 52,
                  width: 72,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NormalText(
                        text: tip[index],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        textColor: ColorConstants.redemptionTextBlack,
                      ),
                      index == 3
                          ? SizedBox.shrink()
                          : NormalText(
                              text: tipAmount[index],
                              fontSize: 13,
                              textColor: ColorConstants.redemptionTextBlack,
                            )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 8);
              },
            ),
          ),
          SizedBox(height: 30),
          InkWell(
            onTap: () {
              _rc.animatePage(2);
            },
            child: Container(
              height: 51,
              width: Get.width,
              decoration: BoxDecoration(
                color: ColorConstants.redemptionTextViolet,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: NormalText(
                      text: 'COMPLETE PAYMENT',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textColor: ColorConstants.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget buildThirdPage(/*Map<dynamic, dynamic> header, List<dynamic> icons*/) {
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
                    text: '\$20',
                    fontSize: 66,
                    fontWeight: FontWeight.bold,
                    textColor: ColorConstants.redemptionTextViolet,
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
                color: ColorConstants.redemptionTextViolet,
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
                  text: _tabController!.index == 0 ? '\$60' : '\$60',
                  fontSize: 66,
                  fontWeight: FontWeight.bold,
                  textColor: ColorConstants.redemptionTextViolet,
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
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget buildTransactionSuccessful1() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: NormalText(
              text: 'Sake Halifax',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textColor: ColorConstants.redemptionTextBlack,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: NormalText(
              text: 'Transaction Successful!',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              textColor: ColorConstants.redemptionTextBlack,
            ),
          ),
          Image.asset(
            '$IMAGE_PATH/tick-mark.png',
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          NormalText(
                            text: 'Enjoyed your experience?',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            textColor: Color(0xFF2B2B2B),
                          ),
                          NormalText(
                            text: 'Leave Sake a review!',
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
              // color: ColorConstants.containerAshBackgroundColor,
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
                    // _rc.rating = rating;
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
              onTap: () {
                _rc.animatePage(3);
              },
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
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget buildTransactionSuccessful() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: NormalText(
              text: 'Sake Halifax',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textColor: ColorConstants.redemptionTextBlack,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: NormalText(
              text: 'Transaction Successful!',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              textColor: ColorConstants.redemptionTextBlack,
            ),
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
                    text: 'A-111-222-333',
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          NormalText(
                            text: 'Enjoyed your experience?',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            textColor: Color(0xFF2B2B2B),
                          ),
                          NormalText(
                            text: 'Leave Sake a review!',
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
              // color: ColorConstants.containerAshBackgroundColor,
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
                    // _rc.rating = rating;
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
              onTap: () {
                _rc.animatePage(4);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFB063E3),
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
          ),
          SizedBox(
            height: 20,
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
