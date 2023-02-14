import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/models/product/product.dart';
import 'package:admin/screens/components/date_time_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

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
                          CustomField.text(
                              controller: _controller.titleField.value,
                              hint: 'Add category name or label',
                              label: 'Title'
                          ),
                          CustomField.text(
                              controller: _controller.descriptionField.value,
                              hint: 'Add product description',
                              label: 'Icon Name',
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
