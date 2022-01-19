import 'dart:async';

  import 'package:dio/dio.dart' as D;
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:location/location.dart';
import 'package:treat/modules/address/location_selection.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/constants/constants.dart';
import 'package:treat/shared/utils/common_function.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late GoogleMapsController controller;
  late StreamSubscription<CameraPosition> subscription;
  late CameraPosition position;

  @override
  void initState() {
    super.initState();

    LocationData locationData = Get.arguments;
    LatLng latLng;
    if (locationData.longitude != -141) {
      latLng = LatLng(locationData.latitude!, locationData.longitude!);
    } else
      latLng = LatLng(45.593920, -75.616267);

    latLng.printInfo(info: 'dslkm');
    controller = GoogleMapsController(
      initialCameraPosition: CameraPosition(
        target: latLng,
        zoom: 14.4746,
      ),
      zoomControlsEnabled: false,
      buildingsEnabled: true,
      indoorViewEnabled: true,
      trafficEnabled: true,
      mapToolbarEnabled: true,
    );

    subscription = controller.onCameraMove$.listen((e) {
      setState(() {
        position = e;
      });
    });
  }

  HomeController hc = Get.put(HomeController(apiRepository: Get.find()));

  @override
  void dispose() {
    subscription.cancel();
    searchTC.dispose();
    super.dispose();
  }

  ButtonState state = ButtonState.init;

  bool isAnimating = true;

  bool showConfirmDialog = false;
  String locationString = '';
  bool isLoading = false;
  var searchTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width;
    final isInit = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.completed;
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: GoogleMaps(
              controller: controller,
            ),
          ),
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  height: 34,
                  margin:
                      EdgeInsets.only(top: 18, bottom: 14, right: 21, left: 21),
                  decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(18)),
                  alignment: Alignment.center,
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      // autofocus: true,
                      controller: searchTC,
                      textInputAction: TextInputAction.done,

                      cursorColor: ColorConstants.black,
                      style: GoogleFonts.roboto(
                        color: ColorConstants.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        focusColor: ColorConstants.black,
                        hintStyle: GoogleFonts.roboto(
                          color: ColorConstants.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                        hintText: 'Search',
                        prefixIcon: InkWell(
                          onTap: () => searchTC.clear(),
                          child: Icon(
                            searchTC.text.isNotEmpty
                                ? Icons.arrow_back
                                : Icons.search,
                            color: ColorConstants.black,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      D.Response res = await D.Dio().get(
                          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$pattern&types=establishment&key=AIzaSyDsaPA8h1O6afo6J5ZuJFQDORVHo1fsFSU');
                      if (res.statusCode == 200)
                        return (res.data['predictions'] as List)
                            .map((e) => e['description']);
                      else
                        return [];
                      // return await controller.getSuggestion(pattern);
                    },
                    hideOnLoading: true,
                    hideOnEmpty: true,
                    loadingBuilder: (context) => Text(''),
                    hideSuggestionsOnKeyboardHide: false,
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text('$suggestion'),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      searchTC.text =
                          (suggestion as String).characters.take(30).toString();
                      suggestion.printInfo();

                      Utils.locationFromAddresses(suggestion).then((value) {
                        locationString = suggestion;
                        updateUIAfterLocationFetch(
                            LatLng(value.latitude, value.longitude),
                            suggestion);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16, left: 21),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...hc.getAddress.skip(1).map(
                              (e) => InkWell(
                                onTap: () {
                                  locationString = e.addressLine1;
                                  updateUIAfterLocationFetch(
                                      LatLng(e.latitude, e.longitude),
                                      e.addressLine1);
                                },
                                child: Container(
                                  width: 116,
                                  margin: EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                      color: ColorConstants.white,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(3.0),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            color: const Color(0xFFE6E6E6)),
                                        child: Icon(
                                          Utils.addressType(e.addressType),
                                          color: ColorConstants.black,
                                          size: 24,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          NormalText(
                                            text: e.addressType,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          NormalText(
                                            text: e.addressLine1,
                                            fontSize: 8,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                              color: ColorConstants.white,
                              borderRadius: BorderRadius.circular(24)),
                          child: InkWell(
                            onTap: () {
                              Get.to(LocationSelection());
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 4),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6E6E6),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: ColorConstants.textBlack,
                                  ),
                                ),
                                NormalText(
                                  text: 'Add Location',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          if (!showConfirmDialog)
            Positioned(
              right: 3,
              bottom: Get.height * .3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: IconButton(
                    onPressed: () async {
                      getCurrentLocation();
                    },
                    icon: Icon(
                      Icons.my_location,
                      color: Colors.black,
                      size: 24,
                    )),
              ),
            ),
          if (showConfirmDialog)
            Positioned(
              bottom: 34,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 150,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NormalText(
                          text: 'Confirm your location',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        NormalText(
                          text: locationString,
                          fontSize: 14,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              onEnd: () => setState(() {
                                    isAnimating = !isAnimating;
                                  }),
                              width:
                                  state == ButtonState.init ? buttonWidth : 60,
                              height: 60,
                              child: isInit
                                  ? buildButton()
                                  : circularContainer(isDone)),
                        )
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          controller.removeMarker(controller.markers.first);
                          setState(() {
                            state = ButtonState.init;
                            locationString = '';
                            showConfirmDialog = false;
                            isAnimating = true;
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  updateUIAfterLocationFetch(LatLng coordinate, String locationString) {
    datum = {
      'lat': coordinate.latitude,
      'lng': coordinate.longitude,
      'address': locationString
    };
    showConfirmDialog = true;
    setState(() {});
    addMarker(coordinate);
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: coordinate,
        zoom: 17.0,
      ),
    ));
  }

  late Map<String, dynamic> datum;

  Widget buildButton() => InkWell(
        onTap: () async {
          setState(() {
            state = ButtonState.submitting;
          });
          await Future.delayed(Duration(seconds: 2));
          setState(() {
            state = ButtonState.completed;
          });
        },
        child: Container(
            height: 34,
            margin:
                EdgeInsets.symmetric(horizontal: Get.width * .2, vertical: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF8E5ABE),
              borderRadius: BorderRadius.circular(16),
            ),
            child: NormalText(
              text: 'Confirm and Proceed',
              textColor: Colors.white,
            )),
      );

  Widget circularContainer(bool done) {
    final color = done ? const Color(0xFF8E5ABE) : const Color(0xFF8E5ABE);
    return InkWell(
      onTap: () {
        if (done) {
          Get.back(result: datum);
        }
      },
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        margin: EdgeInsets.all(8),
        child: Center(
          child: done
              ? const Icon(Icons.done_rounded, size: 28, color: Colors.white)
              : SizedBox(
                  height: 28,
                  width: 28,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  Future<BitmapDescriptor> getIcons() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(16, 22)), "$IMAGE_PATH/marker.png");
  }

  void addMarker(LatLng coordinate, {String mId = '1'}) async {
    controller.addMarker(
      Marker(
        markerId: MarkerId(mId),
        position: coordinate,
        icon: await getIcons(),
        onTap: () => controller.removeMarker(controller.markers
            .firstWhere((element) => element.markerId == MarkerId(mId))),
      ),
    );
  }

  void getCurrentLocation() async {
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
      LatLng coordinate =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      locationString = await Utils.getAddressFromLatLng(
          coordinate.latitude, coordinate.longitude);

      updateUIAfterLocationFetch(coordinate, locationString);
    } catch (e) {}
  }
}

enum ButtonState { init, submitting, completed }
