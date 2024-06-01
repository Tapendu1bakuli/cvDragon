import 'package:cv_dragon/database/db_helper.dart';
import 'package:cv_dragon/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{

  late final AnimationController animationController;

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
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    refreshData();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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

  toggleAnimation() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }
}