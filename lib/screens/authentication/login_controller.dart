import 'package:admin/models/user/authenticated_user.dart';
import 'package:admin/models/user/unauthenticated_user.dart';
import 'package:admin/screens/index_screen.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final loading = false.obs;
  final showPassword = false.obs;

  Future<void> login() async {
    SoftKeyboard.hide();
    loading.value = true;
    String username = usernameController.value.text;
    String password = passwordController.value.text;
    final unauthenticatedUser = UnauthenticatedUser(
      email: username,
      password: password
    );

    AuthenticatedUser authenticatedUser = await unauthenticatedUser.login();
    logInfo(authenticatedUser.jwt, logLabel: 'auth');
    if (authenticatedUser.jwt.isNotEmpty) {
      logInfo('Login Success', logLabel: 'auth');
      Get.off(() => const IndexScreen());
    }
    loading.value = false;
  }
}