import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/text_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              color: Colors.yellow,
              width: double.infinity,
              height: SizeConfig().screenHeight * .3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.rowHeight(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: CommonWidget.actionbutton(
                      onTap: () => Get.back(),
                      text: 'BACK',
                      height: 26,
                      buttoncolor: ColorConstants.backButton,
                      textColor: ColorConstants.white,
                      margin: EdgeInsets.all(24),
                    ),
                  ),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: NormalText(
                      text: 'Terms and\nConditions',
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: WebView(
                initialUrl:
                    'https://treatstorage.blob.core.windows.net/openassets/TNC.htm',
              ),
            )
          ],
        ));
  }
}
