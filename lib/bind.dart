import 'package:get/get.dart';
import 'package:mapbox_navigation/mapbox_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapBoxController>(
      () => MapBoxController(),
    );
  }
}
