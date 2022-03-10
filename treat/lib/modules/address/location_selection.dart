import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:treat/modules/address/location_form.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';
import 'package:treat/shared/widgets/text_widget.dart';
import 'package:dio/dio.dart' as D;

class LocationSelection extends StatefulWidget {
  const LocationSelection({Key? key}) : super(key: key);

  @override
  _LocationSelectionState createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {
  var searchTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 8, top: 32),
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
            Container(
              height: 34,
              margin: EdgeInsets.only(bottom: 14, right: 21, top: 24, left: 21),
              decoration: BoxDecoration(
                  color: Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(18)),
              alignment: Alignment.center,
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  controller: searchTC,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  cursorColor: ColorConstants.black,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w400,
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
                        Icons.search,
                        color: ColorConstants.black,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  D.Response res = await D.Dio().get(
                      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$pattern&key=AIzaSyDsaPA8h1O6afo6J5ZuJFQDORVHo1fsFSU');
                  print('res.data');
                  print(res.data);
                  if (res.statusCode == 200)
                    return (res.data['predictions'] as List)
                        .map((e) => '${e['description']}');
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
                    title: NormalText(
                      text: suggestion as String,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                  );
                },
                onSuggestionSelected: (suggestion) async {
                  String sug = (suggestion as String).split('###')[0];
                  searchTC.text = sug.characters.take(30).toString();

                  List<Location> locations = await locationFromAddress(sug);

                  Get.to(LocationForm(
                      location: {'tit': sug, ...locations[0].toJson()}));
                  suggestion.printInfo();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
