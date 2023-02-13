import 'package:admin/models/faq/faq.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FaqController extends GetxController {
  final faqs = <Faq>[].obs;
  final isRefresh = false.obs;
  final refresher = RefreshController().obs;

  Future<void> _fetch() async {
    final newFaqs = await Faq.get();
    faqs.addAll(newFaqs);
    isRefresh.value = false;
    refresher.value.refreshCompleted();
    refresher.value.loadComplete();
  }

  void onRefresh() {
    isRefresh.value = true;
    faqs.clear();
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