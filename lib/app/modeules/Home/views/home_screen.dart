import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:cv_dragon/app/modeules/Home/controller/home_controller.dart';
import 'package:cv_dragon/device_manager/screen_constants.dart';
import 'package:cv_dragon/utils/Store/HiveStore.dart';
import 'package:cv_dragon/utils/text_utils/app_strings.dart';
import 'package:cv_dragon/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../common/widgets/toggle_button.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/common_text_form_field.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Uint8List bytes;
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
                    AppStrings.insertVlog.tr,
                    style: Get.textTheme.titleLarge
                        ?.merge(TextStyle(color: context.theme.primaryColor)),
                  ),
                  const Spacer(),
                  Icon(
                    HiveStore().getBool(Keys.ISDARK)
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: CustomColor.primaryBlue,
                  ),
                  CupertinoSwitch(
                    value: HiveStore().getBool(Keys.ISDARK),
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
                ],
              ),
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
                controller: controller.titleController,
                hintText: AppStrings.enterTitle.tr,
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
                controller: controller.descController,
                hintText: AppStrings.enterDescription.tr,
              ),
              Container(
                height: ScreenConstant.defaultHeightTen,
              ),
              Obx(()=> controller
                    .temporaryDocImagePath
                    .value.isEmpty?const Offstage():Center(
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(20),
                    child: SizedBox(
                      height: ScreenConstant
                          .defaultHeightOneForty,
                      width: ScreenConstant
                          .defaultWidthOneSeventy,
                      child: Image.file(
                        fit: BoxFit.fitWidth,
                        File(controller.temporaryDocImagePath.value),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(()=> controller
                    .temporaryDocImagePath
                    .value.isEmpty?const Offstage():Container(
                  height: ScreenConstant.defaultHeightTen,
                ),
              ),
              Obx(()=> controller
                    .temporaryDocImagePath
                    .value.isEmpty?UniversalButtonWidget(
                  ontap: () {
                    chooseCameraOrGalleryModalBottomSheetMenu(context,(XFile? selectedImage)async {
                      controller
                          .temporaryDocImageName
                          .value =
                          selectedImage!.name;
                      controller
                          .temporaryDocImagePath
                          .value =
                          selectedImage.path;
                      print(
                          controller.temporaryDocImagePath.value);
                      bytes = await selectedImage.readAsBytes();
                      controller.base64String.value = base64.encode(bytes);
                    });
                  },
                  color: CustomColor.primaryBlue,
                  margin: EdgeInsets.symmetric(
                    vertical: ScreenConstant.defaultHeightFifteen,
                    horizontal: ScreenConstant.defaultWidthTwenty,
                  ),
                  leadingIconvisible: true,
                  title: AppStrings.addImage.tr,
                  titleTextStyle:
                  TextStyles.textStyleRegular.apply(color: CustomColor.white),
                ):UniversalButtonWidget(
                  ontap: () {
                    controller
                        .temporaryDocImageName
                        .value ="";
                    controller
                        .temporaryDocImagePath
                        .value ="";
                  },
                  color: CustomColor.orange,
                  margin: EdgeInsets.symmetric(
                    vertical: ScreenConstant.defaultHeightFifteen,
                    horizontal: ScreenConstant.defaultWidthTwenty,
                  ),
                  leadingIconvisible: true,
                  title: AppStrings.deleteImage.tr,
                  titleTextStyle:
                  TextStyles.textStyleRegular.apply(color: CustomColor.white),
                ),
              ),
              Container(
                height: ScreenConstant.defaultHeightTen,
              ),
              UniversalButtonWidget(
                ontap: () {
                  if (controller.titleController.text.isNotEmpty) {
                    if (controller.descController.text.isNotEmpty) {
                      if(controller.base64String.value.isNotEmpty){
                        controller.addData(controller.titleController.text,
                            controller.descController.text, controller
                                .temporaryDocImagePath
                                .value);
                        controller.descController.text = "";
                        controller.titleController.text = "";
                        controller.base64String.value = "";
                        controller.temporaryDocImagePath.value = "";
                        controller.temporaryDocImageName.value = "";
                      }else{
                        showFailureSnackBar(AppStrings.somethingWentWrong.tr,
                            AppStrings.needAImage.tr);
                      }
                    } else {
                      showFailureSnackBar(AppStrings.somethingWentWrong.tr,
                          AppStrings.needADescription.tr);
                    }
                  } else {
                    showFailureSnackBar(
                        AppStrings.somethingWentWrong.tr, AppStrings.title.tr);
                  }
                },
                color: CustomColor.primaryBlue,
                margin: EdgeInsets.symmetric(
                  vertical: ScreenConstant.defaultHeightFifteen,
                  horizontal: ScreenConstant.defaultWidthTwenty,
                ),
                leadingIconvisible: true,
                title: AppStrings.addVlog.tr,
                titleTextStyle:
                    TextStyles.textStyleRegular.apply(color: CustomColor.white),
              ),
              Container(
                height: ScreenConstant.defaultHeightTen,
              ),
              Obx(
                () => controller.allData.isEmpty
                    ? const Center(child: Text(AppStrings.vlogsListIsEmpty))
                    : ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.allData.length,
                        itemBuilder: (context, index) => Card(
                              elevation: 2,
                              margin: EdgeInsets.symmetric(
                                  horizontal: ScreenConstant.defaultWidthTen,
                                  vertical:
                                      ScreenConstant.defaultHeightFifteen),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenConstant.defaultWidthTen,
                                    vertical:
                                        ScreenConstant.defaultHeightFifteen),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: SizedBox(
                                        height: ScreenConstant.defaultHeightNinety,
                                        child: Image.file(
                                        fit: BoxFit.fitWidth,
                                        File(controller.allData[index]["image"]),
                                      ),),
                                    ),
                                    Container(width: ScreenConstant.defaultWidthTen,),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${AppStrings.title} ${controller.allData[index]["title"]}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          "${AppStrings.description} ${controller.allData[index]["desc"]}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.UPDATEDETAILS,arguments: [controller.allData[index]
                                          ["id"],
                                            controller.allData[index]
                                            ["title"],
                                            controller.allData[index]
                                            ["desc"],
                                              controller.allData[index]
                                              ["image"]]
                                          );
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: CustomColor.primaryBlue,
                                        )),
                                    Container(
                                      width: ScreenConstant.defaultWidthTen,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          controller.deleteData(controller.allData[index]
                                          ["id"]);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: CustomColor.orange,
                                        ))
                                  ],
                                ),
                              ),
                            )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
