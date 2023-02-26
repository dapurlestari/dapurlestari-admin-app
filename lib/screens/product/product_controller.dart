import 'package:admin/models/product/product.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductController extends GetxController {
  final products = <Product>[].obs;
  final isRefresh = false.obs;
  final refresher = RefreshController().obs;
  final page = 1.obs;

  Future<void> _fetch() async {
    final newProducts = await Product.get(page: page.value);
    if (newProducts.isNotEmpty) page.value++;
    products.addAll(newProducts);
    isRefresh.value = false;
    refresher.value.refreshCompleted();
    refresher.value.loadComplete();
  }

  void onRefresh() {
    page.value = 1;
    isRefresh.value = true;
    products.clear();
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