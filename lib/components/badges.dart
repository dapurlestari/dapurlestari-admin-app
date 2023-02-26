import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Badges {
  static Widget get comingSoon {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Text('Coming Soon', style: Get.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade100,
          fontSize: 8.7
      )),
    );
  }
}