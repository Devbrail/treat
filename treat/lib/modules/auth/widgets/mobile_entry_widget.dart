import 'package:country_pickers/country.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/utils/common_widget.dart';
import 'package:treat/shared/widgets/auth_input_field.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class MobileEntryWidget extends StatelessWidget {
  final Country country;
  final ValueChanged<Country> onValuePicked;
  final TextEditingController controller;
  final Country selectedCountry;
  const MobileEntryWidget({
    Key? key,
    required this.country,
    required this.onValuePicked,
    required this.controller,
    required this.selectedCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildDialogItem(Country country) => Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(width: 8.0),
            Text("+${country.phoneCode}"),
            SizedBox(width: 8.0),
            Flexible(child: Text(country.name))
          ],
        );
    void _openCountryPickerDialog() => showDialog(
          context: context,
          builder: (context) => Theme(
            data: Theme.of(context)
                .copyWith(primaryColor: ColorConstants.darkGray),
            child: CountryPickerDialog(
              titlePadding: EdgeInsets.all(8.0),
              searchCursorColor: ColorConstants.darkGray,
              searchInputDecoration: InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              title: Text('Select your country code'),
              onValuePicked: onValuePicked,
              itemBuilder: _buildDialogItem,
              priorityList: [
                CountryPickerUtils.getCountryByIsoCode('IN'),
                CountryPickerUtils.getCountryByIsoCode('CA'),
              ],
            ),
          ),
        );

    return Row(
      children: [
        CountryPickerDropdown(
          initialValue: selectedCountry.isoCode,
          iconSize: 0,
          onTap: () => showDialog(
            context: context,
            builder: (context) => CountryPickerDialog(
              titlePadding: EdgeInsets.all(8.0),
              searchCursorColor: ColorConstants.darkGray,
              searchInputDecoration: InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              title: Text('Select your country code'),
              onValuePicked: (Country country) => print('picker'),
              priorityList: [
                CountryPickerUtils.getCountryByIsoCode('TR'),
                CountryPickerUtils.getCountryByIsoCode('US'),
              ],
              itemBuilder: _buildDialogItem,
            ),
          ),
          itemBuilder: (countryBuilder) => Container(
            height: 48,
            width: 124,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorConstants.whiteGrey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              onTap: _openCountryPickerDialog,
              title: Center(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CountryPickerUtils.getDefaultFlagImage(country),
                      CommonWidget.rowWidth(width: 4),
                      NormalText(text: country.isoCode),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                        color: ColorConstants.darkGray,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          icon: null,
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('GB'),
            CountryPickerUtils.getCountryByIsoCode('CN'),
          ],
          sortComparator: (Country a, Country b) =>
              a.isoCode.compareTo(b.isoCode),
          onValuePicked: (Country country) {
            print("${country.name}");
          },
        ),
        CommonWidget.rowWidth(width: 12),
        Expanded(
          flex: 3,
          child: AuthTextField(
              hint: '(999) 999-9999',
              textInputType: TextInputType.phone,
              controller: controller),
        ),
      ],
    );
  }
}
