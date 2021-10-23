import 'package:flutter/material.dart';
import 'package:treat/models/response/store_dasboard.dart';

import '../shared.dart';

class AppBanner extends StatelessWidget {
  final List<Banners> banners;

  const AppBanner({Key? key, this.banners = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...banners.map((e) => Container(
                height: 200,
                width: SizeConfig().screenWidth * .8,
                margin: EdgeInsets.only(right: 12),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            e.assetId,
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
              ))
        ],
      ),
    );
  }
}
