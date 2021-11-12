import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treat/models/response/search_response.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/modules/home/tabs/tabs.dart';
import 'package:treat/modules/store_detail/widgets/menu_chip.dart';
import 'package:treat/modules/store_search/search.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/favourite.dart';
import 'package:treat/shared/widgets/image_widget.dart';
import 'package:treat/shared/widgets/rating_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

import 'search_shimmer.dart';

class SearchScreen extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    printInfo(info: 'dnsfdjkfns.dkj   ${Get.arguments}');

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => true,
        child: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget() {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              CommonWidget.actionbutton(
                onTap: () => Get.back(),
                text: 'BACK',
                height: 26,
                buttoncolor: ColorConstants.black,
                textColor: ColorConstants.white,
                // margin: EdgeInsets.only(top: 32, left: 24),
              ),
            ],
          ),
          Container(
            height: 34,
            margin: EdgeInsets.only(top: 18, bottom: 14, right: 21, left: 21),
            decoration: BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(18)),
            alignment: Alignment.center,
            child: TextField(
              controller: controller.searchTC,
              // autofocus: true,
              onSubmitted: (s) => controller.onSearched(),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                focusColor: ColorConstants.black,
                hintStyle: GoogleFonts.roboto(
                  color: ColorConstants.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: ColorConstants.black,
                ),
                border: InputBorder.none,
              ),
              style: GoogleFonts.roboto(
                color: ColorConstants.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              cursorColor: ColorConstants.black,
            ),
          ),
          GetBuilder<SearchController>(
              id: 0,
              builder: (search) {
                if (search.loading.value)
                  return SearchShimmer();
                else
                  return BuildResult(search);
              })
        ],
      ),
    );
  }
}

class BuildResult extends StatelessWidget {
  final SearchController searchController;

  // final List<SearchResponses> result;

  BuildResult(
    this.searchController, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<SearchResponses> result = searchController.searchResponses;
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                SearchResponses searchResponses = result[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Row(
                    children: [
                      ImageWidget(
                          image: searchResponses.assetId,
                          width: 64,
                          height: 54),
                      CommonWidget.rowWidth(width: 8),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NormalText(
                              text: searchResponses.title,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  '$IMAGE_PATH/man-walking.png',
                                  width: 10,
                                  height: 13,
                                ),
                                NormalText(
                                  text: '  ${searchResponses.distance} ',
                                  fontSize: 14,
                                  textColor: ColorConstants.textBlack,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: ColorConstants.ratingBarYellow,
                                ),
                                Expanded(
                                  child: NormalText(
                                    text: '  Barrington',
                                    fontSize: 14,
                                    textAlign: TextAlign.start,
                                    textColor: ColorConstants.textBlack,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Rating(
                                    rating: searchResponses.rating.toDouble(),
                                  ),
                                ),
                                NormalText(
                                  text: '  ${searchResponses.rating}',
                                  fontSize: 14,
                                  textColor: ColorConstants.textBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // FavouriteButton(
                      //   onClick: () {},
                      //   isFavourite: true,
                      //   storeID: 5,
                      // ),
                    ],
                  ),
                );
              }),
          Positioned(
            bottom: 14,
            right: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                showBottomModalSheet(context, searchController);
              },
              child: Container(
                height: 48,
                margin: EdgeInsets.symmetric(horizontal: 104),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF484848),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NormalText(
                      text: 'Filters',
                      fontSize: 20,
                      textColor: ColorConstants.white,
                      fontWeight: FontWeight.bold,
                    ),
                    Image.asset(
                      '$IMAGE_PATH/settings.png',
                      width: 24,
                      height: 24,
                      color: ColorConstants.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomModalSheet(
      BuildContext context, SearchController searchController) async {
    await showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 450,
          decoration: BoxDecoration(
            color: ColorConstants.filterDropDownSelected,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30.0),
                    topRight: const Radius.circular(30.0),
                  ),
                ),
                child: NormalText(
                  text: 'Sort & Filter',
                  fontSize: 21,
                  textColor: ColorConstants.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GetBuilder<SearchController>(
                  id: 'T',
                  builder: (controller) {
                    return Expanded(
                      child: Row(
                        children: [
                          Container(
                            color: ColorConstants.white,
                            width: Get.width * .4,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ...controller.filters.map(
                                  (e) => Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        controller.setCurrentTabIdx(e);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        color: e.isSelected
                                            ? ColorConstants
                                                .filterDropDownSelected
                                            : ColorConstants.white,
                                        child: NormalText(
                                          text: e.name,
                                          fontSize: 16,
                                          textAlign: TextAlign.start,
                                          fontWeight: e.isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: ColorConstants.filterDropDownSelected,
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.center,
                                children: [
                                  ...controller.filtersBody.map(
                                    (e) => InkWell(
                                      onTap: () {
                                        controller.updateFilters(e);
                                      },
                                      child: (controller.currentFilterIdx) == 2
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: e.isSelected
                                                    ? ColorConstants
                                                        .textColorBlack
                                                    : ColorConstants.white,
                                              ),
                                              child: Rating(
                                                rating: double.parse(e.key),
                                                size: 24,
                                              ),
                                            )
                                          : controller.currentFilterIdx == 4
                                              ? Opacity(
                                                  opacity:
                                                      e.isSelected ? 0.5 : 1,
                                                  child: Container(
                                                    width: 48,
                                                    height: 48,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(8),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4),
                                                    child: ImageWidget(
                                                      image: e.assetId,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  child: MenuChip(
                                                    text: e.key,
                                                    bGColor: e.isSelected
                                                        ? ColorConstants
                                                            .textColorBlack
                                                        : ColorConstants.white,
                                                    textColor: e.isSelected
                                                        ? ColorConstants.white
                                                        : ColorConstants
                                                            .textColorBlack,
                                                  ),
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
                  })
            ],
          ),
        );
      },
    );
    searchController.getResults();
  }

  var tits = ['Sort By', 'Category', 'Rating', 'Price Range', 'Amenities'];
}
