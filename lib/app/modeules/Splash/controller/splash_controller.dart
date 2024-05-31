import 'dart:async';

import 'package:cv_dragon/utils/Store/HiveStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';

class SplashController extends GetxController{
  RxBool isLoading = false.obs;
  void onReady() {
    print("OnReady");
    HiveStore().getBool(Keys.ISDARK) == true?
    Get.changeThemeMode(ThemeMode.dark):Get.changeThemeMode(ThemeMode.light);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Timer(const Duration(seconds: 3), () async {
      Get.offAllNamed(Routes.HOME);
      print("Route Home");
    });
    super.onReady();
  }
}