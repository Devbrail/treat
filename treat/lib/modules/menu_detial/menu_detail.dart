import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:get/get.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class MenuPDFView extends StatefulWidget {
  final String url;
  final String storeName;
  final List<String> menus;

  MenuPDFView({
    Key? key,
    required this.url,
    required this.storeName,
    required this.menus,
  }) : super(key: key);

  _MenuPDFViewState createState() => _MenuPDFViewState();
}

class _MenuPDFViewState extends State<MenuPDFView> {
  GlobalKey pdfKey = GlobalKey();

  final ValueNotifier<String> _notifier = ValueNotifier<String>('');
  bool loading = true;

  static const platform = const MethodChannel('treat.flutter.pdf/pdfviewer');
  String? pdfPath;

  @override
  void initState() {
    super.initState();

    _notifier.value = widget.url;
    url = widget.url;

    if (Platform.isIOS) {
      getPdf();
    }
  }

  void getPdf() async {
    pdfPath = _notifier.value;
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  late String url;

  @override
  Widget build(BuildContext context) {
    double screenHeight = Get.height;
    double screenWidth = Get.width;

    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.portrait) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonWidget.actionbutton(
                            onTap: () => Get.back(),
                            text: 'BACK',
                            height: 26,
                            buttoncolor: ColorConstants.black,
                            textColor: ColorConstants.white,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: NormalText(
                              text: widget.storeName,
                              textColor: ColorConstants.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container()
                        ],
                      ),
                    ),
                    Platform.isIOS
                        ? loading
                            ? Flexible(
                                fit: FlexFit.loose,
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : Flexible(
                                fit: FlexFit.loose,
                                child: Center(
                                  child: UiKitView(
                                    viewType: 'pdfView',
                                    onPlatformViewCreated: (id) async {
                                      try {
                                        await platform
                                            .invokeMethod('displayPdf', {
                                          "url": pdfPath,
                                        });
                                      } catch (e) {}
                                    },
                                  ),
                                ),
                              )
                        : Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 14),
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  if (loading)
                                    Container(
                                      width: screenWidth,
                                      height: screenHeight * .9,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  if (widget.url.isEmpty)
                                    Container(
                                      width: screenWidth,
                                      height: screenHeight * .9,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Notes not available',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  buildPDFView(screenWidth, screenHeight, url),
                                  if (loading)
                                    Container(
                                      width: screenWidth,
                                      height: screenHeight * .9,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
                if (widget.menus.length > 1)
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.all(32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            switchPDF(false);
                          },
                          child: Image.asset(
                            '$IMAGE_PATH/undo.png',
                            width: 48,
                            height: 48,
                            color: ColorConstants.textBlack,
                          ),
                        ),
                        CommonWidget.rowWidth(width: 32),
                        InkWell(
                          onTap: () {
                            switchPDF(true);
                          },
                          child: Image.asset(
                            '$IMAGE_PATH/share.png',
                            width: 48,
                            height: 48,
                            color: ColorConstants.textBlack,
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
      } else
        return Container();
    });
  }

  Container buildPDFView(
      double screenWidth, double screenHeight, String value) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: PDFView.fromUrl(
        value,
        cache: true,
        // password: widget.password,
        onDownload: (f) {
          //print("downloaded file! $f");
          // setState(() {
          //   // loading = true;
          // });
        },
        onLoad: () {
          setState(() {
            loading = false;
          });
        },
        swipeHorizontal: true,
      ),
    );
  }

  switchPDF(bool isNext) {
    int l = widget.menus.length;
    for (int i = 0; i < l; i++) {
      if (widget.menus[i] == url) {
        'current url '.printInfo();

        if (isNext) {
          'iternatio number $i condn${widget.menus[i] == url} - ${i != l - 1 ? i + 1 : 0} - current url '
              .printInfo();
          url = widget.menus[i != l - 1 ? i + 1 : 0];
          setState(() {
            loading = true;
          });
          break;
        } else {
          url = widget.menus[i == 0 ? l - 1 : i - 1];
          setState(() {
            loading = true;
          });
          break;
        }
        // '$l after url ${url}'.printInfo();
      }
    }
  }
}
