import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class APIService extends GetxService {
  Future<APIService> init() async {
    Get.put(ProductController());
    return this;
  }
}