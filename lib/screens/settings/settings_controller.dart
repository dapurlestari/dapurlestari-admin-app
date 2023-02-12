import 'package:admin/models/app/config.dart';
import 'package:admin/models/map/map_marker.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {

  /* General */
  final titleField = TextEditingController().obs;
  final subtitleField = TextEditingController().obs;
  final copyrightField = TextEditingController().obs;

  /* Address & Contact */
  final emailField = TextEditingController().obs;
  final phoneField = TextEditingController().obs;
  final whatsappLinkField = TextEditingController().obs;
  final openingHoursField = TextEditingController().obs;
  final addressField = TextEditingController().obs;

  /* Google Map */
  final zoomField = TextEditingController().obs;
  final placeholderField = TextEditingController().obs;
  final draggable = false.obs;
  final scaleControl = false.obs;
  final rotateControl = false.obs;
  final zoomControl = false.obs;
  final mapTypeControl = false.obs;
  final streetViewControl = false.obs;
  final fullScreenControl = false.obs;

  /* Google Map Marker */
  final markerLabelField = TextEditingController().obs;
  final markerDescriptionField = TextEditingController().obs;
  final markerLatitudeField = TextEditingController().obs;
  final markerLongitudeField = TextEditingController().obs;
  final markerClickable = false.obs;
  final markerDraggable = false.obs;

  /* SEO */
  final metaTitleField = TextEditingController().obs;
  final metaDescriptionField = TextEditingController().obs;
  final canonicalURLField = TextEditingController().obs;
  final metaKeywordsField = TextEditingController().obs;

  final config = Config.dummy().obs;

  Future<void> fetch() async {
    final config = await Config.get();
    if (config != null) {
      logInfo(config.copyright, logLabel: 'copyright');

      this.config.value = config;
      titleField.value.text = config.title;
      subtitleField.value.text = config.subtitle;
      copyrightField.value.text = config.copyright;

      emailField.value.text = config.email;
      phoneField.value.text = config.phone;
      whatsappLinkField.value.text = config.whatsappLink;
      openingHoursField.value.text = config.openingHours;
      addressField.value.text = config.address;

      zoomField.value.text = '${config.map.zoom}';
      placeholderField.value.text = config.map.placeholderImageUrl;
      draggable.value = config.map.draggable;
      scaleControl.value = config.map.scaleControl;
      rotateControl.value = config.map.rotateControl;
      zoomControl.value = config.map.zoomControl;
      mapTypeControl.value = config.map.mapTypeControl;
      streetViewControl.value = config.map.streetViewControl;
      fullScreenControl.value = config.map.fullScreenControl;

      if (config.map.markers.isNotEmpty) {
        MapMarker marker = config.map.markers[0];
        markerLabelField.value.text = marker.label;
        markerDescriptionField.value.text = marker.description;
        markerLatitudeField.value.text = '${marker.latitude}';
        markerLongitudeField.value.text = '${marker.longitude}';
        markerClickable.value = marker.clickable;
        markerDraggable.value = marker.draggable;
      }

      metaTitleField.value.text = config.seo.metaTitle;
      metaDescriptionField.value.text = config.seo.metaDescription;
      canonicalURLField.value.text = config.seo.canonicalUrl;
      metaKeywordsField.value.text = config.seo.keywords;
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