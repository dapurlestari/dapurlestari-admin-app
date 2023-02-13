import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/models/components/contentful.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/screens/components/media_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentfulForm extends StatelessWidget {
  final Contentful contentful;
  ContentfulForm({Key? key,
    required this.contentful,
  }) : super(key: key);

  final ContentfulController _controller = Get.put(ContentfulController());

  @override
  Widget build(BuildContext context) {
    _controller.titleField.value.text = contentful.title;
    _controller.subtitleField.value.text = contentful.subtitle;
    _controller.contentField.value.text = contentful.content;

    return Obx(() => CustomField.fieldGroup(
        label: 'Contentful',
        content: Column(
          children: [
            CustomField.text(
                controller: _controller.titleField.value,
                hint: 'Summarize this config',
                label: 'Title'
            ),
            CustomField.text(
                controller: _controller.subtitleField.value,
                hint: 'Insert some words',
                label: 'Subtitle',
                minLines: 3,
                maxLines: 5
            ),
            CustomField.text(
              controller: _controller.contentField.value,
              hint: 'Describe privacy policy',
              label: 'Content',
              minLines: 5,
              maxLines: 10,
            ),
            MediaFilePicker(
              mediaFile: contentful.featuredImage,
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
