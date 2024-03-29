import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:treat/models/filter_modal.dart';
import 'package:treat/models/response/search_response.dart';
import 'package:treat/modules/store_detail/widgets/menu_chip.dart';
import 'package:treat/modules/store_search/search.dart';
import 'package:treat/routes/routes.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';
import 'package:treat/shared/widgets/image_widget.dart';
import 'package:treat/shared/widgets/rating_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

import 'search_shimmer.dart';

class SearchScreen extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null && Get.arguments[1].toString().isNotEmpty)
      AppFocus.unfocus(context);
    else
      AppFocus.focus(context);
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
                buttoncolor: ColorConstants.backButton,
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
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: controller.searchTC,
                onSubmitted: (s) => controller.onSearched(),
                textInputAction: TextInputAction.done,
                cursorColor: ColorConstants.black,
                style: GoogleFonts.roboto(
                  color: ColorConstants.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
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
              ),
              suggestionsCallback: (pattern) async {
                return await controller.getSuggestion(pattern);
              },
              hideOnLoading: true,
              hideOnEmpty: true,
              loadingBuilder: (context) => Text(''),
              hideSuggestionsOnKeyboardHide: false,
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text('$suggestion'),
                );
              },
              onSuggestionSelected: (suggestion) {
                controller.searchTC.text = suggestion as String;
                controller.onSearched();
              },
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
                return InkWell(
                  onTap: () {
                    if (!Utils.isAdvanced(searchResponses.couponLayout))
                      Get.toNamed(Routes.RetailMenu, arguments: [
                        CommonConstants.dine,
                        searchResponses.storeId
                      ]);
                    else
                      Get.toNamed(Routes.EVERYDAY, arguments: [
                        CommonConstants.dine,
                        searchResponses.storeId.toString()
                      ]);
                  },
                  child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  Rating(
                                    rating: searchResponses.rating,
                                    size: 16,
                                    isTapOnly: true,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 2),
                                    unratedColor: const Color(0xFFB7B7B7),
                                    onRatingUpdate: (rating) {},
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
                      ],
                    ),
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
          child: GetBuilder<SearchController>(
              id: 'T',
              builder: (controller) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstants.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(30.0),
                          topRight: const Radius.circular(30.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.generateDropDow();
                              controller.updateFilter();
                              Get.back();
                            },
                            child: NormalText(
                              text: 'Reset',
                              fontSize: 16,
                              textColor: ColorConstants.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          NormalText(
                            text: 'Sort & Filter',
                            fontSize: 21,
                            textColor: ColorConstants.black,
                            fontWeight: FontWeight.bold,
                          ),
                          CommonWidget.actionbutton(
                              text: 'Save',
                              buttoncolor: ColorConstants.textBlack,
                              textColor: ColorConstants.white,
                              margin: EdgeInsets.zero,
                              onTap: () {
                                searchController.getResults();
                                Get.back();
                              })
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            color: ColorConstants.white,
                            width: Get.width * .4,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: controller.currentFilterIdx == 4
                                  ? GridView.builder(
                                      itemCount: controller.filtersBody.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Data e = controller.filtersBody[index];
                                        return InkWell(
                                          onTap: () =>
                                              controller.updateFilters(e),
                                          child: Opacity(
                                            opacity: e.isSelected ? 1 : 0.5,
                                            child: Container(
                                              width: 48,
                                              height: 48,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              child: ImageWidget(
                                                image: e.assetId,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (controller.currentFilterIdx == 2)
                                          SizedBox(height: 16),
                                        ...controller.filtersBody.map(
                                          (e) => InkWell(
                                            onTap: () =>
                                                controller.updateFilters(e),
                                            child: (controller
                                                        .currentFilterIdx) ==
                                                    2
                                                ? Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 14,
                                                            vertical: 8),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      color: e.isSelected
                                                          ? ColorConstants
                                                              .textBlack
                                                          : ColorConstants
                                                              .white,
                                                    ),
                                                    child: Rating(
                                                      rating:
                                                          double.parse(e.key),
                                                      size: 24,
                                                      onRatingUpdate: (dd) {},
                                                    ),
                                                  )
                                                : Container(
                                                    child: MenuChip(
                                                      text: e.key,
                                                      bGColor: e.isSelected
                                                          ? ColorConstants
                                                              .textBlack
                                                          : ColorConstants
                                                              .white,
                                                      textColor: e.isSelected
                                                          ? ColorConstants.white
                                                          : ColorConstants
                                                              .textColorBlack,
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: controller
                                                                      .currentFilterIdx ==
                                                                  3
                                                              ? 16
                                                              : 8,
                                                          vertical: 4),
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
                    )
                  ],
                );
              }),
        );
      },
    );
  }

  var tits = ['Sort By', 'Category', 'Rating', 'Price Range', 'Amenities'];
}
