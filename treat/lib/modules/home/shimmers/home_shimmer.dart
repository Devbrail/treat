import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treat/modules/store_detail/widgets/menu_chip.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey.shade300,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24),
            child: buildCategories(),
          ),
          Container(
            margin: EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Row(
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
            ),
          ),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      ...[1, 1, 1, 1, 11].map((e) => buildStores()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CommonWidget.rowHeight(height: 8),
          Divider(
            color: Color(0xFFEBEBEB),
            height: 7,
            thickness: 7,
          ),
          CommonWidget.rowHeight(height: 8),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: buildStores(width: double.infinity),
          )
        ],
      ),
    );
  }

  Container buildStores({double? width}) {
    return Container(
      width: width ?? Get.width * .7,
      margin: EdgeInsets.only(right: 24),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                width: width ?? Get.width * .7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/images/banner_top.png',
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.favorite,
                    size: 22,
                    color: Color(0xFFFF6243),
                  ),
                ),
              ),
            ],
          ),
          CommonWidget.rowHeight(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuChip(
                bGColor: const Color(0xFFBCEAFF),
                text: ' Sake Asian Fusion',
                textColor: ColorConstants.textBlack,
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              ),
              Container(
                child: RatingBar.builder(
                  itemSize: 16,
                  tapOnlyMode: false,
                  ignoreGestures: true,
                  initialRating: 4.5,
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
              MenuChip(
                bGColor: const Color(0xFFBCEAFF),
                text: ' scscdsddc',
                textColor: ColorConstants.textBlack,
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              ),
              Spacer(),
              ...['JAPANESE', 'ASIAN'].map(
                (e) => MenuChip(
                  bGColor: const Color(0xFFBCEAFF),
                  text: e,
                  textColor: ColorConstants.textBlack,
                  margin: const EdgeInsets.only(right: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  SingleChildScrollView buildCategories() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1].map((e) => Container(
                margin: EdgeInsets.only(left: 24),
                child: Column(
                  children: [
                    Image.asset(
                      '$IMAGE_PATH/menu.png',
                      height: 36,
                      width: 36,
                    ),
                    CommonWidget.rowHeight(height: 8),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Container shimmerText(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: ColorConstants.textColorGrey,
    );
  }
}
