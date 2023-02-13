import 'dart:io';

import 'package:admin/services/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'image_compressor.dart';

class CustomImageCropper {
  static Future<CroppedFile?> defaultCropper({
    required File file,
    String title = 'Crop Image',
    int compressQuality = 90
  }) async {
    return await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: compressQuality,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        IOSUiSettings(
          title: title,
        ),
        AndroidUiSettings(
          toolbarTitle: title,
          toolbarColor: Colors.indigoAccent,
          activeControlsWidgetColor: Colors.indigoAccent,
          showCropGrid: true,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false
        )
      ],
    );
  }

  static Future<File?> defaultCropperWithCompression({
    required File file,
    String title = 'Crop Image',
    int compressQuality = 100,
    int maxWidth = 500,
  }) async {
    CroppedFile? croppedImage = await defaultCropper(
      file: file,
      title: title,
      compressQuality: compressQuality
    );

    if (croppedImage != null) {
      logInfo(croppedImage.path, logLabel: 'cropped_file_path');
      return ImageCompressor.resize(
        File(croppedImage.path),
        maxWidth: maxWidth,
        quality: compressQuality
      );
    }

    return null;
  }
}