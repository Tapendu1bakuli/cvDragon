import 'package:cv_dragon/database/db_helper.dart';
import 'package:cv_dragon/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{
  //for controlling the smooth animation while showing the home and drawer.
  late final AnimationController animationController;
  //for toggle between drawer and home UI.
  RxBool toggleValue = false.obs;
  //for fetching all data from db.
  RxList<Map<String, dynamic>> allData = <Map<String, dynamic>>[].obs;
  //for showing circular progress indicator if needed while loading some data .
  RxBool isLoading = false.obs;
  //variables for all the text form fields.
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController titleEditController = TextEditingController();
  final TextEditingController descEditController = TextEditingController();
  //variables for storing the image path and image name after get the image either from gallery or camera.
  RxString temporaryDocImageName = "".obs;
  RxString temporaryDocImagePath = "".obs;


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
  //refresh data's after add or update or delete.
  void refreshData() async {
    final data = await SQLHelper.getAllData();
    allData.value = data;
    isLoading.value = false;
  }
  //add data to db
 Future<void> addData(String title, String desc,String image) async {
  await SQLHelper.createData(title, desc,image);
  refreshData();
 }
  //update data to db.
  Future<void> updateData(int id,String title,String description,String image) async {
    await SQLHelper.updateData(id,title, description,image);
    refreshData();
    Get.back();
  }
  //delete data from db.
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