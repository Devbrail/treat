import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:treat/modules/auth/widgets/pin_input_fields.dart';
import 'package:treat/modules/dynamic_redeem/dynamic_redeem_controller.dart';
import 'package:treat/modules/redeem/redeem.dart';
import 'package:treat/routes/app_pages.dart';
import 'package:treat/shared/constants/colors.dart';
import 'package:treat/shared/constants/common.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/widgets/action_button.dart';
import 'package:treat/shared/widgets/rating_widget.dart';
import 'package:treat/shared/widgets/text_widget.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  TextEditingController _controller = TextEditingController();
  DynamicRedeemController _rc =
      Get.put(DynamicRedeemController(apiRepository: Get.find()));

  @override
  void initState() {
    super.initState();
  }

  late final ValueChanged<Country> onValuePicked;
  // late final Country selectedCountry;

  @override
  Widget build(BuildContext context) {
    Widget _buildDropdownItem(Country country) => Container(
          child: Container(
            width: Get.width - 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CountryPickerUtils.getDefaultFlagImage(country),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(child: Text("${country.name}")),
              ],
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.white,
        title: NormalText(
          text: "Add Card",
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorConstants.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalText(
                  text: "Card Numbers",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConstants.textfieldbgGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          prefixStyle: TextStyle(
                              color: ColorConstants.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width / 2 - 30,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                            text: "Expiry Date",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: ColorConstants.textfieldbgGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "MM/YY",
                                    hintStyle: TextStyle(
                                        color: const Color(0xFF767676),
                                        fontSize: 14),
                                    prefixStyle: TextStyle(
                                        color: ColorConstants.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width / 2 - 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NormalText(
                            text: "CVV",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: ColorConstants.textfieldbgGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: const Color(0xFF767676),
                                        fontSize: 14),
                                    prefixStyle: TextStyle(
                                        color: ColorConstants.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                NormalText(
                  text: "Postal Code",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConstants.textfieldbgGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          prefixStyle: TextStyle(
                              color: ColorConstants.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                NormalText(
                  text: "Country",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConstants.textfieldbgGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: CountryPickerDropdown(
                      initialValue: 'IN',
                      itemBuilder: _buildDropdownItem,
                      // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
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
                  ),
                ),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    NormalText(
                      text: "Save card for future use",
                      fontSize: 14,
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      // _rc.animatePage(3);
                    },
                    child: Container(
                      width: 170,
                      height: 46,
                      decoration: BoxDecoration(
                        color: _rc.hasRated
                            ? const Color(0xFFB063E3)
                            : const Color(0xFFB7B7B7),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: NormalText(
                        text: 'Next',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textColor: ColorConstants.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
}
