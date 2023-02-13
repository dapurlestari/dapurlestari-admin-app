import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/screens/components/contentful_form.dart';
import 'package:admin/screens/components/seo_form.dart';
import 'package:admin/screens/single_type/privacy_policy/privacy_policy_controller.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({Key? key}) : super(key: key);

  final PrivacyPolicyController _controller = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
        title: 'Privacy Policy',
        showBackButton: true,
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
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 22, 15, 150),
          children: [
            ContentfulForm(
              contentful: _controller.privacyPolicy.value.contentful,
              tag: ConstLib.privacyPolicyPage,
            ),
            const SizedBox(height: 40),
            SeoForm(
              seo: _controller.privacyPolicy.value.seo,
              tag: ConstLib.privacyPolicyPage,
            )
          ],
        )
    ));
  }
}
