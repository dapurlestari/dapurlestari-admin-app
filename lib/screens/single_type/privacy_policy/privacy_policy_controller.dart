import 'package:admin/models/components/contentful.dart';
import 'package:admin/models/privacy_policy/privacy_policy.dart';
import 'package:admin/screens/components/contentful_form.dart';
import 'package:admin/screens/components/media_file_picker.dart';
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
    final ContentfulController contentfulController = Get.find();
    final MediaFilePickerController mediaFilePickerController = Get.find();
    privacyPolicy.value.contentful = Contentful(
      title: contentfulController.titleField.value.text,
      subtitle: contentfulController.subtitleField.value.text,
      content: contentfulController.contentField.value.text,
      featuredImage: mediaFilePickerController.metaImage.value
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