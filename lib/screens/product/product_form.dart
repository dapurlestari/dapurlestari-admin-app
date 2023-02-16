import 'package:admin/components/bottom_sheets/bottom_sheets.dart';
import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/models/bundle/bundle.dart';
import 'package:admin/models/category/category.dart';
import 'package:admin/models/product/product.dart';
import 'package:admin/screens/bundle/bundle_controller.dart';
import 'package:admin/screens/category/category_controller.dart';
import 'package:admin/screens/components/date_time_info.dart';
import 'package:admin/screens/components/grid_view_form.dart';
import 'package:admin/screens/components/markdown_editor.dart';
import 'package:admin/screens/components/media_files_picker.dart';
import 'package:admin/screens/components/seo_form.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'product_form_controller.dart';

class ProductForm extends StatelessWidget {
  final Product product;
  ProductForm({Key? key,
    required this.product
  }) : super(key: key);

  final ProductFormController _controller = Get.put(ProductFormController());
  final String bundleTag = 'product.bundle';
  final String categoryTag = 'product.category';

  Future<void> _openBundleSheet() async {
    final bundleC = Get.put(BundleController(), tag: bundleTag);
    Bundle? bundle = await BottomSheets.open(
      child: _bundleList,
      isLoading: bundleC.isRefresh,
      header: 'Bundle'
    );
    logInfo(bundle?.toJson(), logLabel: 'selected_bundle');
    if (bundle != null) {
      _controller.product.value.bundle = bundle;
      _controller.bundleField.value.text = bundle.name;
    }
  }

