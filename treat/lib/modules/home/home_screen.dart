import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/modules/home/tabs/tabs.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (controller.currentTab.value != MainTabs.home)
            controller.switchTab(0);
          return false;
        },
        child: Obx(() => _buildWidget()),
      ),
    );
  }

  Widget _buildWidget() {
    return Scaffold(
      body: Stack(
        children: [
          _buildContent(controller.currentTab.value),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildBottomBar(
                    path: 'dinein.png',
                    pathIa: 'dinein_ia.png',
                    text: 'DINING',
                    index: 0,
                    isCurrent: controller.currentTabIdx == 0,
                    onTap: (int a) => controller.switchTab(a),
                  ),
                  buildBottomBar(
                      path: 'retail.png',
                      pathIa: 'retail_ia.png',
                      text: 'RETAIL',
                      index: 1,
                      isCurrent: controller.currentTabIdx == 1,
                      onTap: (int a) => controller.switchTab(a)),
                  buildBottomBar(
                      path: 'everyday.png',
                      pathIa: 'everyday_ia.png',
                      text: 'EVERYDAY',
                      index: 2,
                      isCurrent: controller.currentTabIdx == 2,
                      onTap: (int a) => controller.switchTab(a)),
                  buildBottomBar(
                      path: 'fave.png',
                      pathIa: 'fave_ia.png',
                      text: 'FAVES',
                      index: 3,
                      isCurrent: controller.currentTabIdx == 3,
                      onTap: (int a) => controller.switchTab(a)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomBar({
    required String path,
    required String text,
    required int index,
    bool isCurrent = false,
    required String pathIa,
    Function(int a)? onTap,
  }) {
    String pathTemp = isCurrent ? path : pathIa;
    return InkWell(
      onTap: () {
        onTap!(index);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            '$IMAGE_PATH/$pathTemp',
            width: 40,
            height: 40,
          ),
          CommonWidget.rowHeight(height: 4),
          NormalText(
            text: text,
            textColor: !isCurrent ? Color(0xFFA6A6A6) : ColorConstants.black,
            fontSize: 10,
          )
        ],
      ),
    );
  }

  Widget _buildContent(MainTabs tab) {
    tab.index.toString().printInfo();
    switch (tab) {
      case MainTabs.home:
        return controller.mainTab;
      case MainTabs.faveTab:
        return controller.faveTab;

      default:
        return controller.mainTab;
    }
  }
}
