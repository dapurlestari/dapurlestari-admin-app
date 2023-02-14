import 'package:admin/components/buttons/custom_button.dart';
import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/models/bundle/bundle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'bundle_controller.dart';

class BundleForm extends StatelessWidget {
  final Bundle bundle;
  BundleForm({Key? key,
    required this.bundle
  }) : super(key: key);

  final BundleController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.initForm(bundle);

    return Obx(() => CustomScaffold(
        title: 'Bundle #${bundle.id}',
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
                              hint: 'Add product bundle title',
                              label: 'Title'
                          ),
                          CustomField.text(
                              controller: _controller.descriptionField.value,
                              hint: 'Describe about this bundle',
                              label: 'Description',
                              minLines: 3,
                              maxLines: 5
                          ),
                        ],
                      )
                  ),
                  const SizedBox(height: 40),
                  CustomField.fieldGroup(
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
