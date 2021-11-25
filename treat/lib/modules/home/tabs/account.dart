import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/routes/routes.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';
import 'package:treat/shared/widgets/image_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class Account extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (Utils.isGuest || controller.profileDetails.value == null) {
      return Stack(
        children: [
          Positioned(
            left: 3,
            top: 24,
            child: CommonWidget.actionbutton(
              onTap: () => Get.back(),
              text: 'BACK',
              height: 26,
              buttoncolor: ColorConstants.black,
              textColor: ColorConstants.white,
              margin: EdgeInsets.only(top: 32, left: 24),
            ),
          ),
          Center(
            child: CommonWidget.actionbutton(
              onTap: () => controller.signOut(),
              text: 'Login',
              height: 26,
              buttoncolor: ColorConstants.black,
              textColor: ColorConstants.white,
              margin: EdgeInsets.only(top: 32, left: 24),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CommonWidget.actionbutton(
                        onTap: () => Get.back(),
                        text: 'BACK',
                        height: 26,
                        buttoncolor: ColorConstants.black,
                        textColor: ColorConstants.white,
                        margin: EdgeInsets.only(top: 32, left: 24),
                      ),
                    ],
                  ),
                  CommonWidget.rowHeight(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: ColorConstants.filterDropDownSelected,
                      alignment: Alignment.center,
                      child: controller.profileDetails.value == null
                          ? Icon(
                              Icons.camera_enhance,
                              size: 38,
                              color: const Color(0xFF8B8B8B),
                            )
                          : ImageWidget(
                              image: controller.profileDetails.value!.assetId),
                    ),
                  ),
                  CommonWidget.rowHeight(height: 12),
                  NormalText(
                    text:
                        '${controller.profileDetails.value!.firstName} ${controller.profileDetails.value!.lastName}',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  CommonWidget.rowHeight(height: 12),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.HOME + Routes.VIEW_PROFILE),
                    child: NormalText(
                      text: 'View Profile',
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 26),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 86,
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: ColorConstants.green,
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        ColorConstants.violet,
                                        ColorConstants.lightViolet,
                                      ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      stops: [
                                        0.0,
                                        1.0,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          NormalText(
                                            text: 'Total\nSavings',
                                            fontSize: 19,
                                            textColor: ColorConstants.white,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.start,
                                          ),
                                          NormalText(
                                            text: 'CAD',
                                            fontSize: 9,
                                            textColor: ColorConstants.white,
                                            fontWeight: FontWeight.w400,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: NormalText(
                                        text: '\$1234',
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        textColor: ColorConstants.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              CommonWidget.rowHeight(height: 12),
                              Container(
                                height: 86,
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: ColorConstants.green,
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color(0xffFFB000),
                                        Color(0xFFFCCC00),
                                      ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      stops: [
                                        0.0,
                                        1.0,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          NormalText(
                                            text: 'Coupons\nUsed',
                                            fontSize: 19,
                                            textColor: ColorConstants.white,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: NormalText(
                                        text: '12',
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        textColor: ColorConstants.white,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        CommonWidget.rowWidth(width: 12),
                        Expanded(
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                color: ColorConstants.green,
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xff60FF9D),
                                    // Color(0xFF60FF9D),
                                    // Color(0xFF77E7E8),
                                    // Color(0xFF7373FF),
                                    Color(0xFF9D4AFF),
                                  ],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft,
                                  stops: [0.1, /*0.04, 0.05, 0.07,*/ 1],
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.all(6),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: NormalText(
                                    text: 'My\nLoyalty',
                                    fontSize: 19,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.bold,
                                    textColor: ColorConstants.white,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Image.asset(
                                    '$IMAGE_PATH/heart_me.png',
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ...[
                    {
                      'title': 'Addresses',
                      'icon': 'assets/images/location_profile.png',
                      'id': 0
                    },
                    {
                      'title': 'Subscriptions',
                      'icon': 'assets/images/subscription.png',
                      'id': 1
                    },
                    {
                      'title': 'My Wallet',
                      'icon': 'assets/images/wallet (2).png',
                      'id': 2
                    },
                    {
                      'title': 'Pings',
                      'icon': 'assets/images/send_prof.png',
                      'id': 3
                    },
                    {
                      'title': 'Notifications',
                      'icon': 'assets/images/notification.png',
                      'id': 4
                    },
                    {
                      'title': 'Help',
                      'icon': 'assets/images/help.png',
                      'id': 5,
                    },
                    {
                      'title': 'Sign Out',
                      'icon': 'assets/images/logout.png',
                      'id': 6
                    },
                  ].map(
                    (Map e) => ListTile(
                      leading: Image.asset(e['icon']!),
                      title: NormalText(
                        text: e['title'],
                        textAlign: TextAlign.start,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: () {
                        switch (e['id']) {
                          case 6:
                            controller.signOut();
                        }
                      },
                    ),
                  ),

                  // _buildListItems()
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildListItems() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              IconTitleItem(
                title: 'Cards',
                icon: 'assets/svgs/icon_discover.svg',
                onTap: () => Get.offAndToNamed(Routes.HOME + Routes.CARDS),
              ),
              IconTitleItem(
                title: 'Resource',
                icon: 'assets/svgs/icon_resource.svg',
                onTap: () {},
              ),
              IconTitleItem(
                title: 'Inbox',
                icon: 'assets/svgs/icon_inbox.svg',
                onTap: () {},
              ),
              SizedBox(
                height: 8,
              ),
              IconTitleItem(
                backgroundColor: ColorConstants.lightGray,
                paddingLeft: 16,
                paddingTop: 16,
                paddingRight: 16,
                padingBottom: 16,
                marginRight: 16,
                marginLeft: 5,
                drawablePadding: 10.0,
                title: 'sign out',
                icon: 'assets/svgs/icon_sign_out.svg',
                onTap: () {
                  controller.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
