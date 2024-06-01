import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_utils/app_strings.dart';

class HomeCardWidget extends StatelessWidget {
   HomeCardWidget({super.key,this.image,this.title,this.description,this.onTapEdit,this.onTapDelete});
  String? image;
  String? title;
  String? description;
  Function()? onTapEdit;
  Function()? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  File(image??""),
                ),),
            ),
            Container(width: ScreenConstant.defaultWidthTen,),
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppStrings.title} ${title??""}",
                  style: context.textTheme.headlineSmall),
                Text(
                  "${AppStrings.description} ${description??""}",
                  style: context.textTheme.headlineSmall,
                ),
              ],
            ),
            const Spacer(),
            InkWell(
                onTap: onTapEdit,
                child: const Icon(
                  Icons.edit,
                  color: CustomColor.primaryBlue,
                )),
            Container(
              width: ScreenConstant.defaultWidthTen,
            ),
            InkWell(
                onTap: onTapDelete,
                child: const Icon(
                  Icons.delete,
                  color: CustomColor.orange,
                ))
          ],
        ),
      ),
    );
  }
}
