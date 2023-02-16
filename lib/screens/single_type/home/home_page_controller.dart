import 'package:admin/models/pages/home_page.dart';
import 'package:admin/models/seo/meta_social.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/screens/components/media_file_picker.dart';
import 'package:admin/screens/components/seo_form.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageController extends GetxController {
  final homePage = HomePage.dummy().obs;
  final isRefresh = false.obs;
  final saving = false.obs;
  final refresher = RefreshController().obs;
  final descriptionField = TextEditingController().obs;

  Future<void> _fetch() async {
    homePage.value = await HomePage.get();
    descriptionField.value.text = homePage.value.description;
    isRefresh.value = false;
    refresher.value.refreshCompleted();
  }

  void onRefresh() {
    isRefresh.value = true;
    _fetch();
  }

  Future<void> save() async {
    SoftKeyboard.hide();
    saving.value = true;
    final SeoController seoC = Get.find(tag: '${ConstLib.homePage}.seo');
    final MediaFilePickerController seoMediaC = Get.find(tag: '${ConstLib.homePage}.seo.media');

    homePage.value.seo = Seo(
      metaTitle: seoC.metaTitleField.value.text,
      metaDescription: seoC.metaDescriptionField.value.text,
      keywords: seoC.metaKeywordsField.value.text,
      canonicalUrl: seoC.canonicalURLField.value.text,
      metaImage: seoMediaC.metaImage.value,
      metaSocial: MetaSocial.defaultSocials(
        title: seoC.metaTitleField.value.text,
        description: seoC.metaSocialDescriptionField.value.text,
        mediaFile: seoMediaC.metaImage.value
      )
    );

    // logInfo(termsService.value.toJson(), logLabel: 'privacy_policy');
    homePage.value = await homePage.value.save();
    saving.value = false;
  }

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }
}