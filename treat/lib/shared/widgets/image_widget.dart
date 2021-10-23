import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String image;

  ImageWidget({Key? key, this.width, this.height, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 150,
        width: width,
        child: CachedNetworkImage(
          imageUrl: image,
          width: width,
          errorWidget: (context, url, error) => Container(
            height: height ?? 150,
            width: width,
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
          fit: BoxFit.fill,
          placeholder: (context, url) => Container(
            width: width,
            height: height ?? 150,
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
        ));
  }
}
