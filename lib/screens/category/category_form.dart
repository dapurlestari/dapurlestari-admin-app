import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/models/category/category.dart';
import 'package:admin/screens/category/category_controller.dart';
import 'package:admin/screens/components/date_time_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class CategoryForm extends StatelessWidget {
  final Category category;
  CategoryForm({Key? key,
    required this.category
  }) : super(key: key);

  final CategoryController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.initForm(category);

    return Obx(() => CustomScaffold(
        title: category.isNotEmpty ? 'Category #${category.id}' : 'Category',
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
                              controller: _controller.iconName.value,
                              hint: 'Add site icon name for category',
                              label: 'Icon Name',
                          ),
                        ],
                      )
                  ),
                  if (category.isNotEmpty) const SizedBox(height: 40),
                  if (category.isNotEmpty) CustomField.fieldGroup(
                    label: 'Info',
                    content: DateTimeInfo(
                        created: category.createdAt,
                        published: category.publishedAt,
                        edited: category.updatedAt
                    )
                  ),
                  if (category.isNotEmpty) const SizedBox(height: 50),
                  if (category.isNotEmpty) CustomField.fieldGroup(
                      label: 'Products',
                      content: TextButton(
                        child: Row(
                          children: const [
                            Text('View Related Products'),
                            SizedBox(width: 4),
                            Icon(FeatherIcons.arrowRight, size: 14,)
                          ],
                        ),
                        onPressed: () {},
                      )
                  ),
                ],
              ),
            )
        )
    ));
  }
}
