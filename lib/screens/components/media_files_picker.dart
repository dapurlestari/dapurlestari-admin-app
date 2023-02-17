import 'package:admin/components/image_manager/image_viewer.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/screens/main_controller.dart';
import 'package:admin/screens/media_library/media_library_screen.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class MediaFilesPicker extends StatelessWidget {
  final List<MediaFile> mediaFiles;
  final String tag;
  const MediaFilesPicker({Key? key,
    required this.mediaFiles,
    this.tag = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaFilesPickerController controller = Get.find(tag: '$tag.medias');

    return Obx(() => AspectRatio(
      aspectRatio: 8/7,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade600),
            borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            controller.images.isNotEmpty ? Stack(
              children: [
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                controller.images[controller.index.value].url
                            ),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  onTap: () => Get.to(() => ImageViewer(
                    images: controller.images,
                    initialPage: controller.index.value,
                    onPageChanged: (i) => controller.index.value = i,
                    title: 'Images',
                  )),
                ),
                Positioned(
                  top: 10,
                  right: 25,
                  child: InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black45,
                                spreadRadius: 0,
                                blurRadius: 10
                            )
                          ]
                      ),
                      child: const Icon(FeatherIcons.trash2,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      controller.prev();
                      controller.images.removeAt(controller.index.value+1);
                    },
                  ),
                )
              ],
            ) : InkWell(
              onTap: _pickImages,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 14),
                height: 300,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(FeatherIcons.uploadCloud),
                    SizedBox(height: 8),
                    Text('Upload images or choose from library'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: controller.prev,
                        style: const ButtonStyle(
                            padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(8))
                        ),
                        child: Text('Prev', style: Get.textTheme.titleMedium),
                      ),
                      const SizedBox(width: 10),
                      Text('${(controller.index.value+1)} of ${controller.images.length}',
                          style: Get.textTheme.titleMedium
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: controller.next,
                        style: const ButtonStyle(
                            padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(8))
                        ),
                        child: Text('Next', style: Get.textTheme.titleMedium),
                      ),
                    ],
                  ),
                  OutlinedButton(
                    onPressed: _pickImages,
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(8))
                    ),
                    child: Text('Add', style: Get.textTheme.titleMedium),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _pickImages() async {
    final MediaFilesPickerController controller = Get.find(tag: '$tag.medias');
    final MainController mainController = Get.find();
    mainController.refreshMediaLibrary(selectedFiles: controller.images);
    SoftKeyboard.hide();
    List<MediaFile>? mediaFiles = await Get.to(() => MediaLibraryScreen(
      enableSelection: true,
      isMultiselect: true,
      selectedFiles: controller.images,
    ));

    if (mediaFiles != null) {
      for (var media in mediaFiles) {
        bool exists = controller.images.indexWhere((e) => e.id == media.id) >= 0;
        if (!exists) {
          controller.images.add(media);
        }
      }
    }
  }
}

class MediaFilesPickerController extends GetxController {
  final images = <MediaFile>[].obs;
  final index = 0.obs;

  void next() {
    if (index < images.length-1) index.value++;
  }

  void prev() {
    if (index > 0) index.value--;
  }
}