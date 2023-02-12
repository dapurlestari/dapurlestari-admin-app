
import 'package:admin/models/image/media_file.dart';
import 'package:admin/models/server/content_type.dart';
import 'package:admin/services/logger.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final contentTypes = <ContentType>[].obs;
  final collectionTypes = <ContentType>[].obs;
  final singleTypes = <ContentType>[].obs;
  final mediaFiles = <MediaFile>[].obs;
  final isLoadingContentTypes = false.obs;
  final isLoadingMediaLibrary = false.obs;
  final mediaLibraryEnableGridView = false.obs;

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

  Future<void> _fetchMedia() async {
    isLoadingMediaLibrary.value = true;
    List<MediaFile>? media = await MediaFile.get();
    if (media != null) {
      logInfo(media.first.name, logLabel: 'first_media');
      mediaFiles.value = media;
    }
    isLoadingMediaLibrary.value = false;
  }

  @override
  void onInit() {
    _fetchContentTypes();
    _fetchMedia();
    super.onInit();
  }
}