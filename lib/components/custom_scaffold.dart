import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final bool useAppBar;
  final bool showBackButton;
  final String? title;
  final List<Widget>? actions;
  const CustomScaffold({Key? key,
    required this.body,
    this.useAppBar = true,
    this.showBackButton = true,
    this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: !useAppBar ? null : AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey.shade300,
        elevation: 0.5,
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
            Text(title ?? '', style: Get.textTheme.titleLarge?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.indigoAccent
            ))
          ],
        ),
      ),
      body: body,
    );
  }
}
