import 'package:flutter/cupertino.dart';

class AppFocus {
  static void unfocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void focus(BuildContext context) {
    FocusScope.of(context).requestFocus();
  }
}
