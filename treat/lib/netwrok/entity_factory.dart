// Factory to generate models from generic json response

import 'package:treat/models/response/store_details.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (T.toString() == "StoreDetails") {
      return StoreDetails.fromJson(json) as T;
    } else {
      return -1 as T;
    }
  }
}

/*
{"version":"v0.1.3","detail":"Given token not valid for any token type",
"code":"token_not_valid",
"messages":[{"token_class":"AccessToken","token_type":"access","message":"Token is invalid or expired"}],
"errors":[],"meta":{"type":"post","action":"create"}}
 */
