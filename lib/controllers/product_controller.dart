import 'package:admin/models/product/product.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final products = <Product>[].obs;

  Future<void> fetch() async {
    products.value = await Product.get();
  }

  @override
  void onInit() {
    fetch();
    super.onInit();
  }
}