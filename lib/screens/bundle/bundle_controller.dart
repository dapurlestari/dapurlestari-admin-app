import 'package:admin/models/bundle/bundle.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BundleController extends GetxController {
  final bundles = <Bundle>[].obs;
  final bundle = Bundle.dummy().obs;
  final isRefresh = false.obs;
  final saving = false.obs;
  final refresher = RefreshController().obs;
  final page = 1.obs;

  final titleField = TextEditingController().obs;
  final descriptionField = TextEditingController().obs;

  Future<void> _fetch() async {
    final newBundles = await Bundle.get(page: page.value);
    if (newBundles.isNotEmpty) page.value++;
    bundles.addAll(newBundles);
    bundles.insert(0, Bundle.dummy());
    isRefresh.value = false;
    refresher.value.refreshCompleted();
    refresher.value.loadComplete();
  }

  void onRefresh() {
    page.value = 1;
    isRefresh.value = true;
    bundles.clear();
    _fetch();
  }

  void onLoadMore() {
    _fetch();
  }

  void initForm(Bundle bundle) {
    this.bundle.value = bundle;
    titleField.value.text = bundle.name;
    descriptionField.value.text = bundle.description;
  }

  Future<void> add() async {
    saving.value = true;
    Bundle bundle = Bundle.dummy();
    bundle.name = titleField.value.text;
    bundle.description = descriptionField.value.text;
    bundle = await bundle.add();
    bundles.add(bundle);
    saving.value = false;
    Get.back(); // bac to list
  }

  Future<void> edit() async {
    saving.value = true;
    bundle.value.name = titleField.value.text;
    bundle.value.description = descriptionField.value.text;
    bundle.value = await bundle.value.save();
    bundles.refresh();
    saving.value = false;
  }

  Future<void> save() async {
    bool valid = titleField.value.text.isNotEmpty && descriptionField.value.text.isNotEmpty;
    if (!valid) {
      Fluttertoast.showToast(msg: 'All fields are required!');
      return;
    }

    if (bundle.value.isNotEmpty) {
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