import 'package:admin/models/components/contentful.dart';
import 'package:admin/models/seo/meta_social.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/models/terms_service/terms_service.dart';
import 'package:admin/models/terms_service/terms_service.dart';
import 'package:admin/screens/components/contentful_form.dart';
import 'package:admin/screens/components/media_file_picker.dart';
import 'package:admin/screens/components/seo_form.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TermsServicesController extends GetxController {
  final termsService = TermsService.dummy().obs;
  final isRefresh = false.obs;
  final saving = false.obs;
  final refresher = RefreshController().obs;

  Future<void> _fetch() async {
    termsService.value = await TermsService.get();
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
    final ContentfulController contentfulC = Get.find(tag: '${ConstLib.termsServicePage}.contentful');
    final MediaFilePickerController featuredImageC = Get.find(tag: '${ConstLib.termsServicePage}.contentful.media');
    final SeoController seoC = Get.find(tag: '${ConstLib.termsServicePage}.seo');
    final MediaFilePickerController seoMediaC = Get.find(tag: '${ConstLib.termsServicePage}.seo.media');

    termsService.value.contentful = Contentful(
      title: contentfulC.titleField.value.text,
      subtitle: contentfulC.subtitleField.value.text,
      content: contentfulC.contentField.value.text,
      featuredImage: featuredImageC.metaImage.value
    );

    termsService.value.seo = Seo(
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
    termsService.value = await termsService.value.save();
    saving.value = false;
  }

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }
}