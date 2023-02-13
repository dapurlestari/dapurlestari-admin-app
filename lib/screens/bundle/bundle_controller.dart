import 'package:admin/models/bundle/bundle.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BundleController extends GetxController {
  final bundles = <Bundle>[].obs;
  final isRefresh = false.obs;
  final refresher = RefreshController().obs;
  final page = 1.obs;

  Future<void> _fetch() async {
    final newBundles = await Bundle.get(page: page.value);
    if (newBundles.isNotEmpty) page.value++;
    bundles.addAll(newBundles);
    isRefresh.value = false;
    refresher.value.refreshCompleted();
    refresher.value.loadComplete();
  }

  void onRefresh() {
    page.value = 1;
    isRefresh.value = true;
    bundles.clear();
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