import 'dart:io';
import 'package:image/image.dart' as image_lib;
import 'package:path/path.dart';

class ImageCompressor {
  static File? resize(File file, {int maxWidth = 500, int quality = 90}) {
    // assume image ratio is 1:1

    image_lib.Image? image = image_lib.decodeImage(file.readAsBytesSync());
    if (image != null) {
      // if image already smaller than maxWidth, do not resize
      if (image.width <= maxWidth) {
        return file;
      }

      image_lib.Image smallerImage = image_lib.copyResize(image, width: maxWidth);
      file = File('${file.parent.path}/${basename(file.path)}')
        ..writeAsBytesSync(image_lib.encodeJpg(smallerImage, quality: quality));
      return file;
    }

    return null;
  }
}