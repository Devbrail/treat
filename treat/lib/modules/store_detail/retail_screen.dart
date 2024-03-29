import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:treat/models/response/store_details.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/modules/menu_detail/menu_detail.dart';
import 'package:treat/modules/store_detail/widgets/loyalty_bar.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';
import 'package:treat/shared/widgets/banners.dart';
import 'package:treat/shared/widgets/favourite.dart';
import 'package:treat/shared/widgets/text_widget.dart';

import 'menu_controller.dart';
import 'widgets/menu_chip.dart';

class RetailMenu extends StatefulWidget {
  const RetailMenu({Key? key}) : super(key: key);

  @override
  _RetailMenuState createState() => _RetailMenuState();
}

class _RetailMenuState extends State<RetailMenu> {
  MenuController controller =
      Get.put(MenuController(apiRepository: Get.find()));
  final PageController _pageController = PageController();
  final String pageType = Get.arguments[0];
  final String storeID = Get.arguments[1].toString();

  @override
  void initState() {
    Utils.setStatusBarColor(color: ColorConstants.white);
    controller.loadStoreDetail(storeID);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Obx(() {
            if (controller.loading.value)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              final StoreDetails? storeDetails = controller.storeDetails.value;

              if (storeDetails == null) {
                return Center(
                  child: Text('Parse Error'),
                );
              }
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: false,
                    snap: false,
                    floating: true,
                    expandedHeight: 74,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    flexibleSpace: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonWidget.actionbutton(
                            onTap: () => Get.back(),
                            text: 'BACK',
                            height: 26,
                            buttoncolor: ColorConstants.backButton,
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
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 24),
                            child: LoyaltyBarWidget(
                                loyaltyPoint: storeDetails
                                    .loyaltyInfo.percDiscount
                                    .toDouble()),
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
                                                  image:
                                                      CachedNetworkImageProvider(
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
                                    margin: EdgeInsets.only(right: 16),
                                    child: Image.asset(
                                      'assets/images/right_arrow.png',
                                      height: 46,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  margin: EdgeInsets.only(bottom: 24, left: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0),
                                              child: NormalText(
                                                text: storeDetails.storeName,
                                                textColor: ColorConstants.white,
                                                fontWeight: FontWeight.bold,
                                                textAlign: TextAlign.start,
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
                                                    initialRating:
                                                        storeDetails.rating,
                                                    minRating: 1,
                                                    tapOnlyMode: false,
                                                    ignoreGestures: true,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    unratedColor: ColorConstants
                                                        .ratingBlack,
                                                    itemBuilder: (context, _) =>
                                                        Icon(
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
                                                  text:
                                                      '(${storeDetails.rating}/5)',
                                                  fontSize: 14,
                                                  textColor:
                                                      ColorConstants.white,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        child: GetBuilder<MenuController>(
                                          builder: (ctrl) => FavouriteButton(
                                              isFavourite:
                                                  storeDetails.isFavourite,
                                              storeID: storeDetails.storeId,
                                              size: 35,
                                              onClick: () {
                                                controller
                                                    .favouriteButtonAction(
                                                        storeDetails
                                                            .isFavourite,
                                                        storeDetails.storeId);
                                              }),
                                          id: 'fav',
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          MenuChip(
                            text: storeDetails.address1,
                            bGColor: ColorConstants.chipBackround,
                            textColor: ColorConstants.textBlack,
                            textOverflow: null,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 24, top: 8),
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
                                    text: 'Open right now!  ',
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
                          Container(
                            margin:
                                EdgeInsets.only(left: 24, right: 24, top: 24),
                            child: Row(
                              children: [
                                menuButton(
                                  'assets/images/send.png',
                                  'Ping',
                                  onTap: () {
                                    showPingDialog(storeDetails);
                                  },
                                ),
                                if (storeDetails.menuAssetId.isNotEmpty)
                                  menuButton(
                                    'assets/images/menu.png',
                                    'Menu',
                                    onTap: () {
                                      try {
                                        Get.to(MenuPDFView(
                                            url: storeDetails.menuAssetId.first,
                                            menus: storeDetails.menuAssetId,
                                            storeName: storeDetails.storeName));
                                      } catch (e) {
                                        CommonWidget.toast(
                                            'Menu details not available');
                                        print(e);
                                        CommonWidget.toast(
                                            'Menu details not available');
                                        e.printInfo();
                                      }
                                    },
                                  ),
                                GetBuilder<MenuController>(
                                  builder: (ctrl) => menuButton(
                                    'assets/images/info.png',
                                    'More Info',
                                    onTap: () => Get.toNamed(
                                        Routes.RetailMenu + Routes.MenuDetail,
                                        arguments: ctrl.storeDetails.value),
                                  ),
                                  id: 'fav',
                                )
                              ],
                            ),
                          ),
                          buildOfferSectionList(
                              title: 'Offers pinged to me :',
                              offerList: storeDetails.pingedCoupons),
                          buildOfferSectionList(
                              title: 'My Offers :',
                              offerList: storeDetails.storeCoupons),
                          CommonWidget.rowHeight(height: 24),
                          Container(
                            margin: EdgeInsets.only(left: 24),
                            child: AppBanner(
                              banners: Get.put(
                                      HomeController(apiRepository: Get.find()))
                                  .storeDashboard
                                  .banners,
                            ),
                          ),
                          CommonWidget.rowHeight(height: 32)
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  Column buildOfferSectionList(
      {required String title, required final List<Coupons> offerList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (offerList.isNotEmpty)
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, top: 24),
            child: NormalText(
              text: title,
              fontSize: 13,
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: offerList.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Coupons coupon = offerList[index];

            return couponItem(coupon);
          },
        ),
      ],
    );
  }

  Widget couponItem(Coupons coupon) {
    bool isDynamic = coupon.couponType == 'DYNAMIC';

    return InkWell(
      onTap: () {
        if (!isDynamic)
          Get.toNamed(Routes.STATIC_REDEEM, arguments: [
            coupon.couponId,
            storeID,
            controller.storeDetails.value.storeName
          ]);
        else
          Get.toNamed(Routes.DYNAMIC_REDEEM,arguments: [
            coupon.couponId,
            storeID,
            controller.storeDetails.value.storeName
          ]);
      },
      child: Container(
        margin: EdgeInsets.only(left: 24, right: 24, top: 12),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.01, 0.0),
            colors: isDynamic
                ? <Color>[Color(0xFFCC80FF), Color(0xff9D64C3)]
                : coupon.canRedeem
                    ? <Color>[Color(0xFFFCCC00), Color(0xffFDC100)]
                    : <Color>[Color(0xFFDEDEDE), Color(0xffC9C9C9)],
          ),
        ),
        child: Stack(
          children: [
            Container(
              child: ShaderMask(
                shaderCallback: (rect) => LinearGradient(
                  end: Alignment.centerLeft,
                  begin: Alignment.centerRight,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(70, 0, rect.width, rect.height)),
                blendMode: BlendMode.dstIn,
                child: Container(
                  // padding: EdgeInsets.only(left: 24),
                  child: Image.asset(
                    'assets/images/offer_bck.png',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                        color: ColorConstants.white,
                        borderRadius: BorderRadius.circular(26)),
                    child: CachedNetworkImage(
                        imageUrl: coupon.assetID, width: 34, height: 34),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NormalText(
                        text: coupon.couponName,
                        textColor: isDynamic
                            ? ColorConstants.white
                            : coupon.canRedeem
                                ? ColorConstants.textColorBlack
                                : ColorConstants.textColorGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      CommonWidget.rowHeight(height: 4),
                      NormalText(
                        text: coupon.couponDesc,
                        textColor: isDynamic
                            ? ColorConstants.white
                            : coupon.canRedeem
                                ? ColorConstants.textColorBlack
                                : ColorConstants.textColorGrey,
                        fontSize: 13,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded menuButton(String icon, String text, {Function()? onTap}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: 88,
        decoration: BoxDecoration(
          color: ColorConstants.chipBackround,
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
      ),
    );
  }

  void showPingDialog(StoreDetails storeDetails) {
    List<Coupons> pingedCoupons = storeDetails.storeCoupons
        .where((element) =>
            element.couponType == 'STATIC' &&
            element.canPing &&
            element.canRedeem)
        .toList();
    if (pingedCoupons.length < 1) {
      CommonWidget.toast(
          'No coupons available for pinging at the moment,\nPlease try another outlet');
      return;
    }
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return GetBuilder<MenuController>(
              id: 'ping',
              builder: (ctrl) {
                pingedCoupons = ctrl.storeDetails.value.storeCoupons
                    .where((element) =>
                        element.couponType == 'STATIC' &&
                        element.canPing &&
                        element.canRedeem)
                    .toList();

                return Container(
                  padding: EdgeInsets.only(top: 14),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      NormalText(
                        text: 'Share Pings',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      MenuChip(
                        bGColor: ColorConstants.chipBackround,
                        margin: EdgeInsets.only(top: 12, bottom: 24),
                        text:
                            ' You have ${pingedCoupons.length} offers left to ping ',
                        textColor: ColorConstants.textBlack,
                      ),
                      ...pingedCoupons.map(
                        (e) => Container(
                          width: Get.width,
                          margin: EdgeInsets.symmetric(vertical: 4),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          color: e.isSelected
                              ? const Color(0xFFA35DDB)
                              : ColorConstants.chipBackround,
                          child: InkWell(
                            onTap: () {
                              ctrl.selectCoupon(e.couponId);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                NormalText(
                                  text: e.couponDesc,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  textColor: e.isSelected
                                      ? ColorConstants.white
                                      : ColorConstants.redemptionTextBlack,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorConstants.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: e.isSelected
                                              ? ColorConstants.white
                                              : const Color(0xFFBABABA))),
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: e.isSelected
                                          ? ColorConstants.black
                                          : ColorConstants.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...[
                            {
                              'title': 'SMS',
                              'icon': 'sms.png',
                            },
                            {
                              'title': 'Whatsapp',
                              'icon': 'whatsapp.png',
                            },
                            {
                              'title': 'Email',
                              'icon': 'email.png',
                            },
                            {
                              'title': 'Instagram',
                              'icon': 'insta.png',
                            },
                            {
                              'title': 'Share',
                              'icon': 'share_icon.png',
                            },
                          ].map(
                            (Map e) => Column(
                              children: [
                                Image.asset(
                                  '$IMAGE_PATH/${e['icon']}',
                                  width: 32,
                                  height: 32,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                NormalText(
                                  text: e['title'],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
