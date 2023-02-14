import 'package:admin/models/category/category.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryController extends GetxController {
  final categories = <Category>[].obs;
  final category = Category.dummy().obs;
  final isRefresh = false.obs;
  final refresher = RefreshController().obs;
  final page = 1.obs;
  final saving = false.obs;

  final titleField = TextEditingController().obs;
  final iconName = TextEditingController().obs;

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

  void initForm(Category category) {
    this.category.value = category;
    titleField.value.text = category.name;
    iconName.value.text = category.iconName;
  }

  Future<void> add() async {
    saving.value = true;
    Category category = Category.dummy();
    category.name = titleField.value.text;
    category.iconName = iconName.value.text;
    category = await category.add();
    categories.add(category);
    saving.value = false;
    Get.back(); // bac to list
  }

  Future<void> edit() async {
    saving.value = true;
    category.value.name = titleField.value.text;
    category.value.iconName = iconName.value.text;
    category.value = await category.value.save();
    categories.refresh();
    saving.value = false;
  }

  Future<void> save() async {
    bool valid = titleField.value.text.isNotEmpty && iconName.value.text.isNotEmpty;
    if (!valid) {
      Fluttertoast.showToast(msg: 'All fields are required!');
      return;
    }

    if (category.value.isNotEmpty) {
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