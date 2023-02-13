import 'package:admin/models/components/contentful.dart';
import 'package:admin/models/privacy_policy/privacy_policy.dart';
import 'package:admin/models/seo/meta_social.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/screens/components/contentful_form.dart';
import 'package:admin/screens/components/media_file_picker.dart';
import 'package:admin/screens/components/seo_form.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PrivacyPolicyController extends GetxController {
  final privacyPolicy = PrivacyPolicy.dummy().obs;
  final isRefresh = false.obs;
  final saving = false.obs;
  final refresher = RefreshController().obs;

  Future<void> _fetch() async {
    privacyPolicy.value = await PrivacyPolicy.get();
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
    final ContentfulController contentfulC = Get.find(tag: '${ConstLib.privacyPolicyPage}.contentful');
    final MediaFilePickerController featuredImageC = Get.find(tag: '${ConstLib.privacyPolicyPage}.contentful.media');
    final SeoController seoC = Get.find(tag: '${ConstLib.privacyPolicyPage}.seo');
    final MediaFilePickerController seoMediaC = Get.find(tag: '${ConstLib.privacyPolicyPage}.seo.media');

    privacyPolicy.value.contentful = Contentful(
      title: contentfulC.titleField.value.text,
      subtitle: contentfulC.subtitleField.value.text,
      content: contentfulC.contentField.value.text,
      featuredImage: featuredImageC.metaImage.value
    );

    privacyPolicy.value.seo = Seo(
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

    // logInfo(privacyPolicy.value.toJson(), logLabel: 'privacy_policy');
    privacyPolicy.value = await privacyPolicy.value.save();
    saving.value = false;
  }

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }
}