import 'package:admin/models/app/menu.dart';
import 'package:get/get.dart';

class IndexController extends GetxController {
  final menu = Menu.navBar.obs;

  void clearActiveMenu() {
    for (var item in menu) {
      item.active = false;
    }
  }
}