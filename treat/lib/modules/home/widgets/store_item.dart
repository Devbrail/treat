import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:treat/models/response/store_dasboard.dart';
import 'package:treat/modules/store_detail/widgets/menu_chip.dart';
import 'package:treat/routes/routes.dart';
import 'package:treat/shared/constants/constants.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';
import 'package:treat/shared/widgets/favourite.dart';
import 'package:treat/shared/widgets/image_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

import '../home_controller.dart';

class StoreItem extends StatelessWidget {
  const StoreItem({
    Key? key,
    required this.isSingle,
    required this.controller,
    required this.specialityCount,
    this.width,
    required this.stores,
  }) : super(key: key);

  final bool isSingle;
  final Stores stores;
  final double? width;
  final HomeController controller;
  final int specialityCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width * .7,
      margin: EdgeInsets.only(right: isSingle ? 0 : 24),
      child: InkWell(
        onTap: () {
          if (!Utils.isAdvanced(stores.couponLayout))
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
                Positioned(
                  right: 0,
                  top: 0,
                  child: GetBuilder<HomeController>(
                    builder: (ctrl) => FavouriteButton(
                        isFavourite: stores.isFavourite,
                        storeID: stores.id,
                        onClick: () {
                          ctrl.updateIsFavourite(stores.id, stores.isFavourite);
                        }),
                    id: 'fav',
                  ),
                ),
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
                  text: ' ${stores.distance} ',
                  fontSize: 14,
                  textColor: ColorConstants.textBlack,
                ),
                if (stores.street.isNotEmpty)
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: ColorConstants.ratingBarYellow,
                      ),
                      NormalText(
                        text: ' ${stores.street}',
                        fontSize: 14,
                        textColor: ColorConstants.textBlack,
                      ),
                    ],
                  ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.start,
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        ...stores.storeSpecialities.take(specialityCount).map(
                              (e) => MenuChip(
                                bGColor: const Color(0xFFBCEAFF),
                                text: e,
                                fontSize: 11,
                                textColor: ColorConstants.textBlack,
                                margin: const EdgeInsets.only(right: 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                              ),
                            ),
                        if (stores.storeSpecialities.length > specialityCount)
                          NormalText(
                            text:
                                '+${stores.storeSpecialities.length - specialityCount}',
                            textColor: ColorConstants.textBlack,
                            fontSize: 12,
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
}
