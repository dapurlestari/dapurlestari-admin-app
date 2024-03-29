import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/soft_keyboard.dart';
import 'media_file_picker.dart';

class SeoForm extends StatelessWidget {
  final Seo seo;
  final String tag;
  const SeoForm({Key? key,
    required this.seo,
    this.tag = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final SeoController controller = Get.put(SeoController(), tag: '$tag.seo');
    controller.metaTitleField.value.text = seo.metaTitle;
    controller.metaDescriptionField.value.text = seo.metaDescription;
    if (seo.metaSocial.isNotEmpty) {
      controller.metaSocialDescriptionField.value.text = seo.metaSocial[0].description;
    }
    controller.canonicalURLField.value.text = seo.canonicalUrl;
    controller.metaKeywordsField.value.text = seo.keywords;
    controller.metaImage.value = seo.metaImage;

    return Obx(() => CustomField.fieldGroup(
        label: 'SEO',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomField.text(
              controller: controller.metaTitleField.value,
              hint: 'Site title goes here',
              label: 'Meta Title (Applied to Meta Social)',
            ),
            CustomField.text(
                controller: controller.metaDescriptionField.value,
                hint: 'Describe your site here',
                label: 'Meta Description',
                minLines: 1,
                maxLines: 2
            ),
            CustomField.text(
                controller: controller.metaSocialDescriptionField.value,
                hint: 'Add description for social media',
                label: 'Meta Social Description (Max. 65)',
                minLines: 1,
                maxLines: 2,
                maxLength: 65,
                inputFormatter: [
                  SoftKeyboard.limit(65)
                ]
            ),
            CustomField.text(
              controller: controller.canonicalURLField.value,
              hint: 'https://site.com/page',
              label: 'Canonical URL',
            ),
            CustomField.text(
                controller: controller.metaKeywordsField.value,
                hint: 'Insert some keywords (comma separated)',
                label: 'Meta Keywords',
                minLines: 1,
                maxLines: 5
            ),
            MediaFilePicker(
              mediaFile: controller.metaImage,
              tag: '$tag.seo',
              label: 'Meta Image',
            ),
          ],
        )
    ));
  }
}

class SeoController extends GetxController {
  final metaImage = MediaFile.dummy().obs;
  final metaTitleField = TextEditingController().obs;
  final metaDescriptionField = TextEditingController().obs;
  final metaSocialDescriptionField = TextEditingController().obs;
  final canonicalURLField = TextEditingController().obs;
  final metaKeywordsField = TextEditingController().obs;
}
