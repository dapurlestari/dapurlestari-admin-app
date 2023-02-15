import 'package:admin/screens/index_screen.dart';
import 'package:admin/screens/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'services/constant_lib.dart';
import 'services/custom_material_builder.dart';
import 'styles/no_scroll_overlay.dart';
import 'styles/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initService();
  initializeDateFormatting(ConstLib.localeID, null)
      .then((_) => runApp(const MyApp()));
}

void initService() {
  Get.put(MainController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: NoScrollOverlay(),
      title: ConstLib.appName,
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      color: Colors.white,
      builder: (_, child) => CustomMaterialBuilder(child: child,),
      home: const IndexScreen(),
    );
  }
}
