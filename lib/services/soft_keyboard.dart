import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class SoftKeyboard {
  static void hide() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  static FilteringTextInputFormatter noWhitespaceFormat = FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"));
  static FilteringTextInputFormatter urlSymbols = FilteringTextInputFormatter.allow(RegExp(r"[a-z0-9_\-]+"));
  static FilteringTextInputFormatter emailSymbols = FilteringTextInputFormatter.allow(RegExp(r"[a-z0-9@_.]+"));
  static FilteringTextInputFormatter letterOnly = FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"));
  static FilteringTextInputFormatter whitespaceFormat = FilteringTextInputFormatter.allow(RegExp(r"\s\b|\b\s"));
  static LengthLimitingTextInputFormatter limit(int maxLength) => LengthLimitingTextInputFormatter(maxLength);

  static List<FilteringTextInputFormatter> letters = [
    letterOnly,
  ];

  static List<FilteringTextInputFormatter> emailFormat = [
    noWhitespaceFormat,
    emailSymbols
  ];

  static List<FilteringTextInputFormatter> urlFormat = [
    noWhitespaceFormat,
    urlSymbols
  ];
}