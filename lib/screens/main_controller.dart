
import 'dart:io';

import 'package:admin/components/image_manager/image_cropper.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/models/server/content_type.dart';
import 'package:admin/services/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainController extends GetxController {
  final contentTypes = <ContentType>[].obs;
  final collectionTypes = <ContentType>[].obs;
  final singleTypes = <ContentType>[].obs;
  final mediaFiles = <MediaFile>[].obs;
  final isLoadingContentTypes = false.obs;
  final isLoadingMediaLibrary = false.obs;
  final mediaLibraryEnableGridView = false.obs;
  final mediaLibraryRefresher = RefreshController().obs;

  Future<void> _fetchContentTypes() async {
    isLoadingContentTypes.value = true;
    var contentTypes = await ContentType.get();
    if (contentTypes.isNotEmpty) {
      this.contentTypes.value = contentTypes;
      contentTypes = contentTypes.where((e) => e.isNotPlugin && e.isNotConfig).toList();
      collectionTypes.value = contentTypes.where((e) => e.schema.isCollectionType).toList();
      singleTypes.value = contentTypes.where((e) => e.schema.isSingleType).toList();
      isLoadingContentTypes.value = false;
    }
  }

  void deselectMedia() {
    int index = mediaFiles.indexWhere((e) => e.selected);
    if (index > -1) {
      mediaFiles[index].selected = false;
      mediaFiles.refresh();
    }
  }

  Future<void> _fetchMedia() async {
    List<MediaFile>? media = await MediaFile.get();
    if (media != null) {
      logInfo(media.first.name, logLabel: 'first_media');
      mediaFiles.value = media;
    }
    isLoadingMediaLibrary.value = false;
    mediaLibraryRefresher.value.refreshCompleted();
    mediaLibraryRefresher.value.loadComplete();
  }

  void refreshMediaLibrary() {
    isLoadingMediaLibrary.value = true;
    _fetchMedia();
  }

  Future<void> uploadToLibrary() async {
    MediaFile? media = await uploadMediaFile();
    if (media != null) {
      mediaFiles.insert(0, media);
    }
  }

  Future<MediaFile?> uploadMediaFile({Function? onComplete}) async {
    final ImagePicker picker = ImagePicker();
    final xFile = await picker.pickImage(source: ImageSource.gallery);

    logInfo(xFile != null, logLabel: 'file_upload');
    if (xFile != null) {
      File? croppedFile = await CustomImageCropper.defaultCropperWithCompression(
          file: File(xFile.path),
          title: 'Media File'
      );

      if (croppedFile != null) {
        logInfo(croppedFile.path, logLabel: 'cropped_path');
        return await MediaFile.upload(file: croppedFile);
      }
    } else {
      Fluttertoast.showToast(msg: 'Pick image canceled by user!');
    }

    if (onComplete != null) onComplete();
    return null;
  }

  @override
  void onInit() {
    _fetchContentTypes();
    refreshMediaLibrary();
    super.onInit();
  }
}