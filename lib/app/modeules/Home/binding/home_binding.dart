import 'package:cv_dragon/app/modeules/Home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>HomeController());
  }
}