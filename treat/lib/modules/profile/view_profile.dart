import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/modules/account/account_controller.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/constants/constants.dart';
import 'package:treat/shared/utils/common_widget.dart';
import 'package:treat/shared/widgets/image_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class ViewProfile extends GetView<AccountController> {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 32, left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidget.actionbutton(
                        onTap: () => Get.back(),
                        text: 'BACK',
                        height: 26,
                        buttoncolor: ColorConstants.backButton,
                        textColor: ColorConstants.white,
                      ),
                      // InkWell(
                      //   child: NormalText(
                      //     text: 'Save',
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                CommonWidget.rowHeight(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: ColorConstants.filterDropDownSelected,
                    alignment: Alignment.center,
                    child: controller.profileDetails.value!.assetUrl == null
                        ? IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_enhance,
                              size: 38,
                              color: const Color(0xFF8B8B8B),
                            ),
                          )
                        : ImageWidget(
                            image: controller.profileDetails.value!.assetUrl,
                          ),
                  ),
                ),
                CommonWidget.rowHeight(height: 12),
                NormalText(
                  text: 'Edit Picture',
                  fontSize: 14,
                ),
                CommonWidget.rowHeight(height: 24),
                ...[
                  {
                    'key': 'Name',
                    'value':
                        '${controller.profileDetails.value!.firstName} ${controller.profileDetails.value!.lastName}'
                  },
                  {
                    'key': 'Email',
                    'value': '${controller.profileDetails.value!.emailId}'
                  },
                  {
                    'key': 'Phone Number',
                    'value': '${controller.profileDetails.value!.mobileNumber}'
                  },
                ].map(
                  (Map e) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalText(
                          text: e['key'],
                          fontSize: 10,
                        ),
                        CommonWidget.rowHeight(height: 6),
                        NormalText(
                          text: e['value'],
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        CommonWidget.rowHeight(height: 10),
                        Divider(
                          color: const Color(0xFFE2E2E2),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                    onTap: () => Get.toNamed( Routes.ACCOUNT+ Routes.EDIT_PROFILE),
                    child: NormalText(text: 'Edit Profile')),
                Spacer(),
              ],
            )),
      ),
    );
  }
}
