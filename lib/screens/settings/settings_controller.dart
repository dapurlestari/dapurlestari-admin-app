import 'package:admin/models/app/menu.dart';
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
}