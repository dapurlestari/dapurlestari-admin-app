import 'package:admin/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexScreen extends StatelessWidget {
  IndexScreen({Key? key}) : super(key: key);

  final indexController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
