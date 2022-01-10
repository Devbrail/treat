import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:treat/models/response/savings_list.dart';
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
  PageController _pageController =
      PageController(viewportFraction: .1, initialPage: 6);
  int _currentIndex = 6;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    accountController.iniMonths();
    accountController.getSavingsList('2021/0');
    super.initState();
  }

  late InfiniteScrollController IFController = InfiniteScrollController();
  late InfiniteScrollController IFControllerYrGph = InfiniteScrollController();
  late InfiniteScrollController IFControllerYr = InfiniteScrollController();
  late InfiniteScrollController IFControllerSlider = InfiniteScrollController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: GetBuilder<AccountController>(
              id: 'loading',
              builder: (controller) {
                if (controller.isLoading)
                  return Center(child: CircularProgressIndicator());
                return SingleChildScrollView(
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
                                  accountController
                                      .updateTenureType(value == 0);
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
                                    text: 'Lifetime',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 24),
                            GetBuilder<AccountController>(
                                id: 'i',
                                builder: (controller) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstants
                                            .containerAshBackgroundColor,
                                        borderRadius: BorderRadius.circular(7)),
                                    padding: EdgeInsets.all(8),
                                    child: InkWell(
                                      child: Image.asset(
                                          '$IMAGE_PATH/${accountController.isGraphView ? 'savings_item' : 'saving_graph'}.png'),
                                      onTap: () {
                                        accountController.updateGraphView();
                                      },
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                      GetBuilder<AccountController>(
                          id: 'i',
                          builder: (controller) {
                            return Column(
                              children: [
                                if (controller.isLifeTime)
                                  Column(
                                    children: [
                                      if (controller.isGraphView)
                                        buildYGraph(controller)
                                      else
                                        buildContainerView(controller,
                                            isYearly: false),
                                      buildSliderPicker(controller,
                                          itemCount: 12)
                                    ],
                                  )
                                else
                                  Column(
                                    children: [
                                      if (controller.isGraphView)
                                        buildLtGraph(controller)
                                      else
                                        buildContainerView(controller,
                                            isYearly: true),
                                      buildSliderPicker(controller,
                                          itemCount: 2, loop: false)
                                    ],
                                  ),
                              ],
                            );
                          }),
                      SizedBox(
                        height: 24,
                      ),
                      if (accountController.savingsByStores!.length > 0)
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
                      GetBuilder<AccountController>(
                          id: 'l',
                          builder: (ctrl) {
                            List<SavingsByStores>? savingsByStores =
                                ctrl.savingsByStores;

                            return Column(
                              children: [
                                ...savingsByStores!.map(
                                  (e) => Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 4),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 16,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 14),
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: controller
                                                .getColor(e.storeCategory!),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(7),
                                              topLeft: Radius.circular(7),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              NormalText(
                                                text: e.storeCategory!,
                                                textColor: ColorConstants.white,
                                                textAlign: TextAlign.start,
                                                fontSize: 9,
                                              ),
                                              NormalText(
                                                text: e.referenceCode!,
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 14),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Container(
                                                        height: 50,
                                                        width: 50,
                                                        child:
                                                            CachedNetworkImage(
                                                          height: 50,
                                                          width: 50,
                                                          imageUrl:
                                                              e.logoAssetUrl!,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 14),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          NormalText(
                                                            text: e.storeName!,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            textColor:
                                                                ColorConstants
                                                                    .redemptionTextBlack,
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                          NormalText(
                                                            text: e
                                                                .redemptionDate!,
                                                            fontSize: 12,
                                                          ),
                                                          NormalText(
                                                              text: e
                                                                  .storeLocation!,
                                                              fontSize: 12),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        NormalText(
                                                          text: 'You Saved',
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          textColor: ColorConstants
                                                              .redemptionTextBlack,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 3),
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 4),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  ColorConstants
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                          child: NormalText(
                                                            text:
                                                                '\$${e.savedAmount}',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            textColor:
                                                                ColorConstants
                                                                    .redemptionTextBlack,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Column buildYGraph(AccountController controller) {
    return Column(
      children: [
        Container(
          height: Get.height / 3.5,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: InfiniteCarousel.builder(
              itemCount: 12,
              itemExtent: 70,
              center: true,
              physics: NeverScrollableScrollPhysics(),
              onIndexChanged: (index) {},
              controller: IFController,
              axisDirection: Axis.horizontal,
              loop: true,
              itemBuilder: (context, index, realIndex) {
                Map cMonth =
                    controller.months![index % controller.months!.length];
                if (cMonth['isSelected']) IFController.animateToItem(index);
                Map content = controller.getChartData(cMonth["id"] + 1);

                return Container(
                  margin: EdgeInsets.only(top: content['height'] / 2),
                  child: Column(
                    children: [
                      if (content['height'] > 0)
                        Container(
                          child: NormalText(text: content['total']),
                        ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          color: cMonth['isSelected']
                              ? ColorConstants.graphDineIn
                              : ColorConstants.containerAshBackgroundColor,
                          child: Column(
                            children: [
                              ...content['splits'].map(
                                (e) => Expanded(
                                  flex: e['value']!.toInt(),
                                  child: Container(
                                    color: cMonth['isSelected']
                                        ? e['color']
                                        : ColorConstants
                                            .containerAshBackgroundColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...[
                {
                  'color': ColorConstants.graphDineIn,
                  'text': 'Dine In',
                },
                {
                  'color': ColorConstants.graphGrocery,
                  'text': 'Grocery',
                },
                {
                  'color': ColorConstants.graphRetail,
                  'text': 'Retail',
                },
                {
                  'color': ColorConstants.graphEntertainment,
                  'text': 'Entertainment',
                },
              ].map(
                (Map e) => Row(
                  children: [
                    Container(
                      height: 14,
                      width: 14,
                      color: e['color'],
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    NormalText(
                      text: e['text'],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column buildLtGraph(AccountController controller) {
    return Column(
      children: [
        Container(
          height: Get.height / 3.5,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: InfiniteCarousel.builder(
              itemCount: 2,
              itemExtent: 70,
              center: true,
              physics: NeverScrollableScrollPhysics(),
              onIndexChanged: (index) {},
              controller: IFController,
              axisDirection: Axis.horizontal,
              loop: false,
              itemBuilder: (context, index, realIndex) {
                Map cMonth =
                    controller.years![index % controller.years!.length];

                Map content = controller.getChartData(cMonth["title"]);

                return Container(
                  margin: EdgeInsets.only(top: content['height'] / 2),
                  child: Column(
                    children: [
                      if (content['height'] > 0)
                        Container(
                          child: NormalText(text: content['total']),
                        ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          color: cMonth['isSelected']
                              ? ColorConstants.graphDineIn
                              : ColorConstants.containerAshBackgroundColor,
                          child: Column(
                            children: [
                              ...content['splits'].map(
                                (e) => Expanded(
                                  flex: e['value']!.toInt(),
                                  child: Container(
                                    color: cMonth['isSelected']
                                        ? e['color']
                                        : ColorConstants
                                            .containerAshBackgroundColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...[
                {
                  'color': ColorConstants.graphDineIn,
                  'text': 'Dine In',
                },
                {
                  'color': ColorConstants.graphGrocery,
                  'text': 'Grocery',
                },
                {
                  'color': ColorConstants.graphRetail,
                  'text': 'Retail',
                },
                {
                  'color': ColorConstants.graphEntertainment,
                  'text': 'Entertainment',
                },
              ].map(
                (Map e) => Row(
                  children: [
                    Container(
                      height: 14,
                      width: 14,
                      color: e['color'],
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    NormalText(
                      text: e['text'],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  SizedBox buildSliderPicker(AccountController controller,
      {itemCount, scrollController, loop = true}) {
    return SizedBox(
      height: 42,
      child: InfiniteCarousel.builder(
        itemCount: itemCount,
        itemExtent: 42,
        center: true,
        physics: NeverScrollableScrollPhysics(),
        onIndexChanged: (index) {},
        controller: IFControllerSlider,
        axisDirection: Axis.horizontal,
        loop: loop,
        itemBuilder: (context, index, realIndex) {
          Map e;
          if (!loop)
            e = controller.years![index % controller.months!.length];
          else
            e = controller.months![index % controller.months!.length];
          return InkWell(
            onTap: () {
              if (!loop)
                controller.selectTenureYear(e['id']);
              else
                controller.selectTenure(e['id']);
              IFControllerSlider.animateToItem(index);
              IFController.animateToItem(index);
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.containerAshBackgroundColor,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 6),
                ),
                Container(
                  width: e['isSelected'] ? 65 : null,
                  height: e['isSelected'] ? 50 : null,
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.symmetric(vertical: e['isSelected'] ? 0 : 6),
                  decoration: e['isSelected']
                      ? BoxDecoration(
                          color: const Color(0xFF7E7E7E),
                          borderRadius: BorderRadius.circular(100))
                      : BoxDecoration(
                          color: ColorConstants.containerAshBackgroundColor),
                  child: NormalText(
                    text: e['title'],
                    fontSize: e['isSelected'] ? 16 : 8,
                    textColor: e['isSelected']
                        ? ColorConstants.white
                        : Color(0xFF797979),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildContainerView(AccountController controller,
      {required bool isYearly}) {
    print('curent selcted in container $isYearly');
    Map content = controller.getChartData(controller.currentMonth + 1);
    return Container(
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
                    text: '\$${content['total']}',
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
                child: buildSavingBox(
                    colors: [
                      const Color(0xFFDD80FF),
                      const Color(0xFFBE87E5),
                    ],
                    label: 'Dine In',
                    value: controller.getEarnings(content, 'Dine-In')),
              ),
              SizedBox(width: 9),
              Expanded(
                child: buildSavingBox(
                    colors: [
                      const Color(0xFFFCCC00),
                      const Color(0xFFFFB000),
                    ],
                    label: 'Entertainment',
                    value: controller.getEarnings(content, 'Entertainment')),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: buildSavingBox(
                    colors: [
                      const Color(0xFFFF6D53),
                      const Color(0xFFEF7C7C),
                    ],
                    label: 'Retail',
                    value: controller.getEarnings(content, 'Retail')),
              ),
              SizedBox(width: 9),
              Expanded(
                child: buildSavingBox(
                    colors: [
                      ColorConstants.graphGrocery,
                      const Color(0xFF69C7EA),
                    ],
                    label: 'Everyday',
                    value: controller.getEarnings(content, 'Everyday')),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
        ],
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
