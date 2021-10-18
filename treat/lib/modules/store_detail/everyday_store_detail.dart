import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:treat/models/response/everyday_store.detail.dart';
import 'package:treat/models/response/store_details.dart';
import 'package:treat/routes/routes.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';
import 'package:treat/shared/widgets/text_widget.dart';

import 'menu_controller.dart';
import 'widgets/menu_chip.dart';

class EveryDayStoreDetail extends StatefulWidget {
  const EveryDayStoreDetail({Key? key}) : super(key: key);

  @override
  _EveryDayStoreDetailState createState() => _EveryDayStoreDetailState();
}

class _EveryDayStoreDetailState extends State<EveryDayStoreDetail> {
  MenuController controller =
      Get.put(MenuController(apiRepository: Get.find()));
  final PageController _pageController = PageController();
  final String pageType = Get.arguments;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // controller.loadUsers('1');
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Obx(() {
            if (controller.loading.value)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              final EveryDayStore? storeDetails = controller.storeDetails.value;
              if (storeDetails == null || storeDetails.storeName == null) {
                return Center(child: Text('Parse Error'));
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                            child: Image.asset(
                              'assets/images/location_icon.png',
                              width: 32,
                              height: 32,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: SizeConfig().screenHeight * .3,
                      child: Stack(
                        children: [
                          PageView(
                            controller: _pageController,
                            allowImplicitScrolling: true,
                            children: [
                              ...storeDetails.photos
                                  .map((e) => Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: CachedNetworkImageProvider(
                                                e.assetId),
                                          ),
                                        ),
                                      ))
                                  .toList()
                            ],
                          ),
                          Container(
                            height: 350.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.grey.withOpacity(0.0),
                                  Colors.black,
                                ],
                                stops: [0.0, 1.0],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_pageController.page ==
                                  storeDetails.photos.length - 1)
                                _pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.easeInOut);
                              else
                                _pageController.nextPage(
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.easeInOut);
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.only(right: 16),
                              child: Image.asset(
                                'assets/images/right_arrow.png',
                                height: 46,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.only(bottom: 24, left: 16),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: NormalText(
                                        text: storeDetails.storeName,
                                        textColor: ColorConstants.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: RatingBar.builder(
                                            itemSize: 24,
                                            tapOnlyMode: false,
                                            ignoreGestures: true,
                                            initialRating: storeDetails.rating,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            unratedColor:
                                                ColorConstants.ratingBlack,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              size: 24,
                                              color: ColorConstants
                                                  .ratingBarYellow,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ),
                                        NormalText(
                                          text: '(${storeDetails.rating}/5)',
                                          fontSize: 14,
                                          textColor: ColorConstants.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(right: 16),
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: ColorConstants.white,
                                      borderRadius: BorderRadius.circular(26)),
                                  child: Icon(
                                    Icons.favorite,
                                    size: 26,
                                    color: Color(0xFFFF6243),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: Get.width / 1.4,
                                child: MenuChip(
                                  text: storeDetails.address1,
                                  bGColor: ColorConstants.chipBackround,
                                  textColor: ColorConstants.textBlack,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 24, top: 4),
                                decoration: BoxDecoration(
                                  color: ColorConstants.chipBackround,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      NormalText(
                                        text: 'Open right now!',
                                        textColor: ColorConstants.textBlack,
                                        fontSize: 13,
                                      ),
                                      NormalText(
                                        text: '11AM - 10PM',
                                        textColor: Color(0xFF00B153),
                                        fontSize: 13,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: menuButton(
                            'assets/images/info.png',
                            'More Info',
                            onTap: () => Get.toNamed(
                                Routes.RetailMenu + Routes.MenuDetail,
                                arguments: StoreDetails.fromJson(
                                    storeDetails.toJson())),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    buildClipSection(),
                    buildGrocery(storeDetails
                        .categoryData.retail.couponMenuGroupings
                        .where((element) => element.availableInMenu)
                        .toList()),
                    buildOfferSectionList(
                        title: 'My Offers :',
                        offerList: storeDetails.storeCoupons,
                        chipsFilter: storeDetails
                            .categoryData.retail.couponMenuGroupings),
                    CommonWidget.rowHeight(height: 24),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < 4; i++)
                            Container(
                              height: SizeConfig().screenHeight * .3,
                              width: SizeConfig().screenWidth * .8,
                              margin: EdgeInsets.only(
                                  right: SizeConfig().screenWidth * .1),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          'assets/images/banner_top.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 350.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          Colors.grey.withOpacity(0.0),
                                          Colors.black,
                                        ],
                                        stops: [0.0, 1.0],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                    CommonWidget.rowHeight(height: 32)
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  Container buildGrocery(List<CouponMenuGroupings> couponMenuGroupings) {
    return Container(
      margin: EdgeInsets.only(left: 24, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NormalText(
            text: 'Grocery Menu',
            fontSize: 14,
          ),
          CommonWidget.rowHeight(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...couponMenuGroupings.map(
                  (e) => Container(
                    width: 74,
                    height: 74,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        color: ColorConstants.chipBackround,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(
                          //     top: 24, left: 24, right: 24, bottom: 4),
                          child: Image.network(
                            e.assetId,
                            fit: BoxFit.fill,
                            width: 48,
                            height: 48,
                          ),
                        ),
                        NormalText(
                          text: e.menuGroup,
                          fontSize: 10,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildClipSection() {
    return Container(
      margin: EdgeInsets.only(left: 24, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NormalText(
            text: 'Clip Again ',
            fontSize: 14,
          ),
          CommonWidget.rowHeight(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...[1, 2, 3, 4].map((e) => Container(
                      width: 132,
                      height: 138,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          color: ColorConstants.chipBackround,
                          borderRadius: BorderRadius.circular(8)),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(24),
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://www.milma.com/storage/products/October2020/r8ToSNreD1WnxhACr6Hf.jpg',
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildAddButton('add.png'),
                                Spacer(),
                                NormalText(
                                  text: 'Egg Whites (Burnbrae)',
                                  fontSize: 11,
                                  textColor: ColorConstants.textBlack,
                                ),
                                NormalText(
                                  text: '2 for 1 |  40% Off',
                                  textColor: Color(0xFF717171),
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildAddButton(String path) {
    return Container(
      height: 34,
      width: 34,
      margin: EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(34),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: ImageIcon(
          AssetImage('$IMAGE_PATH/$path'),
          color: Colors.black,
          size: 24,
        ),
      ),
    );
  }

  Widget buildOfferSectionList(
      {required String title,
      required final List<StoreCoupons> offerList,
      required final List<CouponMenuGroupings> chipsFilter}) {
    List<CouponMenuGroupings> chips = chipsFilter.reversed.toList();

    printInfo(info: 'refreheddd &&&&&&&&&&&&&&&&&&&&');
    return GetBuilder<MenuController>(
      id: 'offer',
      builder: (_c) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (offerList.isNotEmpty)
            Container(
              margin: EdgeInsets.only(left: 24, right: 24, top: 24),
              child: NormalText(
                text: title,
                fontSize: 14,
              ),
            ),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, top: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...chips.map((e) => InkWell(
                        onTap: () {
                          controller.filterList(e.menuGroup, e.couponIds);
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 8),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: e.isSelected
                                  ? Color(0xFF818181)
                                  : ColorConstants.chipBackround,
                              borderRadius: BorderRadius.circular(16)),
                          child: NormalText(
                            text: e.menuGroup,
                            fontSize: 13,
                            textColor: e.isSelected
                                ? ColorConstants.white
                                : ColorConstants.textBlack,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: offerList.where((element) => element.isSelected).length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              StoreCoupons coupon = offerList
                  .where((element) => element.isSelected)
                  .toList()[index];
              'coupon have selected ${coupon.isSelected}'.printInfo();
              if (coupon.isSelected)
                return couponItem(coupon);
              else
                return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Container couponItem(StoreCoupons coupon) {
    bool isDynamic = coupon.couponType == 'DYNAMIC';
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, top: 12),
      width: double.infinity,
      height: 104,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.01, 0.0),
          colors: isDynamic
              ? <Color>[Color(0xFFFCCC00), Color(0xffFDC100)]
              : coupon.canRedeem
                  ? <Color>[Color(0xFFB9EAF8), Color(0xff93D9EA)]
                  : <Color>[Color(0xFFDEDEDE), Color(0xffC9C9C9)],
        ),
      ),
      child: Stack(
        children: [
          Container(
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  end: Alignment.centerLeft,
                  begin: Alignment.centerRight,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(70, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                // padding: EdgeInsets.only(left: 24),
                child: Image.asset(
                  'assets/images/offer_bck.png',
                  height: 104,
                  color: Colors.white,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NormalText(
                          text:
                              '${coupon.couponName}\n(${coupon.couponTemplate})',
                          textColor: coupon.canRedeem && !isDynamic
                              ? ColorConstants.textBlack
                              : Color(0xFF808080),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.start),
                      if (coupon.canRedeem)
                        Row(
                          children: [
                            buildAddButton('add.png'),
                            CommonWidget.rowWidth(width: 8),
                            NormalText(
                              text: 'ADD COUPON',
                              textColor: isDynamic
                                  ? ColorConstants.white
                                  : ColorConstants.textBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            buildAddButton('cancel.png'),
                            CommonWidget.rowWidth(width: 8),
                            NormalText(
                              text: 'CANNOT BE ADDED',
                              textColor: isDynamic
                                  ? ColorConstants.white
                                  : ColorConstants.textBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        )
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 80,
                  width: 78,
                  margin: EdgeInsets.only(right: 24),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.circular(14)),
                  child: CachedNetworkImage(
                    imageUrl: coupon.assetID,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget menuButton(String icon, String text, {Function()? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 88,
      decoration: BoxDecoration(
        // color: ColorConstants.chipBackround,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 40,
              width: 40,
            ),
            CommonWidget.rowHeight(height: 8),
            NormalText(
              text: text,
              fontSize: 13,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Utils.setStatusBarColor(color: ColorConstants.white);
    super.initState();
  }
}
