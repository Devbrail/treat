import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:treat/models/response/store_dasboard.dart';
import 'package:treat/models/response/users_response.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/modules/home/shimmers/home_shimmer.dart';
import 'package:treat/modules/store_detail/widgets/menu_chip.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/banners.dart';
import 'package:treat/shared/widgets/image_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class MainTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: true,
            expandedHeight: 100,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: buildAppBar(),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: EdgeInsets.only(bottom: 104),
            child: SingleChildScrollView(
              child: Obx(() => isLoading ? HomeSkeleton() : buildBody()),
            ),
          )),
        ],
      ),
    );
  }

  Column buildBody() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 24),
          child: AppBanner(
            banners: controller.storeDashboard.value!.banners,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 24),
          child: buildCategories(),
        ),
        Container(
          margin: EdgeInsets.only(top: 24, left: 24, right: 24),
          child: buildSearchBar(),
        ),
        if (controller.sponsoredShops.isNotEmpty)
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 24, left: 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                      text: 'Sponsored Vendors',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonWidget.rowHeight(height: 6),
                    buildVendors(controller.sponsoredShops),
                  ],
                ),
              ),
              CommonWidget.rowHeight(height: 8),
              Divider(
                color: Color(0xFFEBEBEB),
                height: 7,
                thickness: 7,
              ),
            ],
          ),
        if (controller.allNearbyShops.isNotEmpty)
          Column(
            children: [
              CommonWidget.rowHeight(height: 8),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: buildStoreItem(controller.sponsoredShops.first,
                    width: double.infinity),
              ),
              CommonWidget.rowHeight(height: 8),
              Divider(
                color: Color(0xFFEBEBEB),
                height: 7,
                thickness: 7,
              ),
            ],
          ),
        CommonWidget.rowHeight(height: 8),
        Container(
          margin: EdgeInsets.only(top: 24, left: 24),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NormalText(
                text: 'New To Treat',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CommonWidget.rowHeight(height: 6),
              buildVendors(controller.newToTreat),
            ],
          ),
        ),
        CommonWidget.rowHeight(height: 8),
        if (controller.allNearbyShops.length > 1)
          Column(
            children: [
              Divider(
                color: Color(0xFFEBEBEB),
                height: 7,
                thickness: 7,
              ),
              CommonWidget.rowHeight(height: 8),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: buildStoreItem(controller.allNearbyShops[1],
                    width: double.infinity),
              ),
            ],
          ),
        CommonWidget.rowHeight(height: 8),
        if (controller.nearbyShops.isNotEmpty)
          Column(
            children: [
              Divider(
                color: Color(0xFFEBEBEB),
                height: 7,
                thickness: 7,
              ),
              CommonWidget.rowHeight(height: 8),
              Container(
                margin: EdgeInsets.only(left: 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                      text: 'Nearby Offers',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonWidget.rowHeight(height: 8),
                    buildVendors(controller.nearbyShops),
                  ],
                ),
              ),
              CommonWidget.rowHeight(height: 8),
              Divider(
                color: Color(0xFFEBEBEB),
                height: 7,
                thickness: 7,
              ),
            ],
          ),
        CommonWidget.rowHeight(height: 14),
        if (controller.allNearbyShops.length > 2)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: buildStoreItem(controller.allNearbyShops[2],
                width: double.infinity),
          ),
        CommonWidget.rowHeight(height: 8),
        Column(
          children: [
            Divider(
              color: Color(0xFFEBEBEB),
              height: 7,
              thickness: 7,
            ),
            CommonWidget.rowHeight(height: 8),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 24, left: 24),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NormalText(
                        text: 'Top Rated',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      CommonWidget.rowHeight(height: 6),
                      buildVendors(controller.topRatedShops),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        CommonWidget.rowHeight(height: 8),
        Divider(
          color: Color(0xFFEBEBEB),
          height: 7,
          thickness: 7,
        ),
        ...controller.balanceNearbyShops.map(
          (e) => Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: buildStoreItem(e, width: double.infinity),
          ),
        )
      ],
    );
  }

  Row buildSearchBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 34,
            decoration: BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(18)),
            child: Row(
              children: [
                CommonWidget.rowWidth(width: 19),
                Image.asset(
                  '$IMAGE_PATH/search.png',
                  width: 18,
                  height: 18,
                ),
                CommonWidget.rowWidth(width: 12),
                Container(
                  // margin: EdgeInsets.only(top: 4),
                  child: NormalText(
                    text: 'Search',
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
        CommonWidget.rowWidth(width: 24),
        Image.asset(
          '$IMAGE_PATH/settings.png',
          width: 24,
          height: 24,
        )
      ],
    );
  }

  Widget buildVendors(List<Stores> shops) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...shops.map((e) => buildStoreItem(e,
              width: shops.length == 1 ? Get.width - 48 : null)),
        ],
      ),
    );
  }

  Container buildStoreItem(Stores stores, {double? width}) {
    return Container(
      width: width ?? Get.width * .7,
      margin: EdgeInsets.only(right: width != null ? 0 : 24),
      child: InkWell(
        onTap: () {
          if (controller.currentTabIdx != 1)
            Get.toNamed(Routes.RetailMenu,
                arguments: [CommonConstants.dine, stores.id]);
          else
            Get.toNamed(Routes.EVERYDAY,
                arguments: [CommonConstants.dine, stores.id.toString()]);
        },
        child: Column(
          children: [
            Stack(
              children: [
                ImageWidget(
                  image: stores.assetId,
                  width: width ?? Get.width * .7,
                ),
                // Positioned(
                //   right: 0,
                //   top: 0,
                //   child: Container(
                //     height: 30,
                //     width: 30,
                //     alignment: Alignment.center,
                //     margin: EdgeInsets.all(8),
                //     decoration: BoxDecoration(
                //       color: ColorConstants.white,
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: Icon(
                //       Icons.favorite,
                //       size: 22,
                //       color: Color(0xFFFF6243),
                //     ),
                //   ),
                // ),
              ],
            ),
            CommonWidget.rowHeight(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: NormalText(
                    text: stores.title,
                    fontSize: 20,
                    textAlign: TextAlign.start,
                    textColor: ColorConstants.textBlack,
                  ),
                ),
                Container(
                  child: RatingBar.builder(
                    itemSize: 16,
                    tapOnlyMode: false,
                    ignoreGestures: true,
                    initialRating: stores.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    unratedColor: ColorConstants.whiteGrey,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      size: 24,
                      color: ColorConstants.ratingBarYellow,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                )
              ],
            ),
            CommonWidget.rowHeight(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  '$IMAGE_PATH/man-walking.png',
                  width: 10,
                  height: 13,
                ),
                NormalText(
                  text: ' ${stores.distance}m',
                  fontSize: 20,
                  textColor: ColorConstants.textBlack,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runAlignment: WrapAlignment.start,
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        ...stores.storeSpecialities.skip(0).map(
                              (e) => MenuChip(
                                bGColor: const Color(0xFFBCEAFF),
                                text: e,
                                textColor: ColorConstants.textBlack,
                                margin: const EdgeInsets.only(right: 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                              ),
                            )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...controller.storeDashboard.value!.buttons.map((e) => Container(
                margin: EdgeInsets.only(left: 24),
                child: Column(
                  children: [
                    ImageWidget(
                      image: e.assetId,
                      height: 36,
                      width: 36,
                    ),
                    CommonWidget.rowHeight(height: 8),
                    NormalText(
                      text: e.title,
                      fontSize: 10,
                      textColor: ColorConstants.textBlack,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Container buildAppBar() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 21),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 34,
              decoration: BoxDecoration(
                  color: Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(18)),
              child: Row(
                children: [
                  CommonWidget.rowWidth(width: 19),
                  Image.asset(
                    '$IMAGE_PATH/location.png',
                    width: 18,
                    height: 18,
                  ),
                  CommonWidget.rowWidth(width: 12),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: NormalText(
                      text: '9999 Barrington Street',
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
          CommonWidget.rowWidth(width: 24),
          Image.asset(
            '$IMAGE_PATH/profile.png',
            width: 24,
            height: 24,
          )
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return Center(
      child: Wrap(
        children: [
          CommonWidget.actionbutton(
            text: 'Retail',
            buttoncolor: ColorConstants.lightViolet,
            textColor: ColorConstants.black,
            onTap: () => Get.toNamed(Routes.RetailMenu,
                arguments: CommonConstants.retail),
          ),
          CommonWidget.actionbutton(
            text: 'EveryDay',
            width: 124,
            buttoncolor: ColorConstants.lightViolet,
            textColor: ColorConstants.black,
            onTap: () =>
                Get.toNamed(Routes.RetailMenu, arguments: CommonConstants.dine),
          ),
          CommonWidget.actionbutton(
            text: 'Retail',
            width: 124,
            buttoncolor: ColorConstants.lightViolet,
            textColor: ColorConstants.black,
            onTap: () =>
                Get.toNamed(Routes.EVERYDAY, arguments: CommonConstants.dine),
          )
        ],
      ),
    );
  }

  bool get isLoading {
    return controller.loading.value;
  }

  List<Datum>? get data {
    return controller.users.value == null ? [] : controller.users.value!.data;
  }
}
