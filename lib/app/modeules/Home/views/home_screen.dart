import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:cv_dragon/app/modeules/Home/controller/home_controller.dart';
import 'package:cv_dragon/app/modeules/Home/views/drawer_data_screen.dart';
import 'package:cv_dragon/app/modeules/Home/widgets/home_card_widget.dart';
import 'package:cv_dragon/device_manager/screen_constants.dart';
import 'package:cv_dragon/utils/text_utils/app_strings.dart';
import 'package:cv_dragon/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/common_text_form_field.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rightSlide = MediaQuery.of(context).size.width * 0.6;
    Uint8List bytes;
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          AnimatedBuilder(
              animation: controller.animationController,
              builder: (context, child) {
                double slide = rightSlide * controller.animationController.value +
                    ScreenConstant.defaultHeightFifteen;
                double scale = 1.1 - (controller.animationController.value * 0.3);
                return Stack(
                  children: [
                    const Scaffold(
                      backgroundColor: CustomColor.primaryBlue,
                      body: DrawerDataScreen(),
                    ),
                    Transform(
                      transform: Matrix4.identity()
                        ..translate(slide)
                        ..scale(scale),
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: ScreenConstant.defaultWidthThirty),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: CustomColor.secondaryBlue,
                              spreadRadius: 30,
                              blurRadius: 50,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Scaffold(
                            body: ListView(
                          children: [
                            Container(
                              height: ScreenConstant.defaultHeightThirty,
                            ),
                            AppBar(
                              scrolledUnderElevation: 0.0,
                              title: Text(
                                AppStrings.welcomeToCVDragon,
                                style: TextStyles.carousalSubTitleWidgetBlueText,
                              ),
                              centerTitle: false,
                              leading: Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenConstant.defaultWidthTen),
                                child: IconButton(
                                  onPressed: () => controller.toggleAnimation(),
                                  icon: AnimatedIcon(
                                    icon: AnimatedIcons.menu_close,
                                    color: CustomColor.white,
                                    progress: controller.animationController,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: ScreenConstant.defaultHeightTen,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenConstant.defaultWidthTwenty),
                              child: Text(AppStrings.title.tr,style: context.textTheme.titleMedium,),
                            ),
                            Container(
                              height: ScreenConstant.defaultHeightTen,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenConstant.defaultWidthTwenty),
                              child: DefaultEditText(
                                type: Type.stageName,
                                prefixIcon: Container(),
                                style: TextStyles.textFieldTextStyleSemiBold,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                controller: controller.titleController,
                                hintText: AppStrings.enterTitle.tr,
                              ),
                            ),
                            Container(
                              height: ScreenConstant.defaultHeightTen,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenConstant.defaultWidthTwenty),
                              child: Text(AppStrings.description.tr,style: context.textTheme.titleMedium,),
                            ),
                            Container(
                              height: ScreenConstant.defaultHeightTen,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenConstant.defaultWidthTwenty),
                              child: DefaultEditText(
                                type: Type.description,
                                prefixIcon: Container(),
                                style: TextStyles.textFieldTextStyleSemiBold,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                controller: controller.descController,
                                hintText: AppStrings.enterDescription.tr,
                              ),
                            ),
                            Container(
                              height: ScreenConstant.defaultHeightTen,
                            ),
                            Obx(
                              () => controller.temporaryDocImagePath.value.isEmpty
                                  ? const Offstage()
                                  : Text(AppStrings.image.tr),
                            ),
                            Obx(
                              () => controller.temporaryDocImagePath.value.isEmpty
                                  ? const Offstage()
                                  : Container(
                                      height: ScreenConstant.defaultHeightTen,
                                    ),
                            ),
                            Obx(
                              () => controller.temporaryDocImagePath.value.isEmpty
                                  ? const Offstage()
                                  : Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: SizedBox(
                                          height: ScreenConstant
                                              .defaultHeightOneForty,
                                          width: ScreenConstant
                                              .defaultWidthOneSeventy,
                                          child: Image.file(
                                            fit: BoxFit.fitWidth,
                                            File(controller
                                                .temporaryDocImagePath.value),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            Obx(
                              () => controller.temporaryDocImagePath.value.isEmpty
                                  ? const Offstage()
                                  : Container(
                                      height: ScreenConstant.defaultHeightTen,
                                    ),
                            ),
                            Obx(
                              () => controller.temporaryDocImagePath.value.isEmpty
                                  ? UniversalButtonWidget(
                                      ontap: () {
                                        chooseCameraOrGalleryModalBottomSheetMenu(
                                            context,
                                            (XFile? selectedImage) async {
                                          controller.temporaryDocImageName.value =
                                              selectedImage!.name;
                                          controller.temporaryDocImagePath.value =
                                              selectedImage.path;
                                          bytes =
                                              await selectedImage.readAsBytes();
                                          controller.base64String.value =
                                              base64.encode(bytes);
                                        });
                                      },
                                      color: Get.theme.dividerColor,
                                      margin: EdgeInsets.symmetric(
                                        vertical:
                                            ScreenConstant.defaultHeightFifteen,
                                        horizontal:
                                            ScreenConstant.defaultWidthTwenty,
                                      ),
                                      leadingIconvisible: true,
                                      title: AppStrings.addImage.tr,
                                      titleTextStyle: TextStyles.textStyleRegular
                                          .apply(color: CustomColor.white),
                                    )
                                  : UniversalButtonWidget(
                                      ontap: () {
                                        controller.temporaryDocImageName.value =
                                            "";
                                        controller.temporaryDocImagePath.value =
                                            "";
                                      },
                                      color: CustomColor.orange,
                                      margin: EdgeInsets.symmetric(
                                        vertical:
                                            ScreenConstant.defaultHeightFifteen,
                                        horizontal:
                                            ScreenConstant.defaultWidthTwenty,
                                      ),
                                      leadingIconvisible: true,
                                      title: AppStrings.deleteImage.tr,
                                      titleTextStyle: TextStyles.textStyleRegular
                                          .apply(color: CustomColor.white),
                                    ),
                            ),
                            Container(
                              height: ScreenConstant.defaultHeightTen,
                            ),
                            UniversalButtonWidget(
                              ontap: () {
                                if (controller.titleController.text.isNotEmpty) {
                                  if (controller.descController.text.isNotEmpty) {
                                    if (controller
                                        .base64String.value.isNotEmpty) {
                                      controller.addData(
                                          controller.titleController.text,
                                          controller.descController.text,
                                          controller.temporaryDocImagePath.value);
                                      controller.descController.text = "";
                                      controller.titleController.text = "";
                                      controller.base64String.value = "";
                                      controller.temporaryDocImagePath.value = "";
                                      controller.temporaryDocImageName.value = "";
                                    } else {
                                      showFailureSnackBar(
                                          AppStrings.somethingWentWrong.tr,
                                          AppStrings.needAImage.tr);
                                    }
                                  } else {
                                    showFailureSnackBar(
                                        AppStrings.somethingWentWrong.tr,
                                        AppStrings.needADescription.tr);
                                  }
                                } else {
                                  showFailureSnackBar(
                                      AppStrings.somethingWentWrong.tr,
                                      AppStrings.title.tr);
                                }
                              },
                              color: Get.theme.dividerColor,
                              margin: EdgeInsets.symmetric(
                                vertical: ScreenConstant.defaultHeightFifteen,
                                horizontal: ScreenConstant.defaultWidthTwenty,
                              ),
                              leadingIconvisible: true,
                              title: AppStrings.addVlog.tr,
                              titleTextStyle: TextStyles.textStyleRegular
                                  .apply(color: CustomColor.white),
                            ),
                            Container(
                              height: ScreenConstant.defaultHeightTen,
                            ),
                            Obx(
                              () => controller.allData.isEmpty
                                  ? const Center(
                                      child: Text(AppStrings.vlogsListIsEmpty))
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenConstant.defaultWidthTwenty),
                                      child: ListView.builder(
                                          physics: const ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller.allData.length,
                                          itemBuilder: (context, index) =>
                                              HomeCardWidget(
                                                title: controller.allData[index]
                                                    ["title"],
                                                description: controller
                                                    .allData[index]["desc"],
                                                image: controller.allData[index]
                                                    ["image"],
                                                onTapDelete: () {
                                                  controller.deleteData(controller
                                                      .allData[index]["id"]);
                                                },
                                                onTapEdit: () {
                                                  Get.toNamed(
                                                      Routes.UPDATEDETAILS,
                                                      arguments: [
                                                        controller.allData[index]
                                                            ["id"],
                                                        controller.allData[index]
                                                            ["title"],
                                                        controller.allData[index]
                                                            ["desc"],
                                                        controller.allData[index]
                                                            ["image"]
                                                      ]);
                                                },
                                              )),
                                    ),
                            )
                          ],
                        )),
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }
}
