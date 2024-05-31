import 'package:cv_dragon/app/modeules/Splash/controller/splash_controller.dart';
import 'package:cv_dragon/device_manager/screen_constants.dart';
import 'package:cv_dragon/utils/animation_utilis/animation_utilis.dart';
import 'package:cv_dragon/utils/text_utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/TextStyles.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.isLoading.value = false;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: ScreenConstant.defaultHeightNinety,
                width: ScreenConstant.defaultWidthEighty,
                child: Lottie.asset(AnimationUtilis.splashAnimation)),
            Text(
              AppStrings.welcomeToCVDragon,
              style: TextStyles.carousalSubTitleWidgetBlueText,
            )
          ],
        ),
      ),
    );
  }
}
