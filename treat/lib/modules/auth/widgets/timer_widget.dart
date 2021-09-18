import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/modules/auth/auth.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/utils/common_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class TimerWidget extends StatefulWidget {
  final Color textColor;
  const TimerWidget({
    Key? key,
    required this.textColor,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? timer;
  int _start = 60;
  int attempts = 1;
  AuthController authController = Get.arguments;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  void startTimer() {
    _start = 60;
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(62),
      child: Column(
        children: [
          NormalText(
            text: '00:${_start.toString().padLeft(2, '0')}',
            textColor: widget.textColor,
            fontSize: 65,
          ),
          CommonWidget.rowHeight(height: 22),
          InkWell(
            onTap: () {
              if (attempts == 3)
                CommonWidget.toast('Already took maximum try');
              else if (_start != 0) {
                CommonWidget.toast('Please wait for few seconds');
              } else {
                startTimer();
                ++attempts;
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: NormalText(
                text: 'Resend Code',
                textColor: ColorConstants.textColorBlack,
                fontSize: 18,
              ),
            ),
          ),
          CommonWidget.rowHeight(height: 18),
          NormalText(
            text: 'New OTP sent',
            textColor: widget.textColor,
            fontSize: 16,
          ),
          NormalText(
            text: '$attempts out of 3 attempts remaining',
            textColor: widget.textColor,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}
