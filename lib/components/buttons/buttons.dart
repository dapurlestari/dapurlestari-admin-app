import 'package:admin/components/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Buttons {
  static Widget floatingBottomButton({
    String label = 'Save',
    bool isLoading = false,
    VoidCallback? onPressed
  }) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          color: Colors.white,
          child: FilledButton(
            onPressed: onPressed,
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(vertical: 15))
            ),
            child: isLoading ? Loadings.basic(
                size: const Size(23, 23),
                color: Colors.white
            ) : Text(
                label,
                style: Get.textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    color: Colors.white
                )
            ),
          ),
        )
    );
  }
}