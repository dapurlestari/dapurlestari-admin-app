import 'package:admin/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../components/forms/custom_text_field.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
        title: 'Settings',
        actions: [
          IconButton(
            icon: const Icon(LineIcons.checkCircle, color: Colors.indigoAccent),
            onPressed: () {},
          )
        ],
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 150),
          children: [
            CustomField.fieldGroup(
                label: 'General',
                content: Column(
                  children: [
                    CustomField.text(
                        hint: 'Summarize this config',
                        label: 'Title'
                    ),
                    CustomField.text(
                        hint: 'Insert some words',
                        label: 'Subtitle',
                        minLines: 3,
                        maxLines: 5
                    ),
                    CustomField.text(
                      hint: '© 2018-2023',
                      label: 'Copyright',
                    ),
                  ],
                )
            ),
            const SizedBox(height: 40),
            CustomField.fieldGroup(
                label: 'Address & Contact',
                content: Column(
                  children: [
                    CustomField.text(
                      hint: 'my@mail.com',
                      label: 'Email',
                    ),
                    CustomField.text(
                      hint: '62123123123',
                      label: 'Phone',
                    ),
                    CustomField.text(
                      hint: '6289720000',
                      label: 'WhatsApp Link',
                    ),
                    CustomField.text(
                        hint: 'Address',
                        label: 'Address',
                        minLines: 3,
                        maxLines: 5
                    ),
                  ],
                )
            ),
            const SizedBox(height: 40),
            CustomField.fieldGroup(
                label: 'Google Map',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomField.text(
                      hint: '8 - 18',
                      label: 'Zoom',
                    ),
                    GridView(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 9/2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12
                      ),
                      children: [
                        CustomField.chip(
                            label: 'Draggable',
                            enable: settingsController.draggable.value,
                            onTap: settingsController.draggable.toggle
                        ),
                        CustomField.chip(
                            label: 'Scale Control',
                            enable: settingsController.scaleControl.value,
                            onTap: settingsController.scaleControl.toggle
                        ),
                        CustomField.chip(
                            label: 'Rotate Control',
                            enable: settingsController.rotateControl.value,
                            onTap: settingsController.rotateControl.toggle
                        ),
                        CustomField.chip(
                            label: 'Street View Control',
                            enable: settingsController.streetViewControl.value,
                            onTap: settingsController.streetViewControl.toggle
                        ),
                        CustomField.chip(
                            label: 'Full Screen Control',
                            enable: settingsController.fullScreenControl.value,
                            onTap: settingsController.fullScreenControl.toggle
                        ),
                      ],
                    )
                  ],
                )
            ),
          ],
        )
    ));
  }
}
