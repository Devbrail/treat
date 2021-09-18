import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CommonWidget {
  static AppBar appBar(
      BuildContext context, String title, IconData? backIcon, Color color,
      {void Function()? callback}) {
    return AppBar(
      leading: backIcon == null
          ? null
          : IconButton(
              icon: Icon(backIcon, color: color),
              onPressed: () {
                if (callback != null) {
                  callback();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: color, fontFamily: 'Rubik'),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  static SizedBox rowHeight({double height = 30}) {
    return SizedBox(height: height);
  }

  static SizedBox rowWidth({double width = 30}) {
    return SizedBox(width: width);
  }

  static void toast(String error) async {
    await Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static Widget actionbutton(
          {required String text,
          required Color buttoncolor,
          required Color textColor,
          double height = 28,
          double width = 64,
          EdgeInsets margin = const EdgeInsets.all(14),
          Function()? onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          margin: margin,
          decoration: BoxDecoration(
            color: buttoncolor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.8),
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text.tr,
              style: TextStyle(
                  fontSize: 16, color: textColor, fontFamily: 'Rubik'),
            ),
          ),
        ),
      );
}
