import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/screens/single_type/privacy_policy/privacy_policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({Key? key}) : super(key: key);

  final PrivacyPolicyController _controller = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Privacy Policy',
      showBackButton: true,
      body: Container()
    );
  }
}
