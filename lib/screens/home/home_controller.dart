import 'package:admin/models/app/menu.dart';
import 'package:admin/models/server/access_status.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final accessStatuses = AccessStatus.statusList.obs;

  void resetStatus() {
    for (var item in accessStatuses) {
      item.healthy = false;
    }
  }
}