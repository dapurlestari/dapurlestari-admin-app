import 'package:admin/models/app/menu.dart';
import 'package:admin/models/server/access_status.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final accessStatuses = AccessStatus.statusList.obs;
  final serverChecking = false.obs;
  final serverStatus = false.obs;
  final apiChecking = false.obs;
  final apiStatus = false.obs;
  final siteChecking = false.obs;
  final siteStatus = false.obs;

  void checkServerStatus() {
    AccessStatus.checkServerStatus(
      onStart: () {
        serverChecking.value = true;
      },
      onComplete: (healthy) {
        serverStatus.value = healthy;
        serverChecking.value = false;
      }
    );
  }

  void checkAPIStatus() {
    AccessStatus.checkAPIStatus(
      onStart: () {
        apiChecking.value = true;
      },
      onComplete: (healthy) {
        apiStatus.value = healthy;
        apiChecking.value = false;
      }
    );
  }

  void checkSiteStatus() {
    AccessStatus.checkSiteStatus(
      onStart: () {
        siteChecking.value = true;
      },
      onComplete: (healthy) {
        siteStatus.value = healthy;
        siteChecking.value = false;
      }
    );
  }

  void _checkAllStatus() {
    checkServerStatus();
    checkAPIStatus();
    checkSiteStatus();
  }

  @override
  void onInit() {
    _checkAllStatus();
    super.onInit();
  }
}