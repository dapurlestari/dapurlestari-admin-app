import 'package:admin/components/buttons/buttons.dart';
import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/screens/authentication/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackButton: false,
      useAppBar: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 180),
            const SizedBox(height: 70,),
            Text('Please login first to continue!',
              style: Get.textTheme.titleMedium,
            ),
            const SizedBox(height: 30,),
            CustomField.text(
              controller: loginController.usernameController.value,
              keyboardType: TextInputType.emailAddress,
              label: 'Username',
              hint: 'gwen@gmail.com'
            ),
            Obx(() => CustomField.text(
                controller: loginController.passwordController.value,
                obscureText: !loginController.showPassword.value,
                label: 'Password',
                hint: 'Your secret password',
                suffixIcon: InkWell(
                  onTap: loginController.showPassword.toggle,
                  child: Icon(loginController.showPassword.value ? FeatherIcons.eye : FeatherIcons.eyeOff),
                )
            )),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: Obx(() => Buttons.flat(
                  label: 'Login',
                  isLoading: loginController.loading.value,
                  onPressed: loginController.login
              )),
            ),
            const SizedBox(height: 150,),
          ],
        ),
      )
    );
  }
}
