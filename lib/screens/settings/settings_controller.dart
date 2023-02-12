import 'package:admin/models/app/config.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final draggable = false.obs;
  final scaleControl = false.obs;
  final rotateControl = false.obs;
  final zoomControl = false.obs;
  final mapTypeControl = false.obs;
  final streetViewControl = false.obs;
  final fullScreenControl = false.obs;

  final markerClickable = false.obs;
  final markerDraggable = false.obs;

  final copyrightField = TextEditingController().obs;

  final config = Config.dummy().obs;

  Future<void> fetch() async {
    final config = await Config.get();
    if (config != null) {
      logInfo(config.copyright, logLabel: 'copyright');

      this.config.value = config;
      copyrightField.value.text = config.copyright;
    }
  }

  void save() {
    SoftKeyboard.hide();
  }

  @override
  void onInit() {
    fetch();
    super.onInit();
  }
}