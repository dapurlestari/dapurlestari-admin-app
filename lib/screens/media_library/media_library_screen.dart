import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/screens/main_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class MediaLibraryScreen extends StatelessWidget {
  final bool enableSelection;
  final bool isMultiselect;
  MediaLibraryScreen({Key? key,
    this.enableSelection = false,
    this.isMultiselect = false,
  }) : super(key: key);

  final MainController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
      title: 'Media Library',
      showBackButton: true,
      body: _body,
      actions: [
        IconButton(
          icon: Icon(
            _mainController.mediaLibraryEnableGridView.value
              ? FeatherIcons.grid
              : FeatherIcons.columns,
            color: Colors.grey.shade800
          ),
          onPressed: _mainController.mediaLibraryEnableGridView.toggle,
        ),
        if (enableSelection) IconButton(
          icon: Icon(FeatherIcons.save,
            color: Colors.grey.shade800,
          ),
          onPressed: () {
            MediaFile? media = _mainController.mediaFiles.firstWhereOrNull((e) => e.selected);
            media?.selected = false;
            _mainController.mediaFiles.refresh();
            Get.back(result: media);
          },
        )
      ],
    ));
  }

  Widget get _body {
    if (_mainController.isLoadingMediaLibrary.value) {
      return _shimmer;
    }

    return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _mainController.mediaLibraryEnableGridView.value ? 3 : 2,
            childAspectRatio: 1/1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 10
        ),
        itemCount: _mainController.mediaFiles.length,
        itemBuilder: (_, i) {
          MediaFile media = _mainController.mediaFiles[i];
          return InkWell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Stack(
                  children: [
                    media.isImage ? mediaImage(media) : mediaDocument(media),
                    Positioned(
                      bottom: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(media.mimeExtOnly, style: Get.textTheme.bodySmall?.copyWith(
                            fontSize: 9,
                            color: Colors.white
                        )),
                      ),
                    ),
                    if (enableSelection) Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
                        decoration: !media.selected ? null : BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isMultiselect
                                  ? !media.selected ? LineIcons.checkSquare : LineIcons.square
                                  : !media.selected ? LineIcons.circle : LineIcons.checkCircle,
                              size: 16,
                              color: media.selected ? Colors.white : Colors.grey.shade700,
                            ),
                            if (media.selected) const SizedBox(width: 6,),
                            if (media.selected) Text('Selected', style: Get.textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontSize: 12
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
                if (!_mainController.mediaLibraryEnableGridView.value) Container(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(media.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Get.textTheme.titleSmall,
                      ),
                      Text(media.getAlternativeText, style: Get.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600
                      )),
                    ],
                  ),
                )
              ],
            ),
            onTap: () {
              if (enableSelection) {
                int index = _mainController.mediaFiles.indexWhere((e) => e.selected);
                if (!isMultiselect && index > -1) {
                  _mainController.mediaFiles[index].selected = false;
                }

                media.selected = !media.selected;
                _mainController.mediaFiles.refresh();
              }
            },
          );
        }
    );
  }

  Widget mediaImage(MediaFile media) {
    return CachedNetworkImage(
      imageUrl: media.url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.indigoAccent),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )
        ),
      ),
      placeholder: (context, url) => const Center(
        child: Icon(FeatherIcons.circle),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Text('Image Error')
      ),
    );
  }

  Widget mediaDocument(MediaFile media) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.indigoAccent, width: 0.7),
      ),
      child: const Center(
        child: Icon(FeatherIcons.fileText),
      ),
    );
  }

  Widget get _shimmer {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 7/5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10
        ),
        itemCount: 12,
        itemBuilder: (_, i) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.indigoAccent, width: 0.7)
            ),
            child: CachedNetworkImage(
              imageUrl: MediaFile.dummyImage(),
              fit: BoxFit.contain,
            ),
          );
        }
    );
  }
}
