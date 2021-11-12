import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:treat/shared/constants/colors.dart';

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
    required this.rating,
    this.size = 16,
  }) : super(key: key);

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: size,
      tapOnlyMode: false,
      ignoreGestures: true,
      initialRating: rating,
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
    );
  }
}
