import 'package:admin/models/app/menu.dart';
import 'package:admin/screens/collection/collection_screen.dart';
import 'package:admin/screens/home/home_screen.dart';
import 'package:admin/screens/index_controller.dart';
import 'package:admin/screens/settings/settings_screen.dart';
import 'package:admin/screens/single_type/single_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final indexController = Get.put(IndexController());

  final pageController = PageController();
  bool showMenuLabel = true;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: _bottomNavBar,
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: [
          HomeScreen(),
          CollectionScreen(),
          SingleTypeScreen(),
          const SettingsScreen()
        ],
      ),
    ));
  }

  Widget get _bottomNavBar => Container(
    height: showMenuLabel ? 80 : 65,
    margin: const EdgeInsets.fromLTRB(40, 0, 40, 20),
    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 2),
          )
        ]
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: indexController.menu.map((menu) {
        return Expanded(
          child: InkWell(
            onLongPress: _toggleMenuLabel,
            onTap: () => _onTapMenu(menu),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    menu.icon,
                    color: menu.active ? Colors.indigoAccent : null,
                  ),
                  if (showMenuLabel) const SizedBox(height: 8),
                  if (showMenuLabel) Text(
                    menu.label,
                    style: Get.textTheme.bodySmall?.copyWith(
                      color: menu.active ? Colors.indigoAccent : null,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );

  void _onPageChanged(int index) {
    indexController.clearActiveMenu();
    final menu = indexController.menu[index];
    menu.active = true;
    setState(() {});
  }

  void _onTapMenu(Menu menu) {
    indexController.clearActiveMenu();
    int index = indexController.menu.indexWhere((item) => item.id == menu.id);
    menu.active = true;
    pageController.jumpToPage(index);
    /*pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut
    );*/
    setState(() {});
  }

  void _toggleMenuLabel() {
    showMenuLabel = !showMenuLabel;
    setState(() {});
  }
}
