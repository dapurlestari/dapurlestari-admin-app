import 'package:admin/services/soft_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final bool useAppBar;
  final bool showBackButton;
  final bool overrideOnBack;
  final bool enableWillPop;
  final String? title;
  final double? elevation;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Function? onBack;
  const CustomScaffold({Key? key,
    required this.body,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    this.extendBody = false,
    this.useAppBar = true,
    this.showBackButton = true,
    this.overrideOnBack = false,
    this.enableWillPop = true,
    this.title,
    this.bottom,
    this.elevation,
    this.actions,
    this.onBack,
  }) : super(key: key);

  void _onBack() {
    if (onBack != null) {
      if (overrideOnBack) {
        onBack!();
      } else {
        onBack!();
        Get.back();
      }
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (enableWillPop) {
      return WillPopScope(
        onWillPop: () async {
          _onBack();
          return false;
        },
        child: _scaffold,
      );
    }

    return _scaffold;
  }

  Widget get _scaffold => Scaffold(
    backgroundColor: backgroundColor,
    extendBody: extendBody,
    bottomNavigationBar: bottomNavigationBar,
    appBar: !useAppBar ? null : AppBar(
      automaticallyImplyLeading: false,
      bottom: bottom,
      backgroundColor: Colors.white,
      shadowColor: Colors.grey.shade300,
      elevation: elevation ?? 0.5,
      titleSpacing: showBackButton ? 8 : 20,
      actions: actions == null ? null : [
        ...actions!,
        const SizedBox(width: 10,)
      ],
      title: Row(
        children: [
          if (showBackButton) IconButton(
            icon: Icon(FeatherIcons.chevronLeft,
                color: Colors.grey.shade800,
                size: 25
            ),
            onPressed: Get.back,
          ),
          if (showBackButton) const SizedBox(width: 10,),
          InkWell(
            onTap: SoftKeyboard.hide,
            child: Text(title ?? '', style: Get.textTheme.titleLarge?.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Colors.indigoAccent
            )),
          )
        ],
      ),
    ),
    body: body,
  );
}
