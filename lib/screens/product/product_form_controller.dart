import 'package:admin/components/dialogs.dart';
import 'package:admin/models/product/product.dart';
import 'package:admin/models/seo/meta_social.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/screens/components/media_files_picker.dart';
import 'package:admin/screens/components/seo_form.dart';
import 'package:admin/screens/product/product_controller.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductFormController extends GetxController {
  final ProductController _controller = Get.find();
  final product = Product.dummy().obs;
  final saving = false.obs;
  final loading = false.obs;
  final loadingUnits = false.obs;
  final availableUnits = <String>[].obs;

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
  final slug = ''.obs;
  final slugAvailable = false.obs;
  final slugLoading = false.obs;

  Future<void> initForm(Product product) async {

    final MediaFilesPickerController controller = Get.put(
      MediaFilesPickerController(),
      tag: '${ConstLib.product}.medias',
    );

    this.product.value = Product.dummy();
    this.product.value = product;
    // logInfo(product.isNotEmpty, logLabel: 'product_not_empty');

    slugAvailable.value = false;
    slugField.value.clear();
    bundleField.value.clear();
    categoryField.value.clear();
    loading.value = false;
    loadingUnits.value = true;

    if (product.isNotEmpty) {
      loading.value = true;

      product.view().then((result) {
        this.product.value = result;
        logInfo(result.category.name, logLabel: 'category_name');
        bundleField.value.text = result.bundle.name;
        categoryField.value.text = result.category.name;

        controller.index.value = 0;
        controller.images.value = product.images;

        loading.value = false;
      }).catchError((e) {
        logError(e, logLabel: 'view_product');
        Fluttertoast.showToast(msg: 'View Product Error!');
        loading.value = false;
      });

      product.getUnits().then((values) {
        availableUnits.value = values;
        availableUnits.insert(0, '');
        loadingUnits.value = false;
      });
    }

    slugField.value.text = product.slug;
    nameField.value.text = product.name;
    pirtField.value.text = product.pirtCode;
    if (product.price > 0) priceField.value.text = product.price.toString();
    if (product.discountPrice > 0) discountPriceField.value.text = product.discountPrice.toString();
    if (product.releaseYear > 0) releaseYearField.value.text = product.releaseYear.toString();
    if (product.stock > 0) stockField.value.text = product.stock.toString();
    if (product.nett > 0) nettField.value.text = product.nett.toString();
    unitField.value.text = product.unit;
    descriptionField.value.text = product.description;
    descriptionRichField.value.text = product.descriptionRich;
    active.value = product.active;
  }

  Future<void> add() async {
    if (!slugAvailable.value) {
      Fluttertoast.showToast(msg: 'Oops. Slug Not Available!');
      return;
    }

    final MediaFilesPickerController seoMediaC = Get.find(tag: '${ConstLib.product}.medias');
    final SeoController seoC = Get.find(tag: '${ConstLib.product}.seo');
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
    product.images = seoMediaC.images;
    product.bundle = this.product.value.bundle;
    product.category = this.product.value.category;
    if (seoC.metaTitleField.value.text.isNotEmpty) product.seo = _updateSEO();
    logInfo(product.toJson(), logLabel: 'product_add');
    product = await product.add();
    if (product.isNotEmpty) {
      _controller.products.insert(0, product);
      Get.back(); // bac to list
    }
    saving.value = false;
  }

  Future<void> edit() async {
    final MediaFilesPickerController seoMediaC = Get.find(tag: '${ConstLib.product}.medias');

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
    product.value.images = seoMediaC.images;
    logInfo(product.value.toJson(), logLabel: 'product_edit');
    product.value = await product.value.edit();
    product.refresh();
    Get.back();

    int index = _controller.products.indexWhere((e) => e.id == product.value.id);
    if (index >= 0) _controller.products[index] = product.value;
    _controller.products.refresh();
    saving.value = false;
  }

  Seo _updateSEO() {
    final SeoController seoC = Get.find(tag: '${ConstLib.product}.seo');

    Seo seo = Seo(
        metaTitle: seoC.metaTitleField.value.text,
        metaDescription: seoC.metaDescriptionField.value.text,
        keywords: seoC.metaKeywordsField.value.text,
        canonicalUrl: seoC.canonicalURLField.value.text,
        metaImage: seoC.metaImage.value,
        metaSocial: []
    );

    if (seoC.metaSocialDescriptionField.value.text.isNotEmpty) {
      seo.metaSocial = MetaSocial.defaultSocials(
          title: seoC.metaTitleField.value.text,
          description: seoC.metaSocialDescriptionField.value.text,
          mediaFile: seoC.metaImage.value
      );
    }

    return seo;
  }

  Future<void> save() async {
    SoftKeyboard.hide();
    bool valid = nameField.value.text.isNotEmpty;
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

  Future<void> delete() async {
    SoftKeyboard.hide();
    Dialogs.general(
      title: 'Delete Product',
      contentText: 'Are you sure want to delete this product \n'
          '#${product.value.id} "${product.value.name}"',
      onConfirm: () async {
        _controller.products.removeWhere((e) => e.id == product.value.id);
        Get.back(); // close dialog
        Get.back(); // close form
        await product.value.delete();
        _controller.onRefresh();
      }
    );
  }

  void listenSlug() {
    debounce(slug, (String value) async {
      slugLoading.value = true;
      Product product = Product.dummy();
      product.slug = value;
      product = await product.getBySlug();
      logInfo(product.isEmpty, logLabel: 'slug');
      slugAvailable.value = product.isEmpty;
      if (this.product.value.isNotEmpty) { // when editing product
        slugAvailable.value = slugAvailable.value || this.product.value.id == product.id;
      }
      if (slugAvailable.value) {
        this.product.value.slug = value;
        this.product.refresh();
      }
      slugLoading.value = false;
    }, time: const Duration(milliseconds: 800));
  }

  @override
  void onInit() {
    listenSlug();
    super.onInit();
  }

}