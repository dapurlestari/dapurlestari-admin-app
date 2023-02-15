import 'package:admin/models/app/menu.dart';
import 'package:admin/services/logger.dart';
import 'package:get/get.dart';

class IndexController extends GetxController {
  final menu = Menu.navBar.obs;
  final closeCounter = 0.obs;

  void clearActiveMenu() {
    for (var item in menu) {
      item.active = false;
    }
  }

  @override
  void onInit() {

    debounce(closeCounter, (_) {
      if (closeCounter.value == 1) {
        closeCounter.value = 0;
        logInfo(closeCounter.value, logLabel: 'close_counter');
      }
    }, time: const Duration(milliseconds: 3500));

    super.onInit();
  }
}