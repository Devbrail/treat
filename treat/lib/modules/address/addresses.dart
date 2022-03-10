import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treat/models/response/addresses.dart';
import 'package:treat/modules/account/account_controller.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';
import 'package:treat/shared/widgets/text_widget.dart';

import 'location_form.dart';
import 'location_selection.dart';

class AddressesView extends StatefulWidget {
  const AddressesView({Key? key}) : super(key: key);

  @override
  _AddressesViewState createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> {
  AccountController ctl = Get.put(AccountController(apiRepository: Get.find()));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) => ctl.loadAddresses());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, top: 48, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: Get.back,
                  child: Icon(
                    Icons.chevron_left,
                    size: 34,
                    color: Colors.black,
                  ),
                ),
                NormalText(
                  text: 'Addresses',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  textColor: ColorConstants.redemptionTextBlack,
                ),
                Icon(
                  Icons.chevron_left,
                  size: 48,
                  color: Colors.white,
                )
              ],
            ),
          ),
          GetBuilder<AccountController>(
              id: 'addr',
              builder: (cntrlr) {
                return Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    if (cntrlr.addresses.value == null ||
                        (cntrlr.addresses.value as Addresses).addressReturns ==
                            null ||
                        (cntrlr.addresses.value as Addresses)
                            .addressReturns
                            .isEmpty)
                      Container(
                        height: Get.width * .9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 36,
                            ),
                            Container(
                              child: Image.asset(
                                  'assets/images/address_empty.png'),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            NormalText(text: 'No saved locations found!'),
                            SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...cntrlr.addresses.value!.addressReturns.map(
                              (addr) => Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 8),
                                child: InkWell(
                                  onTap: () {

                                    Get.to(LocationForm(location: {
                                      ...addr.toJson(),
                                      'tit': addr.addressLine1,
                                      'edit': true
                                    }));
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 26,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFE6E6E6),
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: Image.asset(
                                            icons[addr.apartment]['icon'],
                                            color: ColorConstants.textBlack),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NormalText(
                                              text: addr.addressType,
                                              textAlign: TextAlign.start,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            NormalText(
                                              textAlign: TextAlign.start,
                                              text: addr.addressLine1,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_outlined,
                                        size: 34,
                                        color: ColorConstants.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 36,
                            ),
                          ],
                        ),
                      )
                  ],
                );
              }),
          SizedBox(
            height: 14,
          ),
          Container(
            height: 34,
            width: Get.width * .4,
            decoration: BoxDecoration(
                color: ColorConstants.black,
                borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              onTap: () {
                Get.to(LocationSelection());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: ColorConstants.white,
                  ),
                  NormalText(
                    text: 'Add Location',
                    textColor: ColorConstants.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
