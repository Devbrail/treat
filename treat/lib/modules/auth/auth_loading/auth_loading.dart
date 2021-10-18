import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/modules/splash/widgets/loading_page.dart';
import 'package:treat/routes/routes.dart';

class AuthLoading extends StatefulWidget {
  AuthLoading({Key? key}) : super(key: key);

  @override
  _AuthLoadingState createState() => _AuthLoadingState();
}

class _AuthLoadingState extends State<AuthLoading> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3))
        .then((value) => Get.offAllNamed(Routes.HOME));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingPage(
      title: 'Verifying Credentials',
    );
  }
}
