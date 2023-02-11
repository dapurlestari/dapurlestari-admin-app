

import 'package:flutter/material.dart';

import 'color_lib.dart';

class TextStyles {
  static TextStyle? get normal12 => normalStyle(12);
  static TextStyle? get normal13 => normalStyle(13);
  static TextStyle? get normal14 => normalStyle(14);
  static TextStyle? get normal15 => normalStyle(15);
  static TextStyle? get normal16 => normalStyle(16);
  static TextStyle? get normal17 => normalStyle(17);
  static TextStyle? get normal18 => normalStyle(18);
  static TextStyle? get normal19 => normalStyle(19);
  static TextStyle? get normal20 => normalStyle(20);

  static TextStyle? get normalHint12 => normalStyle(12, color: ColorLib.hint);
  static TextStyle? get normalHint14 => normalStyle(14, color: ColorLib.hint);
  static TextStyle? get normalHint15 => normalStyle(15, color: ColorLib.hint);
  static TextStyle? get normalHint18 => normalStyle(18, color: ColorLib.hint);
  static TextStyle? get normalHint22 => normalStyle(22, color: ColorLib.hint);

  static TextStyle? get normalLight12 => normalStyle(12, color: Colors.white);
  static TextStyle? get normalLight13 => normalStyle(13, color: Colors.white);
  static TextStyle? get normalLight14 => normalStyle(14, color: Colors.white);
  static TextStyle? get normalLight15 => normalStyle(15, color: Colors.white);
  static TextStyle? get normalLight16 => normalStyle(16, color: Colors.white);
  static TextStyle? get normalLight17 => normalStyle(17, color: Colors.white);
  static TextStyle? get normalLight18 => normalStyle(18, color: Colors.white);
  static TextStyle? get normalLight19 => normalStyle(19, color: Colors.white);
  static TextStyle? get normalLight20 => normalStyle(20, color: Colors.white);

  static TextStyle? get bold12 => boldStyle(12);
  static TextStyle? get bold13 => boldStyle(13);
  static TextStyle? get bold14 => boldStyle(14);
  static TextStyle? get bold15 => boldStyle(15);
  static TextStyle? get bold16 => boldStyle(16);
  static TextStyle? get bold17 => boldStyle(17);
  static TextStyle? get bold18 => boldStyle(18);
  static TextStyle? get bold19 => boldStyle(19);
  static TextStyle? get bold20 => boldStyle(20);
  static TextStyle? get bold21 => boldStyle(21);
  static TextStyle? get bold22 => boldStyle(22);
  static TextStyle? get bold23 => boldStyle(23);
  static TextStyle? get bold24 => boldStyle(24);
  static TextStyle? get bold25 => boldStyle(25);

  static TextStyle? get boldLight12 => boldStyle(12, color: Colors.white);
  static TextStyle? get boldLight13 => boldStyle(13, color: Colors.white);
  static TextStyle? get boldLight14 => boldStyle(14, color: Colors.white);
  static TextStyle? get boldLight15 => boldStyle(15, color: Colors.white);
  static TextStyle? get boldLight16 => boldStyle(16, color: Colors.white);
  static TextStyle? get boldLight17 => boldStyle(17, color: Colors.white);
  static TextStyle? get boldLight18 => boldStyle(18, color: Colors.white);
  static TextStyle? get boldLight19 => boldStyle(19, color: Colors.white);
  static TextStyle? get boldLight20 => boldStyle(20, color: Colors.white);
  static TextStyle? get boldLight21 => boldStyle(21, color: Colors.white);
  static TextStyle? get boldLight22 => boldStyle(22, color: Colors.white);
  static TextStyle? get boldLight23 => boldStyle(23, color: Colors.white);
  static TextStyle? get boldLight24 => boldStyle(24, color: Colors.white);
  static TextStyle? get boldLight25 => boldStyle(25, color: Colors.white);

  static TextStyle normalStyle(double size, {
    Color color = Colors.black87
  }) {
    return TextStyle(
      fontSize: size,
      color: color
    );
  }

  static TextStyle boldStyle(double size, {
    Color color = Colors.black87
  }) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size,
      color: color
    );
  }
}