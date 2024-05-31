import 'package:cv_dragon/app/modeules/Home/controller/home_controller.dart';
import 'package:cv_dragon/device_manager/screen_constants.dart';
import 'package:cv_dragon/utils/Store/HiveStore.dart';
import 'package:cv_dragon/utils/text_utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/toggle_button.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.welcomeToCVDragon,
            style: TextStyles.carousalSubTitleWidgetBlueText,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenConstant.defaultWidthTwenty,
              vertical: ScreenConstant.defaultHeightFifteen),
          child: ListView(
            children: [
              Row(
                children: [
                  Text(
                    AppStrings.toggleBetweenTheme,
                    style: Get.textTheme.titleLarge
                        ?.merge(TextStyle(color: context.theme.primaryColor)),
                  ),
                  const Spacer(),
                  Icon(
                    controller.toggleValue.value
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: CustomColor.primaryBlue,
                  ),
                  Obx(
                    () => CupertinoSwitch(
                      value: controller.toggleValue.value,
                      onChanged: (value) {
                        controller.toggleValue.value = value;
                        HiveStore().setBool(Keys.ISDARK, value);
                        print(HiveStore().getBool(Keys.ISDARK));
                        if (controller.toggleValue.value) {
                          Get.changeThemeMode(ThemeMode.dark);
                        } else {
                          Get.changeThemeMode(ThemeMode.light);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
