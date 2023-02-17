import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/models/components/contentful.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/screens/components/media_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'markdown_editor.dart';

class ContentfulForm extends StatelessWidget {
  final Contentful contentful;
  final String tag;
  final String imageLabel;
  const ContentfulForm({Key? key,
    required this.contentful,
    this.tag = '',
    this.imageLabel = 'Image',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ContentfulController controller = Get.put(ContentfulController(), tag: '$tag.contentful');
    controller.titleField.value.text = contentful.title;
    controller.subtitleField.value.text = contentful.subtitle;
    controller.contentField.value.text = contentful.content;

    return Obx(() => CustomField.fieldGroup(
        label: 'Contentful',
        content: Column(
          children: [
            CustomField.text(
                controller: controller.titleField.value,
                hint: 'Summarize this config',
                label: 'Title'
            ),
            CustomField.text(
                controller: controller.subtitleField.value,
                hint: 'Insert some words',
                label: 'Subtitle',
                minLines: 3,
                maxLines: 5
            ),
            MarkdownEditor(
              controller: controller.contentField.value,
              label: 'Content',
            ),
            const SizedBox(height: 12),
            MediaFilePicker(
              mediaFile: controller.featuredImage,
              label: imageLabel,
              tag: '$tag.contentful',
            )
          ],
        )
    ));
  }
}

class ContentfulController extends GetxController {
  final featuredImage = MediaFile.dummy().obs;
  final titleField = TextEditingController().obs;
  final subtitleField = TextEditingController().obs;
  final contentField = TextEditingController().obs;
}
