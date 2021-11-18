import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/models/response/addresses.dart';
import 'package:treat/models/response/store_dasboard.dart';
import 'package:treat/models/response/users_response.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/modules/home/shimmers/home_shimmer.dart';
import 'package:treat/modules/home/widgets/search.dart';
import 'package:treat/modules/home/widgets/store_item.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/banners.dart';
import 'package:treat/shared/widgets/image_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class MainTab extends GetView<HomeController> {
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
          )),
        ],
      ),
    );
  }

  Column buildBody() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 24),
          child: AppBanner(
            banners: controller.storeDashboard.banners,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 24),
          child: buildCategories(),
        ),
        Container(
          margin: EdgeInsets.only(top: 24, left: 24, right: 24),
          child: SearchBar(
              onTap: () => Get.toNamed(Routes.SEARCH_SCREEN, arguments: [
                    {
                      "categories": [controller.storeType],
                      "latitude": controller.locationData!.latitude ?? 0,
                      "longitude": controller.locationData!.longitude ?? 0,
                    },""
                  ])),
        ),
        if (controller.sponsoredShops.isNotEmpty)
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 24, left: 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                      text: 'Sponsored Vendors',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonWidget.rowHeight(height: 6),
                    buildVendors(controller.sponsoredShops),
                  ],
                ),
              ),
              CommonWidget.rowHeight(height: 8),
              Divider(
                color: Color(0xFFEBEBEB),
                height: 7,
                thickness: 7,
              ),
            ],
          ),
        if (controller.allNearbyShops.isNotEmpty)
          Column(
            children: [
              CommonWidget.rowHeight(height: 8),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: buildStoreItem(controller.sponsoredShops.first,
                    width: double.infinity),
              ),
              CommonWidget.rowHeight(height: 8),
              Divider(
                color: Color(0xFFEBEBEB),
                height: 7,
                thickness: 7,
              ),
            ],
          ),
        CommonWidget.rowHeight(height: 8),
        Container(
          margin: EdgeInsets.only(top: 24, left: 24),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NormalText(
                text: 'New To Treat',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CommonWidget.rowHeight(height: 6),
              buildVendors(controller.newToTreat),
            ],
          ),
        ),
        CommonWidget.rowHeight(height: 8),
        if (controller.allNearbyShops.length > 1)
          Column(
            children: [
              Divider(
                color: Color(0xFFEBEBEB),
                height: 7,
                thickness: 7,
              ),
              CommonWidget.rowHeight(height: 8),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: buildStoreItem(controller.allNearbyShops[1],
                    width: double.infinity),
              ),
            ],
          ),
        CommonWidget.rowHeight(height: 8),
        if (controller.nearbyShops.isNotEmpty)
          Column(
            children: [
              Divider(
                color: Color(0xFFEBEBEB),
                height: 7,
                thickness: 7,
              ),
              CommonWidget.rowHeight(height: 8),
              Container(
                margin: EdgeInsets.only(left: 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                      text: 'Nearby Offers',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonWidget.rowHeight(height: 8),
                    buildVendors(controller.nearbyShops),
                  ],
                ),
              ),
              CommonWidget.rowHeight(height: 8),
              Divider(
                color: Color(0xFFEBEBEB),
                height: 7,
                thickness: 7,
              ),
            ],
          ),
        CommonWidget.rowHeight(height: 14),
        if (controller.allNearbyShops.length > 2)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: buildStoreItem(controller.allNearbyShops[2],
                width: double.infinity),
          ),
        CommonWidget.rowHeight(height: 8),
        Column(
          children: [
            Divider(
              color: Color(0xFFEBEBEB),
              height: 7,
              thickness: 7,
            ),
            CommonWidget.rowHeight(height: 8),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 24, left: 24),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NormalText(
                        text: 'Top Rated',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      CommonWidget.rowHeight(height: 6),
                      buildVendors(controller.topRatedShops),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        CommonWidget.rowHeight(height: 8),
        Divider(
          color: Color(0xFFEBEBEB),
          height: 7,
          thickness: 7,
        ),
        ...controller.balanceNearbyShops.map(
          (e) => Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: buildStoreItem(e, width: double.infinity),
          ),
        )
      ],
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
            child: Container(
                height: 34,
                decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(18)),
                child: Obx(() => DropdownButton<AddressReturns>(
                      focusColor: Colors.white,
                      value: controller.getDefAddr,
                      iconEnabledColor: Colors.black,
                      underline: SizedBox(),
                      isExpanded: true,
                      iconSize: 26,
                      icon: Icon(Icons.arrow_drop_down_sharp),
                      items: controller.getAddrs
                          .map<DropdownMenuItem<AddressReturns>>(
                              (AddressReturns value) {
                        return DropdownMenuItem<AddressReturns>(
                          value: value,
                          child: buildDropdownItem(
                              '(${value.addressType}) ${value.addressLine1}',
                              isTile: controller.defaultAddress.value ==
                                  value.addressId),
                        );
                      }).toList(),
                      hint: buildDropdownItem('Select your location',
                          isTile: true),
                      onChanged: (AddressReturns? value) {
                        controller.selectAddress(value!);
                      },
                    ))),
          ),
          CommonWidget.rowWidth(width: 24),
          InkWell(
            onTap: () => Get.to(MeTab()),
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

  Widget buildDropdownItem(String value, {required bool isTile}) {
    return Row(
      children: [
        CommonWidget.rowWidth(width: 19),
        if (isTile)
          Image.asset(
            '$IMAGE_PATH/location.png',
            width: 18,
            height: 18,
          ),
        CommonWidget.rowWidth(width: 12),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: NormalText(
            text: value,
            fontSize: 16,
          ),
        )
      ],
    );
  }

  Widget buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...controller.storeDashboard.buttons.map(
            (e) => InkWell(
              onTap: () {
                Get.toNamed(e.route, arguments: [
                  {
                    "categories": [controller.storeType],
                    "latitude": controller.locationData!.latitude ?? 0,
                    "longitude": controller.locationData!.longitude ?? 0,
                  },
                  e.payload
                ]);
              },
              child: Container(
                margin: EdgeInsets.only(left: 24),
                child: Column(
                  children: [
                    ImageWidget(
                      image: e.assetId,
                      height: 36,
                      width: 36,
                    ),
                    CommonWidget.rowHeight(height: 8),
                    NormalText(
                      text: e.title,
                      fontSize: 10,
                      textColor: ColorConstants.textBlack,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildVendors(List<Stores> shops) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...shops.map((e) => buildStoreItem(e,
              width: shops.length == 1 ? Get.width - 48 : null)),
        ],
      ),
    );
  }

  Widget buildStoreItem(Stores stores, {double? width}) {
    final bool isSingle = width != null;
    final int specialityCount = isSingle ? 2 : 1;
    return StoreItem(
        isSingle: isSingle,
        width: width,
        stores: stores,
        controller: controller,
        specialityCount: specialityCount);
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
  }

  bool get isLoading {
    return controller.loading.value;
  }

  List<Datum>? get data {
    return controller.users.value == null ? [] : controller.users.value!.data;
  }
}

class PopMenu extends StatefulWidget {
  @override
  _PopMenuState createState() => _PopMenuState();
}

class _PopMenuState extends State<PopMenu> {
  List<String> _menuList = ['menu 1', 'menu 2', 'menu 3'];
  final GlobalKey _key = LabeledGlobalKey("button_icon");
  OverlayEntry? _overlayEntry;
  Offset? _buttonPosition;
  bool _isMenuOpen = false;

  void _findButton() {
    RenderBox box = _key.currentContext!.findRenderObject() as RenderBox;
    _buttonPosition = box.localToGlobal(Offset.zero); //this is global position
  }

  void _openMenu() {
    _findButton();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry!);
    _isMenuOpen = !_isMenuOpen;
  }

  void _closeMenu() {
    _overlayEntry!.remove();
    _isMenuOpen = !_isMenuOpen;
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: _buttonPosition!.dy + 70,
          left: _buttonPosition!.dx,
          width: 300,
          child: _popMenu(),
        );
      },
    );
  }

  Widget _popMenu() {
    return Material(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: Color(0xFFF67C0B9),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            _menuList.length,
            (index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 100,
                  child: Text(_menuList[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          key: _key,
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFF5C6373),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Expanded(
                child: Center(child: Text('menu 1')),
              ),
              IconButton(
                icon: Icon(Icons.arrow_downward),
                color: Colors.white,
                onPressed: () {
                  _isMenuOpen ? _closeMenu() : _openMenu();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
