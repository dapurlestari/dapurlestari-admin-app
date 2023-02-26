import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loadings.dart';

class Shimmers {
  static Widget plain({
    Color color = Colors.white,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? radius,
    List<BoxShadow>? shadows,
  }) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: color,
          borderRadius: radius,
          boxShadow: shadows
      ),
      child: Loadings.basic(),
    );
  }

  static Widget box({
    Size size = const Size(80, 80),
    Color color = Colors.white,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? radius,
    List<BoxShadow>? shadows,
    bool withLoading = false,
  }) {
    return Container(
      width: size.width,
      height: size.height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: color,
          borderRadius: radius,
          boxShadow: shadows
      ),
      child: withLoading ? Loadings.basic() : null,
    );
  }

  static Widget text({
    double width = 100,
    double height = 14,
    Color? color,
    bool accent = false
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: box(
          size: Size(width, height),
          color: color ?? Get.theme.hintColor.withOpacity(accent ? 1 : 0.2),
          radius: BorderRadius.circular(15),
          withLoading: false
      ),
    );
  }

  static Widget textGrey({double width = 100, double height = 10}) {
    return SizedBox(
      width: width,
      height: height,
      child: box(
          size: Size(width, height),
          color: Colors.grey.shade200,
          radius: BorderRadius.circular(15),
          withLoading: false
      ),
    );
  }
}