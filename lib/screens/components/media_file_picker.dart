import 'package:admin/models/image/media_file.dart';
import 'package:admin/screens/media_library/media_library_screen.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/soft_keyboard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class MediaFilePicker extends StatelessWidget {
  final MediaFile mediaFile;
  MediaFilePicker({Key? key,
    required this.mediaFile,
  }) : super(key: key);

  final MediaFilePickerController _controller = Get.put(MediaFilePickerController());

  @override
  Widget build(BuildContext context) {
    _controller.metaImage.value = mediaFile;

    return Obx(() => AspectRatio(
      aspectRatio: 7/4,
      child: InkWell(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade600),
              borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controller.metaImage.value.hasURL ? Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                _controller.metaImage.value.url
                            ),
                            fit: BoxFit.cover
                        )
                    ),
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
                        _controller.metaImage.value = MediaFile.dummy();
                      },
                    ),
                  )
                ],
              ) : Column(
                children: const [
                  Icon(FeatherIcons.uploadCloud),
                  SizedBox(height: 8),
                  Text('Upload image or choose from library'),
                ],
              ),
              const SizedBox(height: 20),
              Text('Meta Image', style: Get.textTheme.titleMedium),
            ],
          ),
        ),
        onTap: () async {
          SoftKeyboard.hide();
          MediaFile? media = await Get.to(() => MediaLibraryScreen(
            enableSelection: true,
          ));
          if (media != null) {
            _controller.metaImage.value = media;
            logInfo(_controller.metaImage.value.id, logLabel: 'media_id');
          }
        },
      ),
    ));
  }
}

class MediaFilePickerController extends GetxController {
  final metaImage = MediaFile.dummy().obs;
}