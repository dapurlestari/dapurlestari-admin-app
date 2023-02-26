import 'package:admin/components/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheets {
  static Widget customSheet({
    required Widget child,
    String header = 'Header',
    required RxBool isLoading,
    GestureTapCallback? onApply
  }) {
    return Container(
      height: Get.height * 0.65,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  width: 80,
                  height: 6,
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(header, style: Get.textTheme.titleLarge?.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700
                  )),
                  if (isLoading.value) Loadings.basicPrimary
                ],
              )),
              const SizedBox(height: 20),
              Expanded(child: child)
            ],
          ),
          if (onApply != null) Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 15, bottom: 18),
                color: Colors.white,
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.indigoAccent
                    ),
                    child: Center(
                      child: Text('Apply', style: Get.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade100,
                          fontSize: 18
                      )),
                    ),
                  ),
                  onTap: () {},
                ),
              )
          )
        ],
      ),
    );
  }

  static Future open({
    required Widget child,
    String header = 'Header',
    required RxBool isLoading,
    GestureTapCallback? onApply
  }) async {
    return await Get.bottomSheet(
      customSheet(
        child: child,
        header: header,
        isLoading: isLoading,
        onApply: onApply
      ),
      enterBottomSheetDuration: const Duration(milliseconds: 150),
      exitBottomSheetDuration: const Duration(milliseconds: 150)
    );
  }
}