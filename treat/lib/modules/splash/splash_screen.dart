import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treat/modules/splash/widgets/loading_page.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return LoadingPage(
      title: '',
    );
  }
}
