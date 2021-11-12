import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class SearchBar extends StatelessWidget {
  final String hint;
  final Function()? onTap;

  const SearchBar({Key? key, this.hint = 'Search', this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 34,
        decoration: BoxDecoration(
            color: Color(0xFFF4F4F4), borderRadius: BorderRadius.circular(18)),
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
                text: hint,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
