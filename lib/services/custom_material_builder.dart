import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomMaterialBuilder extends StatelessWidget {
  final Widget? child;

  const CustomMaterialBuilder({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, child!),
        backgroundColor: Colors.white,
        defaultScale: true,
        minWidth: 480,
        defaultName: MOBILE,
        breakpoints: [
          const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
          const ResponsiveBreakpoint.resize(600, name: MOBILE),
          const ResponsiveBreakpoint.resize(850, name: TABLET),
          const ResponsiveBreakpoint.resize(1080, name: DESKTOP),
        ],
        background: Container(color: Colors.white)
    );
  }
}
