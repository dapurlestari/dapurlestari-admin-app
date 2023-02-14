import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CsutomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final GestureTapCallback? onTap;
  const CsutomButton({Key? key,
    required this.label,
    this.icon,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 2
        ),
        decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(label.toUpperCase(), style: Get.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade200
          )),
        ),
      ),
    );
  }
}
