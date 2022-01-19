import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:treat/modules/home/home.dart';
import 'package:treat/routes/routes.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/auth_input_field.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class LocationForm extends StatefulWidget {
  const LocationForm({Key? key, required this.location}) : super(key: key);
  final Map<String, Object> location;

  @override
  _LocationFormState createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  late GoogleMapsController controller;
  TextEditingController addressLabel = TextEditingController();
  List icons = [
    {'icon': '$IMAGE_PATH/home_loc.png', 'flg': true},
    {'icon': '$IMAGE_PATH/briefcase_loc.png', 'flg': false},
    {'icon': '$IMAGE_PATH/heart_loc.png', 'flg': false},
    {'icon': '$IMAGE_PATH/flag_loc.png', 'flg': false},
    {'icon': '$IMAGE_PATH/star_loc.png', 'flg': false},
  ];

  @override
  void initState() {
    print('widget.location');
    print(widget.location);
    controller = GoogleMapsController(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location['latitude'] as double,
              widget.location['longitude'] as double),
          zoom: 14.4746,
        ),
        initialMarkers: Set<Marker>.of(
          <Marker>[
            Marker(
                onTap: () {
                  print('Tapped');
                },
                draggable: true,
                markerId: MarkerId('Marker'),
                position: LatLng(widget.location['latitude'] as double,
                    widget.location['longitude'] as double),
                onDragEnd: ((newPosition) {
                  print(newPosition.latitude);
                  print(newPosition.longitude);
                }))
          ],
        ),
        zoomControlsEnabled: false,
        buildingsEnabled: true,
        indoorViewEnabled: true,
        trafficEnabled: true,
        mapToolbarEnabled: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 8, top: 32, bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: ColorConstants.textBlack,
                        size: 38,
                      ),
                    ),
                    Spacer(),
                    NormalText(
                      text: 'Select Location',
                      textColor: ColorConstants.textBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    Spacer()
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * .4,
                width: Get.width,
                child: GoogleMaps(
                  controller: controller,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 36,
                      child: AuthTextField(
                          hint: '',
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: ColorConstants.textBlack,
                          ),
                          enabled: false,
                          textStyle: GoogleFonts.roboto(
                              color: ColorConstants.textBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          controller: TextEditingController(
                              text: widget.location['tit'] as String),
                          onChange: (String text) {
                            // controller.listeningTextChange();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: NormalText(
                        text: 'Address Label',
                        fontSize: 14,
                        textColor: ColorConstants.textBlack,
                        fontWeight: FontWeight.w500,
                        // textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: 36,
                      child: AuthTextField(
                          hint: 'Add Label (ex. Office)',
                          textStyle: GoogleFonts.roboto(
                              color: ColorConstants.textBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          controller: addressLabel,
                          onChange: (String text) {
                            setState(() {});
                            // controller.listeningTextChange();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: NormalText(
                        text: 'Label Icon',
                        fontSize: 14,
                        textColor: ColorConstants.textBlack,
                        fontWeight: FontWeight.w500,
                        // textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...icons.map(
                          (e) => InkWell(
                            onTap: () {
                              icons.forEach((element) {
                                element['flg'] = false;
                                if (e['icon'] == element['icon'])
                                  element['flg'] = true;
                              });
                              setState(() {});
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: e['flg']
                                      ? const Color(0xFF464646)
                                      : const Color(0xFFE6E6E6),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Image.asset(
                                e['icon'],
                                color: e['flg']
                                    ? ColorConstants.white
                                    : ColorConstants.textBlack,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.symmetric(horizontal: 42, vertical: 24),
                      decoration: BoxDecoration(
                        color: labelIsEmpty
                            ? const Color(0xFFBFBFBF)
                            : const Color(0xFF8E5ABE),
                        borderRadius: BorderRadius.circular(34),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                      child: InkWell(
                        onTap: () {
                          HomeController hc = Get.put(
                              HomeController(apiRepository: Get.find()));
                          hc.addAddress({
                            'addressType': addressLabel.text.trim(),
                            'latitude': widget.location['latitude'],
                            'longitude': widget.location['longitude'],
                            "addressLine1": widget.location['tit'],
                            "apartment": icons
                                .indexWhere((element) => element['flg'], 0)
                                .toString(),
                            "city": "",
                            "province": "",
                            "zipCode": ""
                          });

                        },
                        child: NormalText(
                          text: 'Save and Continue',
                          textColor: ColorConstants.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  get labelIsEmpty => addressLabel.text.isEmpty;
}
