import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/utils/size_config.dart';
import 'package:treat/shared/widgets/text_widget.dart';

import '../splash_screen.dart';
import 'loading_painter.dart';

class LoadingPage extends StatefulWidget {
  final String? title;

  const LoadingPage({
    Key? key,
    this.title,
  }) : super(key: key);
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController rippleController;
  late AnimationController centerCircleController;

  late Animation<double> rippleRadius;
  late Animation<double> rippleOpacity;
  late Animation<double> centerCircleRadius;

  @override
  void initState() {
    rippleController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 2500,
      ),
    );
    rippleRadius = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: rippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            rippleController.repeat();
            rippleController.forward();
          } else if (status == AnimationStatus.dismissed) {
            rippleController.forward();
          }
        },
      );

    rippleOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: rippleController,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    centerCircleController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1250,
      ),
    );
    centerCircleRadius = Tween<double>(begin: 22, end: 16).animate(
        CurvedAnimation(
            parent: centerCircleController,
            curve: Curves.ease,
            reverseCurve: Curves.easeInOut))
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            centerCircleController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            centerCircleController.forward();
          }
        },
      );

    Timer(
      Duration(milliseconds: 1600),
      () {
        rippleController.forward();
      },
    );
    centerCircleController.forward();
    super.initState();
  }

  @override
  void dispose() {
    rippleController.dispose();
    centerCircleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          body: Center(
            child: Container(
              height: double.infinity,
              width: displayWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    ColorConstants.violet,
                    ColorConstants.lightViolet,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [
                    0.0,
                    1.0,
                  ],
                ),
              ),
              child: CustomPaint(
                painter: MyPainter(
                  rippleRadius.value,
                  rippleOpacity.value,
                  centerCircleRadius.value,
                ),
              ),
            ),
          ),
        ),
        if (widget.title != null)
          Container(
            margin: EdgeInsets.only(top: SizeConfig().screenHeight * .4),
            child: Center(
              child: NormalText(
                text: widget.title!,
                textColor: ColorConstants.white,
                fontSize: 24,
              ),
            ),
          ),
      ],
    );
  }
}
