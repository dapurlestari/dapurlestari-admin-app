import 'package:admin/models/app/config.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/models/map/map_marker.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../models/seo/seo.dart';

class SettingsController extends GetxController {

  final config = Config.dummy().obs;
  final saving = false.obs;

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
  final metaImage = MediaFile.dummy().obs;

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
      metaImage.value = config.seo.metaImage ?? MediaFile.dummy();
    }
  }

  Future<void> save() async {
    if (saving.value) {
      Fluttertoast.showToast(msg: 'Saving in progress!');
      return;
    }

    SoftKeyboard.hide();

    saving.value = true;
    Config? newConfig = Config.dummy();
    newConfig.title = titleField.value.text;
    newConfig.subtitle = subtitleField.value.text;
    newConfig.copyright = copyrightField.value.text;

    newConfig.email = emailField.value.text;
    newConfig.phone = phoneField.value.text;
    newConfig.whatsappLink = whatsappLinkField.value.text;
    newConfig.openingHours = openingHoursField.value.text;
    newConfig.address = addressField.value.text;

    newConfig.map.zoom = int.tryParse(zoomField.value.text) ?? 0;
    newConfig.map.placeholderImageUrl = placeholderField.value.text;
    newConfig.map.draggable = draggable.value;
    newConfig.map.scaleControl = scaleControl.value;
    newConfig.map.rotateControl = rotateControl.value;
    newConfig.map.zoomControl = zoomControl.value;
    newConfig.map.mapTypeControl = mapTypeControl.value;
    newConfig.map.streetViewControl = streetViewControl.value;
    newConfig.map.fullScreenControl = fullScreenControl.value;

    MapMarker marker = MapMarker();
    marker.label = markerLabelField.value.text;
    marker.description = markerDescriptionField.value.text;
    marker.latitude = double.tryParse(markerLatitudeField.value.text) ?? 0;
    marker.longitude = double.tryParse(markerLongitudeField.value.text) ?? 0;
    marker.clickable = markerClickable.value;
    marker.draggable = markerDraggable.value;
    newConfig.map.markers[0] = marker;

    Seo newSeo = Seo.dummy();
    newSeo.metaTitle = metaTitleField.value.text;
    newSeo.metaDescription = metaDescriptionField.value.text;
    newSeo.canonicalUrl = canonicalURLField.value.text;
    newSeo.keywords = metaKeywordsField.value.text;
    newSeo.metaImage = metaImage.value;
    newConfig.seo = newSeo;
    logInfo(newConfig.toJson(), logLabel: 'new_config');

    newConfig = await newConfig.save();
    if (newConfig != null) {
      config.value = newConfig;
      Fluttertoast.showToast(msg: 'Config Updated!');
    } else {
      Fluttertoast.showToast(msg: 'Config Update Failed!');
    }

    saving.value = false;
  }

  @override
  void onInit() {
    fetch();
    super.onInit();
  }
}