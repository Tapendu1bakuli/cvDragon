import 'package:cv_dragon/app/modeules/Home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/common_text_form_field.dart';
import '../../../../utils/text_utils/app_strings.dart';

class UpdateDetailsScreen extends GetView<HomeController> {
  const UpdateDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.updateDetails.tr,
          style: TextStyles.carousalSubTitleWidgetBlueText,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenConstant.defaultWidthTen,
            vertical: ScreenConstant.defaultHeightForty),
        child: ListView(
          children: [
            Container(
              height: ScreenConstant.defaultHeightTen,
            ),
            Text(AppStrings.title.tr),
            Container(
              height: ScreenConstant.defaultHeightTen,
            ),
            DefaultEditText(
              type: Type.stageName,
              prefixIcon: Container(),
              style: TextStyles.textFieldTextStyleSemiBold,
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: controller.titleEditController,
              hintText: data[1],
            ),
            Container(
              height: ScreenConstant.defaultHeightTen,
            ),
            Text(AppStrings.description.tr),
            Container(
              height: ScreenConstant.defaultHeightTen,
            ),
            DefaultEditText(
              type: Type.description,
              prefixIcon: Container(),
              style: TextStyles.textFieldTextStyleSemiBold,
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: controller.descEditController,
              hintText: data[2],
            ),
            Container(
              height: ScreenConstant.defaultHeightTen,
            ),
            UniversalButtonWidget(
              ontap: () {
                controller.updateData(
                    data[0],
                    controller.titleEditController.text.isEmpty
                        ? data[1]
                        : controller.titleEditController.text,
                    controller.descEditController.text.isEmpty
                        ? data[2]
                        : controller.descEditController.text);
                controller.descEditController.text = "";
                controller.titleEditController.text = "";
                Get.back();
              },
              color: CustomColor.primaryBlue,
              margin: EdgeInsets.symmetric(
                vertical: ScreenConstant.defaultHeightFifteen,
                horizontal: ScreenConstant.defaultWidthTwenty,
              ),
              leadingIconvisible: true,
              title: AppStrings.updateVlog.tr,
              titleTextStyle:
                  TextStyles.textStyleRegular.apply(color: CustomColor.white),
            ),
          ],
        ),
      ),
    );
  }
}
