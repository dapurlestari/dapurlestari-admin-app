import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/models/components/contentful.dart';
import 'package:admin/screens/components/media_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentfulForm extends StatelessWidget {
  final Contentful contentful;
  final String tag;
  const ContentfulForm({Key? key,
    required this.contentful,
    this.tag = '',
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
            CustomField.text(
              controller: controller.contentField.value,
              hint: 'Describe privacy policy',
              label: 'Content',
              minLines: 5,
              maxLines: 10,
            ),
            MediaFilePicker(
              mediaFile: contentful.featuredImage,
              tag: '$tag.contentful.media',
            )
          ],
        )
    ));
  }
}

class ContentfulController extends GetxController {
  final titleField = TextEditingController().obs;
  final subtitleField = TextEditingController().obs;
  final contentField = TextEditingController().obs;
}
