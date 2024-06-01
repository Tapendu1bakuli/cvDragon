import 'dart:typed_data';

import 'package:cv_dragon/database/db_helper.dart';
import 'package:cv_dragon/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class HomeController extends GetxController{

  RxBool toggleValue = false.obs;
  RxList<Map<String, dynamic>> allData = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController titleEditController = TextEditingController();
  final TextEditingController descEditController = TextEditingController();

  RxString temporaryDocImageName = "".obs;
  RxString temporaryDocImagePath = "".obs;

  RxString base64String = "".obs;

@override
  void onInit() {
    super.onInit();
    refreshData();
  }

  void refreshData() async {
    final data = await SQLHelper.getAllData();
    allData.value = data;
    isLoading.value = false;
  }

 Future<void> addData(String title, String desc,String image) async {
  await SQLHelper.createData(title, desc,image);
  refreshData();
 }

  Future<void> updateData(int id,String title,String description,String image) async {
    await SQLHelper.updateData(id,title, description,image);
    refreshData();
    Get.back();
  }

  Future<void> deleteData(int id) async {
    await SQLHelper.deleteData(id);
    showSuccessSnackbar("Item deleted", "Deletion successful.");
    refreshData();
  }
}