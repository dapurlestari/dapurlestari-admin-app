import 'package:admin/components/buttons/buttons.dart';
import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/screens/components/contentful_form.dart';
import 'package:admin/screens/components/seo_form.dart';
import 'package:admin/screens/single_type/privacy_policy/privacy_policy_controller.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({Key? key}) : super(key: key);

  final PrivacyPolicyController _controller = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
        title: 'Privacy Policy',
        showBackButton: true,
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(20, 22, 15, 150),
              children: [
                ContentfulForm(
                  contentful: _controller.privacyPolicy.value.contentful,
                  tag: ConstLib.privacyPolicyPage,
                  imageLabel: 'Featured Image',
                ),
                const SizedBox(height: 40),
                SeoForm(
                  seo: _controller.privacyPolicy.value.seo,
                  tag: ConstLib.privacyPolicyPage,
                )
              ],
            ),
            Buttons.floatingBottomButton(
                label: 'Save Privacy Policy',
                isLoading: _controller.saving.value,
                onPressed: _controller.save
            )
          ],
        )
    ));
  }
}
