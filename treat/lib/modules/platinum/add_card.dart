import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:treat/modules/auth/widgets/pin_input_fields.dart';
import 'package:treat/modules/platinum/platinum_controller.dart';
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
  PlatinumController _rc =
      Get.put(PlatinumController(apiRepository: Get.find()));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [],
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
