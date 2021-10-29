import 'package:flutter/material.dart';

import '../shared.dart';

class FavouriteButton extends StatefulWidget {
  final bool isFavourite;
  final double size;
  final Function()? onClick;
  final int storeID;

  const FavouriteButton(
      {Key? key,
      required this.isFavourite,
      this.onClick,
      this.size = 30,
      required this.storeID})
      : super(key: key);

  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool? isFavourite;

  @override
  void initState() {
    super.initState();

    isFavourite = widget.isFavourite;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick!();
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          widget.isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
          size: 22,
          color: Color(0xFFFF6243),
        ),
      ),
    );
  }
}
