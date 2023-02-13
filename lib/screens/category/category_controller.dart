import 'package:admin/models/category/category.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryController extends GetxController {
  final categories = <Category>[].obs;
  final isRefresh = false.obs;
  final refresher = RefreshController().obs;
  final page = 1.obs;

  Future<void> _fetch() async {
    final newCategories = await Category.get(page: page.value);
    if (newCategories.isNotEmpty) page.value++;
    categories.addAll(newCategories);
    isRefresh.value = false;
    refresher.value.refreshCompleted();
    refresher.value.loadComplete();
  }

  void onRefresh() {
    page.value = 1;
    isRefresh.value = true;
    categories.clear();
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