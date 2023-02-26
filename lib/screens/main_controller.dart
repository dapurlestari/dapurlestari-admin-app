
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
  final mediaStart = 0.obs;

  int get selectedCount => mediaFiles.where((m) => m.selected).length;
  bool get hasSelectedItems => selectedCount > 0;

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

  Future<void> _fetchMedia({
    List<MediaFile> excludeFiles = const [],
    List<MediaFile> selectedFiles = const [],
  }) async {
    List<MediaFile>? media = await MediaFile.get(
      excludeFiles: excludeFiles,
      start: mediaStart.value
    );

    if (media != null) {
      logInfo(media.isNotEmpty, logLabel: 'media_exists');
      for (var file in selectedFiles) {
        int index = media.indexWhere((e) => e.id == file.id);
        if (index >= 0) media[index].selected = true;
      }

      mediaFiles.addAll(media);
    }
    isLoadingMediaLibrary.value = false;
    mediaLibraryRefresher.value.refreshCompleted();
    mediaLibraryRefresher.value.loadComplete();
  }

  void removeFromMedia(List<MediaFile> medias) {
    for (var media in medias) {
      mediaFiles.removeWhere((e) => e.id == media.id);
    }
  }

  void initSelection(MediaFile mediaFile) {
    for (var element in mediaFiles) {
      element.selected = false;
      element.selected = mediaFile.id == element.id;
    }
    mediaFiles.refresh();

    /*List<MediaFile> files = mediaFiles.where((e) => e.selected).toList();
    if (files.isNotEmpty) {
      for (var file in files) {
        int index = files.indexWhere((e) => e.id == file.id);
        if (index > -1) {
          mediaFiles[index].selected = false;
        }
      }

      mediaFiles.refresh();
    }*/
  }

  void refreshMediaLibrary({
    List<MediaFile> excludeFiles = const [],
    List<MediaFile> selectedFiles = const [],
  }) {
    mediaStart.value = 0;
    isLoadingMediaLibrary.value = true;
    mediaFiles.clear();
    // logInfo(selectedFiles.map((e) => e.id), logLabel: 'selected_files');
    _fetchMedia(excludeFiles: excludeFiles, selectedFiles: selectedFiles);
  }

  void loadMoreMediaLibrary({
    List<MediaFile> selectedFiles = const [],
  }) {
    mediaStart.value = mediaFiles.length;
    // logInfo(selectedFiles.map((e) => e.id), logLabel: 'selected_files');
    _fetchMedia(selectedFiles: selectedFiles);
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