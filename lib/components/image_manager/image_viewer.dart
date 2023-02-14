
import 'package:admin/components/loadings.dart';
import 'package:admin/components/table/tables.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewer extends StatefulWidget {
  final String title;
  final List<MediaFile> images;
  final int initialPage;
  final Function(int index)? onPageChanged;

  const ImageViewer({Key? key,
    required this.images,
    this.title = '',
    this.initialPage = 0,
    this.onPageChanged}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late PageController _pageController;
  int _index = 0;
  bool _showExif = false;

  @override
  void initState() {
    _index = widget.initialPage;
    _pageController = PageController(initialPage: _index);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: GestureDetector(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _viewer,
            _closeIndicator,
            if (widget.images.length > 1) _navIndicator,
            if (_showExif) _exif
            // _unablePreviewIndicator,
          ],
        ),
        onVerticalDragUpdate: (details) {
          int sensitivity = 8;
          if (details.delta.dy > sensitivity) {
            Get.back();
          }
        },
      ),
    );
  }

  Widget get _closeIndicator => Positioned(
    top: 80,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [BoxShadow(offset: Offset(0, 3), spreadRadius: 0, blurRadius: 4, color: Colors.black45)]
      ),
      child: Text(
        'Swipe down to close!',
        style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey.shade100),
        textAlign: TextAlign.center,
      ),
    ),
  );

  Widget get _extensionIndicator {
    if (kReleaseMode) return Container();

    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _showExif ? Colors.grey.shade600 : Colors.grey.shade800,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [BoxShadow(offset: Offset(0, 3), spreadRadius: 0, blurRadius: 4, color: Colors.black45)]
        ),
        child: Text(
          widget.images[_index].ext,
          style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey.shade100),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        _showExif = !_showExif;
        setState(() {});
      },
    );
  }

  Widget get _exif {
    MediaFile media = widget.images[_index];
    return Positioned(
      bottom: 80,
      left: 40,
      right: 40,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 0,
              color: Colors.black38
            )
          ]
        ),
        child: Table(
          columnWidths: const {
            0: FixedColumnWidth(100),
          },
          children: [
            Tables.rowItemLight(
              title: 'ID',
              value: '#${media.id}',
            ),
            Tables.rowItemLight(
              title: 'Name',
              value: media.name
            ),
            Tables.rowItemLight(
              title: 'MIME Type',
              value: media.mime
            ),
            Tables.rowItemLight(
              title: 'Extension',
              value: media.ext
            ),
            Tables.rowItemLight(
              title: 'Dimension (px)',
              value: '${media.width}x${media.height}'
            ),
            Tables.rowItemLight(
              title: 'File Size (kb)',
              value: '${media.size}'
            ),
            Tables.rowItemLight(
              title: 'Available Formats',
              value: media.availableFormats
            ),
            Tables.rowItemLight(
              title: 'Caption',
              value: media.caption
            ),
            Tables.rowItemLight(
              title: 'Alternative Text',
              value: media.alternativeText
            ),
            Tables.rowItemLight(
              title: 'Provider',
              value: media.provider
            ),
            Tables.rowItemLight(
              title: 'Preview URL',
              value: media.previewUrl
            ),
            Tables.rowItemLight(
              title: 'URL',
              value: media.url
            ),
            Tables.rowItemLight(
              title: 'File Hash',
              value: media.hash
            ),
          ],
        ),
      ),
    );
  }

  Widget get _pageIndicator => Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(offset: Offset(0, 3), spreadRadius: 0, blurRadius: 4, color: Colors.black45)]
    ),
    child: Text(
      '${_index+1} of ${widget.images.length}',
      style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey.shade100),
      textAlign: TextAlign.center,
    ),
  );

  Widget get _navIndicator => Positioned(
    bottom: 40,
    left: 40,
    right: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _extensionIndicator,
        _pageIndicator,
      ],
    ),
  );

  Widget get _viewer => Center(
    child: PhotoViewGallery.builder(
      itemCount: widget.images.length,
      scrollDirection: Axis.horizontal,
      pageController: _pageController,
      builder: (_, index) {
        MediaFile image = widget.images[index];

        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(
            image.url,
          ),
          filterQuality: FilterQuality.high,
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained * 1,
          maxScale: PhotoViewComputedScale.contained * 2,
          tightMode: false,
          errorBuilder: (_, image, error) => const Center(child: Text('Image Error!')),
        );
      },
      loadingBuilder: (context, event) => Loadings.basicPrimary,
      onPageChanged: (index) {
        _index = index;
        setState(() {});

        if (widget.onPageChanged != null) widget.onPageChanged!(index);
      },
    ),
  );

  /*ImageProvider _networkImage(FileUpload file) {
    return CachedNetworkImageProvider(
      file.url,
    );
  }*/

  /*ImageProvider _localImage(LocalFile file) {
    return Image.file(
      File(file.finalCompressedPath),
      fit: BoxFit.contain,
    ).image;
  }*/

  /*ImageProvider _imageView(dynamic file) {
    return _networkImage(file);
    *//*if (file is FileUpload) {
    } else {
      return _localImage(file);
    }*//*
  }*/
}
