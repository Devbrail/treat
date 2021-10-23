import 'package:flutter/material.dart';
import 'package:progress_indicator/progress_indicator.dart';
import 'package:treat/shared/constants/constants.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class LoyaltyBarWidget extends StatelessWidget {
  const LoyaltyBarWidget({
    Key? key,
    required this.loyaltyPoint,
  }) : super(key: key);

  final double loyaltyPoint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BarProgress(
          percentage: loyaltyPoint,
          backColor: Colors.grey,
          gradient: LinearGradient(colors: [
            Color(0xFF9D4AFF),
            Color(0xFF7373FF),
            Color(0xFF77E7E8),
            Color(0xFF60FF9D),
          ]),
          showPercentage: false,
          stroke: 22,
          round: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...['', '10', '25', '50', '100'].map(
              (e) => Column(
                children: [
                  if (e.isNotEmpty)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 3),
                      child: Image.asset(
                        '$IMAGE_PATH/up_arrow.png',
                        width: 9,
                        height: 10,
                      ),
                    ),
                  NormalText(
                    text: e,
                    fontSize: 14,
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
