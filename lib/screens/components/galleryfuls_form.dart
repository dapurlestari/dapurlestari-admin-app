import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/models/components/galleryful.dart';
import 'package:admin/screens/components/galleryful_form.dart';
import 'package:admin/services/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GalleryfulsForm extends StatelessWidget {
  final RxList<Galleryful> galleryfuls;
  final String tag;
  final String label;
  const GalleryfulsForm({Key? key,
    required this.galleryfuls,
    this.tag = '',
    this.label = 'Galleryfuls',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GalleryfulsController controller = Get.find(tag: '$tag.galleryfuls');

    void save() {
      final GalleryfulController gallery = Get.find(tag: '$tag.galleryfuls.galleryful');
      final Galleryful galleryful = Galleryful(
        title: gallery.titleField.value.text,
        subtitle: gallery.subtitleField.value.text,
        image: gallery.mediaFile.value
      );
      galleryfuls[controller.index.value] = galleryful;
      logInfo(galleryfuls[controller.index.value].toJson(), logLabel: 'galleryful');
    }

    void next() {
      save();
      if (controller.index < galleryfuls.length-1) controller.index.value++;
    }

    void prev() {
      save();
      if (controller.index > 0) controller.index.value--;
    }

    return Obx(() => CustomField.fieldGroup(
        label: label,
        action: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                OutlinedButton(
                  onPressed: prev,
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(8))
                  ),
                  child: Text('Prev', style: Get.textTheme.titleMedium),
                ),
                const SizedBox(width: 10),
                Text('${(controller.index.value+1)} of ${galleryfuls.length}',
                    style: Get.textTheme.titleMedium
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: next,
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(8))
                  ),
                  child: Text('Next', style: Get.textTheme.titleMedium),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {
                save();
                galleryfuls.add(Galleryful.dummy());
                controller.index.value++;
                logInfo(galleryfuls[controller.index.value].toJson(), logLabel: 'galleryful');
              },
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(8))
              ),
              child: Text('Add', style: Get.textTheme.titleMedium),
            ),
          ],
        ),
        content: GalleryfulForm(
          galleryful: galleryfuls[controller.index.value],
          tag: '$tag.galleryfuls',
          useLabel: false,
        )
    ));
  }
}

class GalleryfulsController extends GetxController {
  final index = 0.obs;
}
