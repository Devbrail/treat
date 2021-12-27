import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/modules/splash/widgets/loading_page.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Utils.setStatusBarColor(color: const Color(0xFF403389));
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.topCenter,

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('$IMAGE_PATH/splach_bck.png'),
          fit: BoxFit.fill
        ),
      ),
      child: Container(
        height: Get.height * .5,
         alignment: Alignment.bottomCenter,

        child: Image.asset('$IMAGE_PATH/splash_icon.png'),
      ),
    );
  }
}
