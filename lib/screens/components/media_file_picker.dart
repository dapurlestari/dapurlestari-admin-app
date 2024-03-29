import 'package:admin/components/image_manager/image_viewer.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/screens/main_controller.dart';
import 'package:admin/screens/media_library/media_library_screen.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class MediaFilePicker extends StatelessWidget {
  final Rx<MediaFile> mediaFile;
  final String tag;
  final String label;
  const MediaFilePicker({Key? key,
    required this.mediaFile,
    this.tag = '',
    this.label = 'Image',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AspectRatio(
      aspectRatio: 7/4,
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
            mediaFile.value.hasURL ? Stack(
              children: [
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                mediaFile.value.url
                            ),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  onTap: () => Get.to(() => ImageViewer(images: [mediaFile.value])),
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
                      mediaFile.value = MediaFile.dummy();
                    },
                  ),
                )
              ],
            ) : InkWell(
              onTap: _pickImage,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 14),
                height: 180,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(FeatherIcons.uploadCloud),
                    SizedBox(height: 8),
                    Text('Upload image or choose from library'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label, style: Get.textTheme.titleMedium),
                  OutlinedButton(
                    onPressed: _pickImage,
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(8))
                    ),
                    child: Text('Choose', style: Get.textTheme.titleMedium,)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _pickImage() async {
    // final MediaFilePickerController controller = Get.find(tag: '$tag.media');
    final MainController mainController = Get.find();
    mainController.refreshMediaLibrary(selectedFiles: [mediaFile.value]);
    SoftKeyboard.hide();
    MediaFile? media = await Get.to(() => MediaLibraryScreen(
      enableSelection: true,
    ));
    if (media != null) {
      mediaFile.value = media;
      logInfo(mediaFile.value.id, logLabel: 'media_id');
    }
  }
}