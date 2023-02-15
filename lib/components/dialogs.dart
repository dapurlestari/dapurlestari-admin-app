import 'package:admin/styles/color_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loadings.dart';

class Dialogs {
  static void plain({
    required Widget content,
    EdgeInsets? padding,
  }) {
    Get.dialog(Center(
      child: Stack(
        children: [
          GestureDetector(
            child: Material(
              elevation: 0,
              color: Get.theme.colorScheme.secondaryContainer,
              type: MaterialType.transparency,
            ),
            onTap: () => Get.back(),
          ),
          Center(
            child: Material(
              color: Get.theme.colorScheme.surface,
              elevation: 0,
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: Get.width * 0.83,
                padding: padding ?? const EdgeInsets.fromLTRB(20, 20, 20, 10),
                decoration: BoxDecoration(
                    color: Get.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: content,
              ),
            ),
          )
        ],
      ),
    ));
  }

  static void general({
    String? title,
    String contentText = 'Content',
    String cancelText = 'No',
    String confirmText = 'Yes',
    Color confirmBgColor = Colors.indigoAccent,
    Widget? content,
    Function? onCancel,
    required Function onConfirm,
  }) {
    Get.dialog(Stack(
      children: [
        GestureDetector(
          child: const Material(
            elevation: 0,
            type: MaterialType.transparency,
          ),
          onTap: () => Get.back(),
        ),
        Center(
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(15),
            clipBehavior: Clip.antiAlias,
            child: Container(
              width: Get.width * 0.83,
              decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(15)
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: ListView(
                shrinkWrap: true,
                children: [
                  title != null ? Text(title,
                    style: Get.textTheme.titleLarge, textAlign: TextAlign.center,) : Container(),
                  title != null ? const SizedBox(height: 20,) : Container(),
                  content ?? Text(contentText, style: Get.textTheme.bodyMedium, textAlign: TextAlign.center,),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            onCancel ?? Get.back();
                          },
                          child: Text(cancelText)
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: OutlinedButton(
                            onPressed: () => onConfirm(),
                            child: Text(confirmText)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  static void confirmOnly({
    String? title,
    String contentText = 'Content',
    String confirmText = 'OK',
    Widget? content,
    bool dismissible = true,
    required Function onConfirm,
  }) {
    Get.dialog(Stack(
      children: [
        GestureDetector(
          child: const Material(
            elevation: 0,
            type: MaterialType.transparency,
          ),
          onTap: () => Get.back(),
        ),
        Center(
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(15),
            clipBehavior: Clip.antiAlias,
            child: Container(
              width: Get.width * 0.83,
              decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(15)
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: ListView(
                shrinkWrap: true,
                children: [
                  title != null ? Text(title, style: Get.textTheme.titleMedium, textAlign: TextAlign.center,) : Container(),
                  title != null ? const SizedBox(height: 20,) : Container(),
                  content ?? Text(contentText, style: Get.textTheme.bodyMedium, textAlign: TextAlign.center,),
                  const SizedBox(height: 20,),
                  const Divider(color: ColorLib.pastelWhite,),
                  FilledButton(
                    onPressed: () => onConfirm(),
                    child: Text(confirmText)
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ), barrierDismissible: dismissible);
  }

  static void basic(Widget content, {
    bool showCloseButton = true,
    bool plain = false
  }) {
    Get.dialog(
      Stack(
        children: [
          GestureDetector(
            child: const Material(
              elevation: 0,
              type: MaterialType.transparency,
            ),
            onTap: () => Get.back(),
          ),
          Center(
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: Get.width * 0.83,
                decoration: BoxDecoration(
                    color: Get.theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(15)
                ),
                padding: plain ? null : const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    showCloseButton ? Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.white,
                          child: const Icon(Icons.clear_rounded, size: 25, color: Colors.grey,),
                        ),
                        onTap: () => Get.back(),
                      ),
                    ) : Container(),
                    content
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      useSafeArea: true,);
  }

  static void titled(Widget content, {String title = 'Alert'}) {
    Get.defaultDialog(
        title: title,
        titlePadding: const EdgeInsets.only(top: 30, bottom: 20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        content: content
    );
  }

  static void showOverlaidLoading() {
    Get.dialog(Loadings.primaryWithBg,
        barrierDismissible: false,
        barrierColor: Colors.black38
    );
  }
}