  Future<void> _openCategorySheet() async {
    final categoryC =  Get.put(CategoryController(), tag: categoryTag);
    Category? category = await BottomSheets.open(
      child: _categoryList,
      isLoading: categoryC.isRefresh,
      header: 'Categories'
    );
    logInfo(category?.toJson(), logLabel: 'selected_category');
    if (category != null) {
      _controller.product.value.category = category;
      _controller.categoryField.value.text = category.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller.initForm(product);

    return Obx(() => CustomScaffold(
        title: product.isNotEmpty ? product.name : 'Product',
        actions: [
          IconButton(
            icon: _controller.saving.value
                ? Loadings.basicPrimary
                : const Icon(LineIcons.checkCircle,
                color: Colors.indigoAccent
            ),
            onPressed: _controller.save,
          )
        ],
        body: Container(
            padding: const EdgeInsets.only(right: 5),
            child: Scrollbar(
              radius: const Radius.circular(20),
              child: ListView(
                cacheExtent: Get.height * 2, // fix re-render list item
                padding: const EdgeInsets.fromLTRB(20, 22, 15, 150),
                children: [
                  CustomField.fieldGroup(
                      label: 'Relation',
                      content: Column(
                        children: [
                          CustomField.text(
                              controller: _controller.bundleField.value,
                              hint: 'Paket A',
                              readOnly: true,
                              label: 'Product Bundle',
                              suffixIcon: const Icon(FeatherIcons.chevronDown, size: 18),
                              onTap: _openBundleSheet
                          ),
                          CustomField.text(
                              controller: _controller.categoryField.value,
                              hint: 'Cookies',
                              readOnly: true,
                              label: 'Product Category',
                              suffixIcon: const Icon(FeatherIcons.chevronDown, size: 18),
                              onTap: _openCategorySheet
                          ),
                        ],
                      )
                  ),
                  const SizedBox(height: 40),
                  CustomField.fieldGroup(
                      label: 'General',
                      content: Column(
                        children: [
                          CustomField.text(
                            controller: _controller.slugField.value,
                            hint: '-',
                            readOnly: true,
                            label: 'Slug / URL Segment',
                            suffixIcon: Icon(
                                _controller.slugField.value.text.isEmpty || _controller.slugLoading.value
                                ? FeatherIcons.refreshCw : _controller.slugAvailable.value
                                  ? FeatherIcons.check
                                  : FeatherIcons.x,
                                color: _controller.slugField.value.text.isEmpty || _controller.slugLoading.value
                                    ? null : _controller.slugAvailable.value
                                    ? Colors.green
                                    : Colors.red,
                                size: 16
                            ),
                          ),
                          CustomField.text(
                            controller: _controller.nameField.value,
                            hint: 'Add category name or label',
                            label: 'Name',
                            onChanged: (value) async {
                              _controller.slugAvailable.value = false;
                              String slug = value.toLowerCase().trim().replaceAll(' ', '-');
                              _controller.slugField.value.text = slug;
                              _controller.slug.value = slug;
                            }
                          ),
                          GridViewForm(
                            padding: const EdgeInsets.only(bottom: 12),
                            children: [
                              CustomField.text(
                                controller: _controller.pirtField.value,
                                hint: '38429332983-33',
                                label: 'PIRT Number',
                                margin: EdgeInsets.zero,
                                keyboardType: TextInputType.number
                              ),
                              CustomField.chip(
                                  label: 'Active',
                                  enable: _controller.active.value,
                                  onTap: _controller.active.toggle
                              ),
                            ],
                          ),
                          CustomField.text(
                            controller: _controller.priceField.value,
                            hint: '20000',
                            label: 'Price',
                            keyboardType: TextInputType.number,
                            inputFormatter: [
                              SoftKeyboard.digitsOnly
                            ]
                          ),
                          CustomField.text(
                              controller: _controller.discountPriceField.value,
                              hint: '18000',
                              label: 'Discount Price',
                              keyboardType: TextInputType.number
                          ),
                          CustomField.text(
                              controller: _controller.releaseYearField.value,
                              hint: '2008',
                              label: 'Release Year',
                              keyboardType: TextInputType.number
                          ),
                          CustomField.text(
                              controller: _controller.stockField.value,
                              hint: '50',
                              label: 'Stock',
                              keyboardType: TextInputType.number
                          ),
                          CustomField.text(
                              controller: _controller.nettField.value,
                              hint: '250',
                              label: 'Nett',
                              keyboardType: TextInputType.number
                          ),
                          CustomField.text(
                              controller: _controller.unitField.value,
                              hint: 'g, kg',
                              label: 'Unit'
                          ),
                          CustomField.text(
                              controller: _controller.descriptionField.value,
                              hint: 'Add short product description',
                              label: 'Description',
                              minLines: 2,
                              maxLines: 3
                          ),
                          MarkdownEditor(
                            controller: _controller.descriptionRichField.value,
                            label: 'Description Rich',
                          ),
                        ],
                      )
                  ),
                  const SizedBox(height: 40),
                  CustomField.fieldGroup(
                      label: 'Images',
                      content: MediaFilesPicker(
                        mediaFiles: _controller.product.value.images,
                        tag: ConstLib.product,
                      )
                  ),
                  const SizedBox(height: 40),
                  SeoForm(
                    seo: _controller.product.value.seo,
                    tag: ConstLib.product,
                  ),
                  if (product.isNotEmpty) const SizedBox(height: 40),
                  if (product.isNotEmpty) CustomField.fieldGroup(
                    label: 'Info',
                    content: DateTimeInfo(
                        created: product.createdAt,
                        published: product.publishedAt,
                        edited: product.updatedAt
                    )
                  ),
                ],
              ),
            )
        )
    ));
  }

  Widget get _bundleList {
    final BundleController bundleC = Get.find(tag: bundleTag);

    return Obx(() => Scrollbar(
        radius: const Radius.circular(10),
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 120),
          shrinkWrap: true,
          itemCount: bundleC.bundles.length,
          itemBuilder: (_, i) {
            Bundle bundle = bundleC.bundles[i];
            return InkWell(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade50
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(bundle.name, style: Get.textTheme.titleMedium,),
                      Icon(FeatherIcons.circle, size: 16, color: Colors.grey.shade400,)
                    ],
                  )
              ),
              onTap: () {
                Get.back(result: bundle);
              },
            );
          },
          separatorBuilder: (_, i) => const SizedBox(height: 10),
        )
    ));
  }

  Widget get _categoryList {
    final CategoryController categoryC = Get.find(tag: categoryTag);

    return Obx(() => Scrollbar(
        radius: const Radius.circular(10),
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 120),
          shrinkWrap: true,
          itemCount: categoryC.categories.length,
          itemBuilder: (_, i) {
            Category category = categoryC.categories[i];
            return InkWell(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade50
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(category.name, style: Get.textTheme.titleMedium,),
                      Icon(FeatherIcons.circle, size: 16, color: Colors.grey.shade400,)
                    ],
                  )
              ),
              onTap: () {
                Get.back(result: category);
              },
            );
          },
          separatorBuilder: (_, i) => const SizedBox(height: 10),
        )
    ));
  }
}
