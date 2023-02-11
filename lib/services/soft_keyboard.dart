import 'package:flutter/cupertino.dart';

class SoftKeyboard {
  static void hide() {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}