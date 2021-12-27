import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/models/response/store_dasboard.dart';
import 'package:treat/models/response/users_response.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/modules/home/shimmers/home_shimmer.dart';
import 'package:treat/modules/home/widgets/search.dart';
import 'package:treat/modules/home/widgets/store_item.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class FaveTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: true,
            expandedHeight: 100,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: buildAppBar(),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(bottom: 104),
              child: SingleChildScrollView(
                child: Obx(() => isLoading ? HomeSkeleton() : buildBody()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    if (controller.favouriteStores.value == null) return Text('');
    return Container(
      child: Utils.isGuest
          ? Container(
              height: Get.height / 1.5,
              alignment: Alignment.center,
              child: NormalText(text: 'Please Login to Continue'))
          : Column(
              children: [
                ...controller.favouriteStores.value!.map((e) => Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: StoreItem(
                        isSingle: true,
                        controller: controller,
                        specialityCount: 2,
                        width: double.infinity,
                        stores: Stores.fromJson(e.toJson()),
                      ),
                    ))
              ],
            ),
    );
  }

  Container buildAppBar() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 21),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SearchBar(
              hint: 'Search Faves',
              onTap: () => Get.toNamed(Routes.SEARCH_SCREEN),
            ),
          ),
          CommonWidget.rowWidth(width: 24),
          InkWell(
            onTap: () => Get.toNamed( Routes.ACCOUNT),
            child: Image.asset(
              '$IMAGE_PATH/profile.png',
              width: 24,
              height: 24,
            ),
          )
        ],
      ),
    );
  }

  bool get isLoading {
    return controller.loading.value;
  }

  List<Datum>? get data {
    return controller.users.value == null ? [] : controller.users.value!.data;
  }
}
