import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loadings {
  static Widget basic({
    Size size = const Size(20, 20),
    double width = 2,
    bool centered = true,
    Color? color
  }) {
    final loading = SizedBox(
      width: size.width,
      height: size.height,
      child: CircularProgressIndicator(
        strokeWidth: width,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? Get.theme.progressIndicatorTheme.color ?? Colors.lightBlueAccent),
      ),
    );

    if (!centered) return loading;

    return Center(
      child: loading,
    );
  }

  static Widget get basicPrimary => basic(color: Colors.indigoAccent, size: const Size(18, 18));
  static Widget get basicPrimarySmall => basic(color: Colors.indigoAccent, size: const Size(15, 15), width: 1);
  static Widget get basicSecondary => basic(color: Colors.grey.shade500, size: const Size(18, 18));
  static Widget get basicSecondarySmall => basic(color: Colors.grey.shade500, size: const Size(15, 15), width: 1);
  static Widget get basicLight => basic(color: Colors.white, size: const Size(17, 17));
  static Widget get basicLightSmall => basic(color: Colors.white, size: const Size(15, 15), width: 1);
  static Widget get primaryWithBg => Center(
    child: CircleAvatar(
      radius: 20,
      backgroundColor: Get.theme.progressIndicatorTheme.refreshBackgroundColor ?? Colors.white,
      child: basic(),
    ),
  );

  static Widget get primaryWithBgDark => Center(
    child: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black26,
      child: basic(color: Colors.indigoAccent),
    ),
  );

  static Widget get primaryWithBgLight => Center(
    child: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white10,
      child: basic(color: Colors.indigoAccent),
    ),
  );

  static Widget overlaid() => Container(
    width: Get.width,
    height: Get.height,
    color: Colors.black26,
    child: Center(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        // color: Colors.orangeAccent.withOpacity(0.4),
        child: basic(),
      ),
    ),
  );
}