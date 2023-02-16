import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class CustomField {
  static Widget text({
    TextEditingController? controller,
    String? hint,
    String label = '',
    int? minLines,
    int maxLines = 1,
    int? maxLength,
    bool readOnly = false,
    bool? enabled,
    TextInputAction? action,
    TextInputType? keyboardType,
    EdgeInsets? margin,
    Widget? suffixIcon,
    BoxConstraints? suffixConstraint,
    List<TextInputFormatter>? inputFormatter,
    GestureTapCallback? onTap,
    ValueChanged<String>? onChanged
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        minLines: minLines,
        maxLines: maxLines,
        readOnly: readOnly,
        enabled: enabled,
        keyboardType: keyboardType,
        inputFormatters: inputFormatter,
        textInputAction: action ?? (maxLines > 1 ? TextInputAction.newline : TextInputAction.next),
        style: Get.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: readOnly ? Colors.grey.shade500 : Colors.grey.shade900
        ),
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
          filled: readOnly,
          fillColor: Colors.grey.shade100,
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixConstraint
        ),
        onTap: onTap,
        onChanged: onChanged,
      ),
    );
  }

  static Widget chip({
    String label = '',
    bool enable = false,
    EdgeInsets? padding,
    required GestureTapCallback? onTap
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Get.textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.grey.shade900
            )),
            const SizedBox(width: 12),
            Icon(!enable ? FeatherIcons.toggleLeft : FeatherIcons.toggleRight,
              color: !enable ? Colors.grey.shade800 : Colors.indigoAccent,
            )
          ],
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