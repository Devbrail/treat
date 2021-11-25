import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/constants/constants.dart';
import 'package:treat/shared/utils/common_widget.dart';
import 'package:treat/shared/widgets/auth_input_field.dart';
import 'package:treat/shared/widgets/image_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class EditProfile extends GetView<HomeController> {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                    buttoncolor: ColorConstants.black,
                    textColor: ColorConstants.white,
                  ),
                  InkWell(
                    onTap: () => controller.saveUserInfo(),
                    child: NormalText(
                      text: 'Save',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            CommonWidget.rowHeight(height: 12),
            Obx(() => ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 74,
                    width: 74,
                    color: ColorConstants.filterDropDownSelected,
                    alignment: Alignment.center,
                    child: controller.profileDetails.value == null
                        ? IconButton(
                            onPressed: () => controller.uploadImage(),
                            icon: Icon(
                              Icons.camera_enhance,
                              size: 38,
                              color: const Color(0xFF8B8B8B),
                            ),
                          )
                        : controller.profileDetails.value!.assetUploadedFile !=
                                null
                            ? Image.file(controller
                                .profileDetails.value!.assetUploadedFile)
                            : ImageWidget(
                                image:
                                    controller.profileDetails.value!.assetId),
                  ),
                )),
            CommonWidget.rowHeight(height: 12),
            InkWell(
              onTap: () => controller.uploadImage(),
              child: NormalText(
                text: 'Change Avatar',
                fontSize: 14,
              ),
            ),
            CommonWidget.rowHeight(height: 24),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalText(
                          text: 'First Name',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        AuthTextField(
                            hint: 'First Name',
                            controller: controller.firstNameTC,
                            fillColor: ColorConstants.white,
                            padding: EdgeInsets.only(left: 2)),
                      ],
                    ),
                  ),
                  CommonWidget.rowWidth(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        NormalText(
                          text: 'Last Name',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        AuthTextField(
                            hint: 'Last Name',
                            controller: controller.lastNameTC,
                            fillColor: ColorConstants.white,
                            padding: EdgeInsets.only(left: 2)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
