import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:treat/models/response/users_response.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/shared.dart';

class MainTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildGridView(),
    );
  }

  Widget _buildGridView() {
    return Center(
      child: Wrap(
        children: [
          CommonWidget.actionbutton(
            text: 'Retail',
            buttoncolor: ColorConstants.lightViolet,
            textColor: ColorConstants.black,
            onTap: () => Get.toNamed(Routes.RetailMenu,
                arguments: CommonConstants.retail),
          ),
          CommonWidget.actionbutton(
            text: 'EveryDay',
            width: 124,
            buttoncolor: ColorConstants.lightViolet,
            textColor: ColorConstants.black,
            onTap: () =>
                Get.toNamed(Routes.RetailMenu, arguments: CommonConstants.dine),
          ),
          CommonWidget.actionbutton(
            text: 'Retail',
            width: 124,
            buttoncolor: ColorConstants.lightViolet,
            textColor: ColorConstants.black,
            onTap: () =>
                Get.toNamed(Routes.EVERYDAY, arguments: CommonConstants.dine),
          )
        ],
      ),
    );
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: data!.length,
      itemBuilder: (BuildContext context, int index) => new Container(
        color: ColorConstants.lightGray,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('${data![index].lastName} ${data![index].firstName}'),
            CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: data![index].avatar ??
                  'https://reqres.in/img/faces/1-image.jpg',
              placeholder: (context, url) => Image(
                image: AssetImage('assets/images/icon_success.png'),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text('${data![index].email}'),
          ],
        ),
      ),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 3 : 2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  List<Datum>? get data {
    return controller.users.value == null ? [] : controller.users.value!.data;
  }
}
