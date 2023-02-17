import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/models/components/contentful.dart';
import 'package:admin/models/components/galleryful.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/screens/components/media_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'markdown_editor.dart';

class GalleryfulForm extends StatelessWidget {
  final Galleryful galleryful;
  final String tag;
  final bool useLabel;
  const GalleryfulForm({Key? key,
    required this.galleryful,
    this.tag = '',
    this.useLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GalleryfulController>(
      init: GalleryfulController(),
      tag: '$tag.galleryful',
      builder: (controller) {
        controller.mediaFile.value = galleryful.image;
        controller.titleField.value.text = galleryful.title;
        controller.subtitleField.value.text = galleryful.subtitle;
        return CustomField.fieldGroup(
            label: 'Galleryful',
            useLabel: useLabel,
            content: Column(
              children: [
                CustomField.text(
                    controller: controller.titleField.value,
                    hint: 'Image title',
                    label: 'Title'
                ),
                CustomField.text(
                    controller: controller.subtitleField.value,
                    hint: 'Add some words',
                    label: 'Subtitle',
                    minLines: 1,
                    maxLines: 2
                ),
                const SizedBox(height: 12),
                MediaFilePicker(
                  mediaFile: controller.mediaFile,
                  tag: '$tag.galleryful',
                )
              ],
            )
        );
      },
    );
  }
}

class GalleryfulController extends GetxController {
  final mediaFile = MediaFile.dummy().obs;
  final titleField = TextEditingController().obs;
  final subtitleField = TextEditingController().obs;
}
