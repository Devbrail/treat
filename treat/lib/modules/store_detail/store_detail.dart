import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart'
    as L;
import 'package:treat/models/response/store_details.dart';
import 'package:treat/modules/menu_detial/menu_detail.dart';
import 'package:treat/modules/store_detail/widgets/menu_chip.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/favourite.dart';
import 'package:treat/shared/widgets/static_map.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class MenuDetail extends StatefulWidget {
  const MenuDetail({Key? key}) : super(key: key);

  @override
  _MenuDetailState createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  StoreDetails _storeDetails = Get.arguments;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  StaticMapWidget(
                      latLng: L.Location(
                          double.parse(_storeDetails.location.latitude),
                          double.parse(_storeDetails.location.longitude)),
                      label: _storeDetails.storeName),
                  // Image.asset('$IMAGE_PATH/static_map.png'),
                  CommonWidget.actionbutton(
                    onTap: () => Get.back(),
                    text: 'BACK',
                    height: 26,
                    buttoncolor: ColorConstants.black,
                    textColor: ColorConstants.white,
                    margin: EdgeInsets.only(top: 32, left: 24),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: NormalText(
                              text: _storeDetails.storeName,
                              fontSize: 28,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            child: FavouriteButton(
                                isFavourite: _storeDetails.isFavourite,
                                storeID: _storeDetails.storeId,
                                size: 30,
                                onClick: () {}),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (Get.previousRoute != Routes.EVERYDAY)
                            ..._storeDetails.storeSpecialities.map(
                              (e) => MenuChip(
                                  bGColor: const Color(0xFFD391FF),
                                  text: e,
                                  textColor: ColorConstants.white,
                                  margin: const EdgeInsets.only(right: 6),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2)),
                            )
                        ],
                      ),
                      CommonWidget.rowHeight(height: 30),
                      buildPersonalInfo(
                          icon: 'pin.png',
                          title: 'Address',
                          description: _storeDetails.address1),
                      buildPersonalInfo(
                          icon: 'global.png',
                          title: 'Website',
                          description: _storeDetails.website),
                      buildPersonalInfo(
                          icon: 'phone-call.png',
                          title: 'Contact',
                          description: _storeDetails.contactNo),
                      CommonWidget.rowHeight(height: 16),
                      Divider(
                        color: ColorConstants.whiteGrey,
                      ),
                      CommonWidget.rowHeight(height: 16),
                      timingWidget(),
                      if (_storeDetails.menuAssetId.isNotEmpty)
                        CommonWidget.actionbutton(
                          text: 'Menu',
                          buttoncolor: const Color(0xFFFFED84),
                          width: 125,
                          height: 40,
                          textColor: ColorConstants.black,
                          onTap: () {
                            try {
                              Get.to(MenuPDFView(
                                  url: _storeDetails.menuAssetId.first,
                                  menus: _storeDetails.menuAssetId,
                                  storeName: _storeDetails.storeName));
                            } catch (e, s) {
                              CommonWidget.toast('Menu details not available');
                              e.printInfo();
                              print('${_storeDetails.menuAssetId}sksmdlk');
                              s.printInfo();
                              print(s);
                              print(s);
                            }
                          },
                        ),
                      CommonWidget.rowHeight(height: 16),
                      Row(
                        children: [
                          Container(
                            width: Get.width / 2.6,
                            child: NormalText(
                              text: 'Price Range',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i < _storeDetails.priceRange;
                                    i++)
                                  NormalText(
                                    text: '\$',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CommonWidget.rowHeight(height: 24),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: Get.width / 2.6,
                              child: NormalText(
                                text: 'Rating',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: RatingBar.builder(
                                  itemSize: 24,
                                  initialRating: _storeDetails.rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  tapOnlyMode: false,
                                  ignoreGestures: true,
                                  wrapAlignment: WrapAlignment.start,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 3.0),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      CommonWidget.rowHeight(height: 16),
                      Divider(
                        color: ColorConstants.whiteGrey,
                      ),
                      CommonWidget.rowHeight(height: 16),
                      Row(
                        children: [
                          NormalText(
                            text: 'Amenities',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      CommonWidget.rowHeight(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ..._storeDetails.amneties
                              .map((e) => buildAmenities(e.name, e.assetId))
                              .toList()
                        ],
                      ),
                      CommonWidget.rowHeight(height: 24)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildAmenities(String text, String image) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(8)),
            child: Image.network(
              image,
              scale: 4,
            ),
          ),
          CommonWidget.rowHeight(height: 4),
          Container(
            width: 70,
            child: NormalText(
              text: text,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Row timingWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width / 2.5,
          child: Row(
            children: [
              NormalText(
                text: 'Timings',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: Column(
              children: [
                CommonWidget.rowHeight(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _storeDetails.workingHours.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final WorkingHours hour = _storeDetails.workingHours[index];
                    return Container(
                      width: SizeConfig().screenWidth * 0.6,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NormalText(
                            text: hour.day,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          NormalText(
                            text: hour.timing,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildPersonalInfo(
      {required String description,
      required String icon,
      required String title}) {
    if (description.isEmpty) return SizedBox();
    return Container(
      margin: EdgeInsets.only(top: 14),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Image.asset('$IMAGE_PATH/$icon', height: 30, width: 30),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NormalText(
                  text: title,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                NormalText(
                  text: description,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
