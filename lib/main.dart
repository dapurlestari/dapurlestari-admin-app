import 'package:admin/screens/authentication/login_screen.dart';
import 'package:admin/screens/index_screen.dart';
import 'package:admin/screens/main_controller.dart';
import 'package:admin/services/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'services/constant_lib.dart';
import 'services/custom_material_builder.dart';
import 'styles/no_scroll_overlay.dart';
import 'styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initService();
  initializeDateFormatting(ConstLib.localeID, null)
      .then((_) => runApp(MyApp()));
}

Future<void> initService() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFB4BAFC),
      statusBarIconBrightness: Brightness.dark
  ));
  await GetStorage.init(ConstLib.userStorage);
  Get.put(MainController());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box = GetStorage(ConstLib.userStorage);

  @override
  Widget build(BuildContext context) {
    bool hasUser = box.hasData(ConstLib.userAuth);
    return GetMaterialApp(
      scrollBehavior: NoScrollOverlay(),
      title: ConstLib.appName,
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      color: Colors.white,
      builder: (_, child) => CustomMaterialBuilder(child: child,),
      home: !hasUser ? LoginScreen() : const IndexScreen(),
    );
  }
}
