import 'package:get/get.dart';
import 'package:firebasebase/controller/home_screen_controller.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies(){
    Get.put<HomeScreenController>(HomeScreenController());
  }
}