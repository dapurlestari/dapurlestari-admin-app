import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tables {
  static TableRow rowItem({
    required String title,
    required String value,
    Color textColor = Colors.black54
  }) {
    return TableRow(children: [
      Text(
          title,
          style: Get.textTheme.titleSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600
          )
      ),
      Text(
        value.isEmpty ? '-' : value,
        style: Get.textTheme.titleSmall?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w300
        ),
      )
    ]);
  }

  static TableRow rowItemLight({
    required String title,
    required String value,
  }) {
    return rowItem(title: title, value: value, textColor: Colors.white);
  }

  static TableRow rowItemDark({
    required String title,
    required String value,
  }) {
    return rowItem(title: title, value: value, textColor: Colors.grey.shade800);
  }
}