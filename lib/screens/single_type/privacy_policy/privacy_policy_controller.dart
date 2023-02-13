import 'package:admin/models/privacy_policy/privacy_policy.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PrivacyPolicyController extends GetxController {
  final privacyPolicy = PrivacyPolicy.dummy().obs;
  final isRefresh = false.obs;
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

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }
}