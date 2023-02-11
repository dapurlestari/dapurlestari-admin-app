import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarManager {
  static void hide() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  static void show() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  static void init() {
    show();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    ));
  }
}