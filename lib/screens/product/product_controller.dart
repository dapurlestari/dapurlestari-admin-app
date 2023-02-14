import 'package:admin/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductController extends GetxController {
  final products = <Product>[].obs;
  final product = Product.dummy().obs;
  final isRefresh = false.obs;
  final refresher = RefreshController().obs;
  final saving = false.obs;
  final page = 1.obs;

  final titleField = TextEditingController().obs;
  final descriptionField = TextEditingController().obs;

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

  void initForm(Product product) {
    saving.value = false;
    this.product.value = product;
    titleField.value.text = product.name;
    descriptionField.value.text = product.description;
  }

  Future<void> add() async {
    saving.value = true;
    Product product = Product.dummy();
    product.name = titleField.value.text;
    product.description = descriptionField.value.text;
    product = await product.add();
    if (product.isNotEmpty) {
      products.add(product);
      Get.back(); // bac to list
    }
    saving.value = false;
  }

  Future<void> edit() async {
    saving.value = true;
    Product updatedProduct = product.value;
    updatedProduct.name = titleField.value.text;
    updatedProduct.description = descriptionField.value.text;
    updatedProduct = await product.value.save();
    if (updatedProduct.isNotEmpty) {
      product.value = updatedProduct;
      products.refresh();
    }
    saving.value = false;
  }

  Future<void> save() async {
    bool valid = titleField.value.text.isNotEmpty && descriptionField.value.text.isNotEmpty;
    if (!valid) {
      Fluttertoast.showToast(msg: 'All fields are required!');
      return;
    }

    if (product.value.isNotEmpty) {
      edit();
    } else {
      add();
    }
  }

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }
}