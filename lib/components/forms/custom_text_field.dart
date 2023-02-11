import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomField {
  static Widget text({
    String? hint,
    int? minLines,
    int? maxLines,
    TextInputAction? action,
  }) {
    return TextField(
      minLines: minLines,
      maxLines: maxLines,
      textInputAction: action ?? TextInputAction.next,
      style: Get.textTheme.bodyLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade900
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Get.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.grey.shade500
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade600),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.indigoAccent),
        ),
      ),
    );
  }

  static Widget fieldGroup({
    required String label,
    required Widget content
  }) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text('• $label', style: Get.textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade400,
                fontSize: 14
            )),
          ),
          const SizedBox(height: 8),
          content
        ],
      ),
    );
  }
}