import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/models/app/menu.dart';
import 'package:admin/models/server/access_status.dart';
import 'package:admin/screens/home/home_controller.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
      useAppBar: false,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: const Color(0xFFA1A9FE),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.shade200,
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                )
              ]
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset('assets/images/logo.png', height: 80,),
                const SizedBox(height: 40),
                Text('Good morning, Admin!', style: Get.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontFamily: ConstLib.secondaryFont,
                  letterSpacing: 0.5,
                  fontSize: 28,
                  color: Colors.white
                )),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3/2
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: homeController.accessStatuses.map((e) => statusCardItem(e)).toList(),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 30,),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: Menu.homeMenu.length,
            itemBuilder: (_, i) => menuItem(Menu.homeMenu[i]),
            separatorBuilder: (_, i) => Divider(indent: 20, endIndent: 20, color: Colors.grey.shade200),
          )
        ],
      )
    ));
  }

  Widget statusCardCompact(AccessStatus accessStatus) {
    return Container(
      decoration: BoxDecoration(
          color: accessStatus.bgColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, 3),
            )
          ]
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Text(accessStatus.label, style: Get.textTheme.titleSmall),
          const SizedBox(width: 10,),
          Icon(
            accessStatus.healthy ? FeatherIcons.cloud : FeatherIcons.cloudOff,
            size: 16,
            color: accessStatus.healthy ? Colors.cyan : Colors.red,
          )
        ],
      ),
    );
  }

  Widget statusCardItem(AccessStatus accessStatus) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade50
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Badge(
                backgroundColor: accessStatus.healthy ? Colors.greenAccent : Colors.red
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(accessStatus.icon),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(accessStatus.label, style: Get.textTheme.titleLarge?.copyWith(
                    color: Colors.indigoAccent
                  )),
                  Text('Tap to refresh', style: Get.textTheme.bodySmall),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget menuItem(Menu menu) {
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
                Text(menu.title, style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.indigoAccent
                )),
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
