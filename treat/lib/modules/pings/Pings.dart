import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:treat/models/response/Ping.dart';
import 'package:treat/models/response/savings_list.dart';
import 'package:treat/modules/account/account_controller.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class Pings extends StatefulWidget {
  const Pings({Key? key}) : super(key: key);

  @override
  _PingsState createState() => _PingsState();
}

class _PingsState extends State<Pings> with SingleTickerProviderStateMixin {
  AccountController accountController = Get.find<AccountController>();
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    accountController.getPings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 12, top: 34, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: Get.back,
                      child: Icon(
                        Icons.chevron_left,
                        size: 38,
                        color: Colors.black,
                      ),
                    ),
                    NormalText(
                      text: 'Pings',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      textColor: ColorConstants.redemptionTextBlack,
                    ),
                    Icon(
                      Icons.chevron_left,
                      size: 48,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 35,
                      width: 210,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          9.0,
                        ),
                      ),
                      child: TabBar(
                        controller: tabController,
                        onTap: (value) {
                          setState(() {});
                        },
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            9.0,
                          ),
                          color: Color(0xFF606060),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Color(0xFFA2A2A2),
                        tabs: [
                          Tab(
                            text: 'Received',
                          ),
                          Tab(
                            text: 'Sent',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              buildSavingsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSavingsList() {
    return GetBuilder<AccountController>(
        id: 'rp',
        builder: (ctrl) {
          List<PingSummaries> receivedPings = ctrl.receivedPings;
          return Column(
            children: [
              ...receivedPings.map(
                (e) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ctrl.getColor(e.storeDetails!.category!),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(7),
                            topLeft: Radius.circular(7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NormalText(
                              text: e.storeDetails!.category!,
                              textColor: ColorConstants.white,
                              textAlign: TextAlign.start,
                              fontSize: 9,
                            ),
                            NormalText(
                              text: 'e.referenceCode!',
                              textColor: ColorConstants.white,
                              textAlign: TextAlign.start,
                              fontSize: 9,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // height: 73,
                        decoration: BoxDecoration(
                          color: ColorConstants.whiteGrey,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(14),
                            bottomRight: Radius.circular(14),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child: CachedNetworkImage(
                                        height: 50,
                                        width: 50,
                                        imageUrl:
                                            e.couponDetails!.couponAssetId!,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        NormalText(
                                          text: e.storeDetails!.storeName!,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          textColor: ColorConstants
                                              .redemptionTextBlack,
                                          textAlign: TextAlign.start,
                                        ),
                                        NormalText(
                                          text: e.couponDetails!
                                              .couponDescription!,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        NormalText(
                                            text: 'Sent by : ${e.pingedBy!}',
                                            fontSize: 12),
                                        NormalText(
                                            text: 'Expires by : ',
                                            fontSize: 12),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 4,bottom: 6, left: 8),
                        child: RichText(
                          text: TextSpan(
                            text: 'Status : ',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.redemptionTextBlack
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${e.couponDetails!.status!}',
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF5BAF88)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
