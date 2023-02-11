import 'package:get/get.dart';

import 'api_service.dart';

class ServiceStarter extends GetxService {
  Future<void> _boot() async {
    await Get.putAsync(() => APIService().init());
  }

  @override
  void onInit() {
    _boot();
    super.onInit();
  }
}