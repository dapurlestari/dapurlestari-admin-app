import 'package:admin/services/constant_lib.dart';
import 'package:flutter/material.dart';

import 'color_lib.dart';

class Themes {
  static ThemeData get light => ThemeData(
    primaryColor: ColorLib.primary,
    scaffoldBackgroundColor: ColorLib.bgLight,
    fontFamily: ConstLib.primaryFont,
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ))
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        // backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 2)
        )
      )
    )
  );
}