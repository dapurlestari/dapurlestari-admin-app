import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/models/app/menu.dart';
import 'package:admin/screens/collection/collection_screen.dart';
import 'package:admin/screens/home/home_screen.dart';
import 'package:admin/screens/index_controller.dart';
import 'package:admin/screens/settings/settings_screen.dart';
import 'package:admin/screens/single_type/single_type_screen.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final indexController = Get.put(IndexController());

  final pageController = PageController();
  bool showMenuLabel = false;

  @override
  void initState() {
    indexController.closeCounter.value = 0;
    super.initState();
  }

  Future<bool> _onBack() async {
    indexController.closeCounter.value++;
    logInfo(indexController.closeCounter.value, logLabel: 'close_counter');
    if (indexController.closeCounter.value > 1) {
      indexController.closeCounter.value = 0;
      SystemNavigator.pop(); // close app
      return true;
    } else {
      Fluttertoast.showToast(
        msg: ConstLib.appExitGesture,
        toastLength: Toast.LENGTH_LONG
      );
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: _bottomNavBar,
      overrideOnBack: true,
      useAppBar: false,
      onBack: _onBack,
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: [
          HomeScreen(),
          CollectionScreen(),
          SingleTypeScreen(),
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
                    menu.title,
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
