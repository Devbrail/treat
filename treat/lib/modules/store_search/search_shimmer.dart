import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/favourite.dart';
import 'package:treat/shared/widgets/image_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class SearchShimmer extends StatelessWidget {
  const SearchShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade300,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Row(
                  children: [
                    ImageWidget(
                        image:
                            'https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg',
                        width: 64,
                        height: 54),
                    CommonWidget.rowWidth(width: 8),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Chip(
                            label: Text('Pizza Pizza'),
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
                                text: '  850m ',
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
                                child: RatingBar.builder(
                                  itemSize: 16,
                                  tapOnlyMode: false,
                                  ignoreGestures: true,
                                  initialRating: 3.5,
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
                              ),
                              NormalText(
                                text: '  4.6',
                                fontSize: 14,
                                textColor: ColorConstants.textBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FavouriteButton(
                      onClick: () {},
                      isFavourite: true,
                      storeID: 5,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
