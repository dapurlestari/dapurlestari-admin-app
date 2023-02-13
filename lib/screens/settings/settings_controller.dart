import 'package:admin/models/app/config.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/models/map/map_marker.dart';
import 'package:admin/models/seo/meta_social.dart';
import 'package:admin/screens/components/media_file_picker.dart';
import 'package:admin/screens/components/seo_form.dart';
import 'package:admin/services/constant_lib.dart';
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

  Future<void> fetch() async {
    final newConfig = await Config.get();
    if (newConfig != null) {
      logInfo(newConfig.copyright, logLabel: 'copyright');

      config.value = newConfig;
      titleField.value.text = newConfig.title;
      subtitleField.value.text = newConfig.subtitle;
      copyrightField.value.text = newConfig.copyright;

      emailField.value.text = newConfig.email;
      phoneField.value.text = newConfig.phone;
      whatsappLinkField.value.text = newConfig.whatsappLink;
      openingHoursField.value.text = newConfig.openingHours;
      addressField.value.text = newConfig.address;

      zoomField.value.text = '${newConfig.map.zoom}';
      placeholderField.value.text = newConfig.map.placeholderImageUrl;
      draggable.value = newConfig.map.draggable;
      scaleControl.value = newConfig.map.scaleControl;
      rotateControl.value = newConfig.map.rotateControl;
      zoomControl.value = newConfig.map.zoomControl;
      mapTypeControl.value = newConfig.map.mapTypeControl;
      streetViewControl.value = newConfig.map.streetViewControl;
      fullScreenControl.value = newConfig.map.fullScreenControl;

      if (newConfig.map.markers.isNotEmpty) {
        MapMarker marker = newConfig.map.markers[0];
        markerLabelField.value.text = marker.label;
        markerDescriptionField.value.text = marker.description;
        markerLatitudeField.value.text = '${marker.latitude}';
        markerLongitudeField.value.text = '${marker.longitude}';
        markerClickable.value = marker.clickable;
        markerDraggable.value = marker.draggable;
      }
    }
  }

  Future<void> save() async {
    if (saving.value) {
      Fluttertoast.showToast(msg: 'Saving in progress!');
      return;
    }

    SoftKeyboard.hide();

    final SeoController seoController = Get.find();
    final MediaFilePickerController mediaFilePickerController = Get.find();
    saving.value = true;
    config.value.title = titleField.value.text;
    config.value.subtitle = subtitleField.value.text;
    config.value.copyright = copyrightField.value.text;

    config.value.email = emailField.value.text;
    config.value.phone = phoneField.value.text;
    config.value.whatsappLink = whatsappLinkField.value.text;
    config.value.openingHours = openingHoursField.value.text;
    config.value.address = addressField.value.text;

    config.value.map.zoom = int.tryParse(zoomField.value.text) ?? 0;
    config.value.map.placeholderImageUrl = placeholderField.value.text;
    config.value.map.draggable = draggable.value;
    config.value.map.scaleControl = scaleControl.value;
    config.value.map.rotateControl = rotateControl.value;
    config.value.map.zoomControl = zoomControl.value;
    config.value.map.mapTypeControl = mapTypeControl.value;
    config.value.map.streetViewControl = streetViewControl.value;
    config.value.map.fullScreenControl = fullScreenControl.value;

    MapMarker marker = MapMarker();
    marker.label = markerLabelField.value.text;
    marker.description = markerDescriptionField.value.text;
    marker.latitude = double.tryParse(markerLatitudeField.value.text) ?? 0;
    marker.longitude = double.tryParse(markerLongitudeField.value.text) ?? 0;
    marker.clickable = markerClickable.value;
    marker.draggable = markerDraggable.value;
    config.value.map.markers[0] = marker;

    Seo newSeo = Seo.dummy();
    String metaSocialDescription = seoController.metaSocialDescriptionField.value.text;
    newSeo.metaTitle = seoController.metaTitleField.value.text;
    newSeo.metaDescription = seoController.metaDescriptionField.value.text;
    newSeo.canonicalUrl = seoController.canonicalURLField.value.text;
    newSeo.keywords = seoController.metaKeywordsField.value.text;
    newSeo.metaImage = mediaFilePickerController.metaImage.value;
    newSeo.metaSocial.addAll([
      MetaSocial(
          title: newSeo.metaTitle,
          description: metaSocialDescription,
          socialNetwork: ConstLib.metaFacebook,
          image: newSeo.metaImage
      ),
      MetaSocial(
          title: newSeo.metaTitle,
          description: metaSocialDescription,
          socialNetwork: ConstLib.metaTwitter,
          image: newSeo.metaImage
      )
    ]);
    newSeo.metaImage = mediaFilePickerController.metaImage.value;
    config.value.seo = newSeo;

    logInfo(config.value.toJson(), logLabel: 'new_config');

    config.value = await config.value.save();
    Fluttertoast.showToast(msg: 'Config Updated!');

    saving.value = false;
  }

  @override
  void onInit() {
    fetch();
    super.onInit();
  }
}