import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:treat/shared/constants/colors.dart';

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
    required this.rating,
    this.unratedColor = ColorConstants.whiteGrey,
    this.size = 16,
    this.isTapOnly = true,
    this.itemPadding = EdgeInsets.zero,
    this.onRatingUpdate,
  }) : super(key: key);

  final double rating;
  final Color unratedColor;
  final EdgeInsets itemPadding;
  final double size;
  final bool isTapOnly;
  final Function(double)? onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        itemSize: size,
        tapOnlyMode: !isTapOnly,
        ignoreGestures: isTapOnly,
        initialRating: rating,
        minRating: 0,
        itemPadding: itemPadding,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        updateOnDrag: !isTapOnly,
        unratedColor: unratedColor,
        itemBuilder: (context, _) => Icon(
              Icons.star,
              size: 24,
              color: ColorConstants.ratingBarYellow,
            ),
        onRatingUpdate: onRatingUpdate!);
  }
}
