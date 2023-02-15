import 'package:admin/models/product/product.dart';
import 'package:admin/models/seo/meta_social.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/screens/components/media_file_picker.dart';
import 'package:admin/screens/components/seo_form.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/logger.dart';
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

  final bundleField = TextEditingController().obs;
  final categoryField = TextEditingController().obs;
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
  final active = false.obs;

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
    // logInfo(product.isNotEmpty, logLabel: 'product_not_empty');

    saving.value = false;
    if (product.isNotEmpty) {
      saving.value = true;
      bundleField.value.clear();
      categoryField.value.clear();
      product.view().then((result) {
        this.product.value = result;
        logInfo(result.category.name, logLabel: 'category_name');
        bundleField.value.text = result.bundle.name;
        categoryField.value.text = result.category.name;
        saving.value = false;
      }).catchError((e) {
        logError(e, logLabel: 'view_product');
        Fluttertoast.showToast(msg: 'View Product Error!');
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
    active.value = product.active;
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
    product.active = active.value;
    product.bundle = this.product.value.bundle;
    product.category = this.product.value.category;
    product.seo = _updateSEO();
    product = await product.add();
    if (product.isNotEmpty) {
      products.add(product);
      Get.back(); // bac to list
    }
    saving.value = false;
  }

  Future<void> edit() async {
    saving.value = true;
    product.value.name = nameField.value.text;
    product.value.pirtCode = pirtField.value.text;
    product.value.price = int.tryParse(priceField.value.text) ?? 0;
    product.value.discountPrice = int.tryParse(discountPriceField.value.text) ?? 0;
    product.value.releaseYear = int.tryParse(releaseYearField.value.text) ?? 0;
    product.value.stock = int.tryParse(stockField.value.text) ?? 0;
    product.value.nett = int.tryParse(nettField.value.text) ?? 0;
    product.value.unit = unitField.value.text;
    product.value.description = descriptionField.value.text;
    product.value.descriptionRich = descriptionRichField.value.text;
    product.value.active = active.value;
    product.value.seo = _updateSEO();
    logInfo(product.value.toJson(), logLabel: 'product_edit');
    product.value = await product.value.edit();
    product.refresh();
    saving.value = false;
  }

  Seo _updateSEO() {
    final SeoController seoC = Get.find(tag: '${ConstLib.product}.seo');
    final MediaFilePickerController seoMediaC = Get.find(tag: '${ConstLib.product}.seo.media');

    Seo seo = Seo(
        metaTitle: seoC.metaTitleField.value.text,
        metaDescription: seoC.metaDescriptionField.value.text,
        keywords: seoC.metaKeywordsField.value.text,
        canonicalUrl: seoC.canonicalURLField.value.text,
        metaImage: seoMediaC.metaImage.value,
        metaSocial: []
    );

    if (seoC.metaSocialDescriptionField.value.text.isNotEmpty) {
      seo.metaSocial = MetaSocial.defaultSocials(
          title: seoC.metaTitleField.value.text,
          description: seoC.metaSocialDescriptionField.value.text,
          mediaFile: seoMediaC.metaImage.value
      );
    }

    return seo;
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