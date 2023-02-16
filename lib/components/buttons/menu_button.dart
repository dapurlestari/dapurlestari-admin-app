import 'package:admin/components/badges.dart';
import 'package:admin/models/app/menu.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuButton extends StatelessWidget {
  final Menu menu;
  const MenuButton({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: menu.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 14
        ),
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        child: Row(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(menu.title, style: Get.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.indigoAccent
                    )),
                    const SizedBox(width: 10),
                    if (menu.onTap == null) Badges.comingSoon,
                  ],
                ),
                Text(menu.subtitle,
                  style: Get.textTheme.bodyMedium?.copyWith(
                      fontFamily: ConstLib.secondaryFont,
                      letterSpacing: 0.4,
                      color: Colors.grey.shade900
                  ),
                ),
              ],
            )),
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color(0xFF4120A9)
                ),
              ),
              child: Icon(
                menu.icon,
                size: 18,
                color: const Color(0xFF4120A9),
              ),
            )
          ],
        ),
      ),
    );
  }
}
