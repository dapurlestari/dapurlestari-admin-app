import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/models/product/product.dart';
import 'package:admin/screens/components/date_time_info.dart';
import 'package:admin/screens/components/grid_view_form.dart';
import 'package:admin/screens/components/markdown_editor.dart';
import 'package:admin/services/clipboard_manager.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/link_launcher.dart';
import 'package:admin/services/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

import 'product_controller.dart';

class ProductForm extends StatelessWidget {
  final Product product;
  ProductForm({Key? key,
    required this.product
  }) : super(key: key);

  final ProductController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.initForm(product);

    return Obx(() => CustomScaffold(
        title: product.isNotEmpty ? 'Product #${product.id}' : 'Product',
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
                padding: const EdgeInsets.fromLTRB(20, 22, 15, 150),
                children: [
                  CustomField.fieldGroup(
                      label: 'General',
                      content: Column(
                        children: [
                          if (product.isNotEmpty) CustomField.text(
                              controller: _controller.slugField.value,
                              hint: '-',
                              readOnly: true,
                              enabled: false,
                              label: 'Slug / URL Segment'
                          ),
                          CustomField.text(
                              controller: _controller.nameField.value,
                              hint: 'Add category name or label',
                              label: 'Name'
                          ),
                          GridViewForm(
                            padding: const EdgeInsets.only(bottom: 12),
                            children: [
                              CustomField.text(
                                  controller: _controller.pirtField.value,
                                  hint: '38429332983-33',
                                  label: 'PIRT Number',
                                  margin: EdgeInsets.zero
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
                          ),
                          CustomField.text(
                              controller: _controller.discountPriceField.value,
                              hint: '18000',
                              label: 'Discount Price'
                          ),
                          CustomField.text(
                              controller: _controller.releaseYearField.value,
                              hint: '2008',
                              label: 'Release Year'
                          ),
                          CustomField.text(
                              controller: _controller.stockField.value,
                              hint: '50',
                              label: 'Stock'
                          ),
                          CustomField.text(
                              controller: _controller.nettField.value,
                              hint: '250',
                              label: 'Nett'
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
}
