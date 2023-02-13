import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/screens/components/contentful_form.dart';
import 'package:admin/screens/components/seo_form.dart';
import 'package:admin/screens/single_type/privacy_policy/privacy_policy_controller.dart';
import 'package:admin/screens/single_type/terms_services/terms_services_controller.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class TermsServicesScreen extends StatelessWidget {
  TermsServicesScreen({Key? key}) : super(key: key);

  final TermsServicesController _controller = Get.put(TermsServicesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
        title: 'Terms of Services',
        showBackButton: true,
        actions: [
          IconButton(
            icon: _controller.saving.value || _controller.isRefresh.value
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
              contentful: _controller.termsService.value.contentful,
              tag: ConstLib.termsServicePage,
            ),
            const SizedBox(height: 40),
            SeoForm(
              seo: _controller.termsService.value.seo,
              tag: ConstLib.termsServicePage,
            )
          ],
        )
    ));
  }
}
