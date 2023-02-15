import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constant_lib.dart';
import 'logger.dart';

class ClipboardManager {
  static void clip(String value, {
    String title = ConstLib.appName,
    String message = 'Text copied to clipboard!',
    bool silent = false,
  }) {
    String newMessage = message;
    if (value.contains('http')) {
      newMessage = 'Link copied to clipboard!';
    }

    Clipboard.setData(ClipboardData(text: value));
    logInfo(value, logLabel: 'copy_to_clipboard');
    if (!silent) {
      Fluttertoast.showToast(msg: newMessage);
    }
  }
}