import 'package:flutter/material.dart';

class GridViewForm extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  const GridViewForm({Key? key,
    required this.children,
    this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      padding: padding ?? EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9/2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      children: children,
    );
  }
}
