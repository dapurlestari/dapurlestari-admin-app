import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomField {
  static Widget text({
    String? hint,
    String label = '',
    int? minLines,
    int? maxLines,
    TextInputAction? action,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextField(
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
          label: label.isNotEmpty ? Text(label) : null,
          labelStyle: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.grey.shade800
          ),
          hintStyle: Get.textTheme.bodyLarge?.copyWith(
              fontSize: 14,
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.indigo.shade400,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text('• $label •', style: Get.textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade50,
                fontSize: 14
            )),
          ),
          const SizedBox(height: 14),
          content
        ],
      ),
    );
  }
}