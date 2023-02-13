import 'package:admin/models/bundle/bundle.dart';
import 'package:admin/models/social/social_media.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SocialMediaController extends GetxController {
  final socialMedias = <SocialMedia>[].obs;
  final isRefresh = false.obs;
  final refresher = RefreshController().obs;

  Future<void> _fetch() async {
    final newSocialMedias = await SocialMedia.get();
    socialMedias.addAll(newSocialMedias);
    isRefresh.value = false;
    refresher.value.refreshCompleted();
    refresher.value.loadComplete();
  }

  void onRefresh() {
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