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
                  hint: 'Summarize this config',
                  label: 'Title'
                ),
                const SizedBox(height: 20),
                CustomField.text(
                    hint: 'Insert some words',
                    label: 'Subtitle',
                    minLines: 3,
                    maxLines: 5
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                CustomField.text(
                  hint: '62123123123',
                  label: 'Phone',
                ),
                const SizedBox(height: 20),
                CustomField.text(
                  hint: '6289720000',
                  label: 'WhatsApp Link',
                ),
                const SizedBox(height: 20),
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
              children: [
                CustomField.text(
                  hint: '8 - 18',
                  label: 'Zoom',
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
