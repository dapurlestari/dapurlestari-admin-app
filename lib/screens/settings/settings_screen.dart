import 'package:admin/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/forms/custom_text_field.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Settings',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 150),
        children: [
          CustomField.fieldGroup(
            label: 'General',
            content: Column(
              children: [
                CustomField.text(
                  hint: 'Title',
                ),
                const SizedBox(height: 20),
                CustomField.text(
                    hint: 'Subtitle',
                    minLines: 3,
                    maxLines: 5
                ),
                const SizedBox(height: 20),
                CustomField.text(
                  hint: 'Copyright',
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
                  hint: 'Email',
                ),
                const SizedBox(height: 20),
                CustomField.text(
                  hint: 'Phone',
                ),
                const SizedBox(height: 20),
                CustomField.text(
                  hint: 'WhatsApp Link',
                ),
                const SizedBox(height: 20),
                CustomField.text(
                    hint: 'Address',
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
              children: [
                CustomField.text(
                  hint: 'Zoom Level e.g. 8, 10, 13',
                ),
                const SizedBox(height: 20),
              ],
            )
          ),
        ],
      )
    );
  }
}
