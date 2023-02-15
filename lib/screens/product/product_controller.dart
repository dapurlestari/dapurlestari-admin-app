import 'package:admin/models/product/product.dart';
import 'package:admin/services/soft_keyboard.dart';
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

  final slugField = TextEditingController().obs;
  final nameField = TextEditingController().obs;
  final pirtField = TextEditingController().obs;
  final priceField = TextEditingController().obs;
  final discountPriceField = TextEditingController().obs;
  final releaseYearField = TextEditingController().obs;
  final stockField = TextEditingController().obs;
  final nettField = TextEditingController().obs;
  final unitField = TextEditingController().obs;
  final descriptionField = TextEditingController().obs;
  final descriptionRichField = TextEditingController().obs;

  final editMarkdown = false.obs;

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

  Future<void> initForm(Product product) async {
    this.product.value = product;

    saving.value = false;
    if (product.isNotEmpty) {
      saving.value = true;
      product.view().then((result) {
        this.product.value = result;
        saving.value = false;
      }).catchError((e) {
        saving.value = false;
      });
    }

    slugField.value.text = product.slug;
    nameField.value.text = product.name;
    pirtField.value.text = product.pirtCode;
    priceField.value.text = product.price.toString();
    discountPriceField.value.text = product.discountPrice.toString();
    releaseYearField.value.text = product.releaseYear.toString();
    stockField.value.text = product.stock.toString();
    nettField.value.text = product.nett.toString();
    unitField.value.text = product.unit;
    descriptionField.value.text = product.description;
    descriptionRichField.value.text = product.descriptionRich;
  }

  Future<void> add() async {
    saving.value = true;
    Product product = Product.dummy();
    product.name = nameField.value.text;
    product.pirtCode = pirtField.value.text;
    product.price = int.tryParse(priceField.value.text) ?? 0;
    product.discountPrice = int.tryParse(discountPriceField.value.text) ?? 0;
    product.releaseYear = int.tryParse(releaseYearField.value.text) ?? 0;
    product.stock = int.tryParse(stockField.value.text) ?? 0;
    product.nett = int.tryParse(nettField.value.text) ?? 0;
    product.unit = unitField.value.text;
    product.description = descriptionField.value.text;
    product.descriptionRich = descriptionRichField.value.text;
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
    updatedProduct.name = nameField.value.text;
    updatedProduct.pirtCode = pirtField.value.text;
    updatedProduct.price = int.tryParse(priceField.value.text) ?? 0;
    updatedProduct.discountPrice = int.tryParse(discountPriceField.value.text) ?? 0;
    updatedProduct.releaseYear = int.tryParse(releaseYearField.value.text) ?? 0;
    updatedProduct.stock = int.tryParse(stockField.value.text) ?? 0;
    updatedProduct.nett = int.tryParse(nettField.value.text) ?? 0;
    updatedProduct.unit = unitField.value.text;
    updatedProduct.description = descriptionField.value.text;
    updatedProduct.descriptionRich = descriptionRichField.value.text;
    updatedProduct = await product.value.save();
    if (updatedProduct.isNotEmpty) {
      product.value = updatedProduct;
      products.refresh();
    }
    saving.value = false;
  }

  Future<void> save() async {
    SoftKeyboard.hide();
    bool valid = nameField.value.text.isNotEmpty && descriptionField.value.text.isNotEmpty;
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