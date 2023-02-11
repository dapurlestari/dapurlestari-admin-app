import 'package:admin/services/constant_lib.dart';
import 'package:flutter/material.dart';

import 'color_lib.dart';

class Themes {
  static ThemeData get light => ThemeData(
      primaryColor: ColorLib.primary,
      scaffoldBackgroundColor: ColorLib.bgLight,
      fontFamily: ConstLib.primaryFont
  );
}