import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'media_file_picker.dart';

class SeoForm extends StatelessWidget {
  final Seo seo;
  SeoForm({Key? key, required this.seo}) : super(key: key);

  final SeoController _controller = Get.put(SeoController());

  @override
  Widget build(BuildContext context) {
    _controller.metaTitleField.value.text = seo.metaTitle;
    _controller.metaDescriptionField.value.text = seo.metaDescription;
    _controller.metaSocialDescriptionField.value.text = seo.metaSocial[0].description;
    _controller.canonicalURLField.value.text = seo.canonicalUrl;
    _controller.metaKeywordsField.value.text = seo.keywords;

    return Obx(() => CustomField.fieldGroup(
        label: 'SEO',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomField.text(
              controller: _controller.metaTitleField.value,
              hint: 'Site title goes here',
              label: 'Meta Title (Applied to Meta Social)',
            ),
            CustomField.text(
                controller: _controller.metaDescriptionField.value,
                hint: 'Describe your site here',
                label: 'Meta Description',
                minLines: 1,
                maxLines: 2
            ),
            CustomField.text(
                controller: _controller.metaSocialDescriptionField.value,
                hint: 'Add description for social media',
                label: 'Meta Social Description (Max. 65)',
                minLines: 1,
                maxLines: 2,
                maxLength: 65
            ),
            CustomField.text(
              controller: _controller.canonicalURLField.value,
              hint: 'https://site.com/page',
              label: 'Canonical URL',
            ),
            CustomField.text(
                controller: _controller.metaKeywordsField.value,
                hint: 'Insert some keywords (comma separated)',
                label: 'Meta Keywords',
                minLines: 1,
                maxLines: 5
            ),
            MediaFilePicker(mediaFile: seo.metaImage)
          ],
        )
    ));
  }
}

class SeoController extends GetxController {
  final metaTitleField = TextEditingController().obs;
  final metaDescriptionField = TextEditingController().obs;
  final metaSocialDescriptionField = TextEditingController().obs;
  final canonicalURLField = TextEditingController().obs;
  final metaKeywordsField = TextEditingController().obs;
}
