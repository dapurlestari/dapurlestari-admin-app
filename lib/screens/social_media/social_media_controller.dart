import 'package:admin/models/bundle/bundle.dart';
import 'package:admin/models/social/social_media.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SocialMediaController extends GetxController {
  final socialMedias = <SocialMedia>[].obs;
  final isRefresh = false.obs;
  final refresher = RefreshController().obs;
  final page = 1.obs;

  Future<void> _fetch() async {
    final newSocialMedias = await SocialMedia.get(page: page.value);
    if (newSocialMedias.isNotEmpty) page.value++;
    socialMedias.addAll(newSocialMedias);
    isRefresh.value = false;
    refresher.value.refreshCompleted();
    refresher.value.loadComplete();
  }

  void onRefresh() {
    page.value = 1;
    isRefresh.value = true;
    socialMedias.clear();
    _fetch();
  }

  void onLoadMore() {
    _fetch();
  }

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }
}