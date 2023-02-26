import 'package:admin/models/faq/faq.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FaqController extends GetxController {
  final faqs = <Faq>[].obs;
  final isRefresh = false.obs;
  final refresher = RefreshController().obs;
  final page = 1.obs;

  Future<void> _fetch() async {
    final newFaqs = await Faq.get(page: page.value);
    if (newFaqs.isNotEmpty) page.value++;
    faqs.addAll(newFaqs);
    isRefresh.value = false;
    refresher.value.refreshCompleted();
    refresher.value.loadComplete();
  }

  void onRefresh() {
    page.value = 1;
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