import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/text_widget.dart';

import 'account_controller.dart';

class MySavings extends StatefulWidget {
  const MySavings({Key? key}) : super(key: key);

  @override
  _MySavingsState createState() => _MySavingsState();
}

class _MySavingsState extends State<MySavings>
    with SingleTickerProviderStateMixin {
  AccountController accountController = Get.find<AccountController>();
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    accountController.iniMonths();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Obx(() => Column(
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
                            size: 48,
                            color: Colors.black,
                          ),
                        ),
                        NormalText(
                          text: 'My Savings',
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
                                text: 'This Year',
                              ),
                              Tab(
                                text: 'This Month',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFEFEFEF),
                              borderRadius: BorderRadius.circular(7)),
                          padding: EdgeInsets.all(8),
                          child: Image.asset('$IMAGE_PATH/savings_item.png'),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Container(
                          height: 74,
                          margin: EdgeInsets.only(top: 24),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: FractionalOffset.centerLeft,
                              end: FractionalOffset.centerRight,
                              colors: [
                                const Color(0xFF42BA84),
                                const Color(0xFF51C991),
                              ],
                              stops: [0.0, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  NormalText(
                                    text: 'Total Savings',
                                    fontSize: 20,
                                    textColor: ColorConstants.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  Spacer(),
                                  NormalText(
                                    text: 'CAD',
                                    fontSize: 14,
                                    textColor: ColorConstants.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: NormalText(
                                  text: '\$120',
                                  fontSize: 28,
                                  textColor: ColorConstants.white,
                                  textAlign: TextAlign.end,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: buildSavingBox(colors: [
                                const Color(0xFFDD80FF),
                                const Color(0xFFBE87E5),
                              ], label: 'Dine In', value: 20),
                            ),
                            SizedBox(width: 9),
                            Expanded(
                              child: buildSavingBox(colors: [
                                const Color(0xFFFCCC00),
                                const Color(0xFFFFB000),
                              ], label: 'Entertainment', value: 20),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: buildSavingBox(colors: [
                                const Color(0xFFFF6D53),
                                const Color(0xFFEF7C7C),
                              ], label: 'Dine In', value: 30),
                            ),
                            SizedBox(width: 9),
                            Expanded(
                              child: buildSavingBox(colors: [
                                const Color(0xFF35B5ED),
                                const Color(0xFF69C7EA),
                              ], label: 'Entertainment', value: 50),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 32,
                    color: ColorConstants.containerAshBackgroundColor,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...accountController.months!.map(
                            (e) => InkWell(
                              onTap: () {
                                accountController.selectMonth(e['id']);
                              },
                              child: Container(
                                width: e['isSelected'] ? 35 : null,
                                height: e['isSelected'] ? 50 : null,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: e['isSelected']
                                    ? BoxDecoration(
                                        color: const Color(0xFF7E7E7E),
                                        borderRadius:
                                            BorderRadius.circular(100))
                                    : null,
                                child: NormalText(
                                  text: e['title'],
                                  fontSize: 8,
                                  textColor: e['isSelected']
                                      ? ColorConstants.white
                                      : Color(0xFF797979),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  NormalText(
                    text: 'Biggest Savings',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    textColor: ColorConstants.redemptionTextBlack,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        Container(
                          height: 16,
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF35B5ED),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(7),
                              topLeft: Radius.circular(7),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NormalText(
                                text: 'GROCERY',
                                textColor: ColorConstants.white,
                                textAlign: TextAlign.start,
                                fontSize: 9,
                              ),
                              NormalText(
                                text: 'B12N34M56',
                                textColor: ColorConstants.white,
                                textAlign: TextAlign.start,
                                fontSize: 9,
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 73,
                            decoration: BoxDecoration(
                              color: ColorConstants.whiteGrey,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14),
                              ),
                            ),
                            child: Column(
                              children: [],
                            )),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Container buildSavingBox({colors, label, value}) {
    return Container(
      height: 110,
      margin: EdgeInsets.only(top: 9),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
          colors: colors,
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NormalText(
            text: label,
            fontSize: 20,
            textColor: ColorConstants.white,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(
            height: 4,
          ),
          NormalText(
            text: 'CAD',
            fontSize: 14,
            textColor: ColorConstants.white,
            fontWeight: FontWeight.bold,
          ),
          Spacer(),
          NormalText(
            text: '\$$value',
            fontSize: 28,
            textColor: ColorConstants.white,
            textAlign: TextAlign.end,
            fontWeight: FontWeight.w800,
          ),
        ],
      ),
    );
  }
}
