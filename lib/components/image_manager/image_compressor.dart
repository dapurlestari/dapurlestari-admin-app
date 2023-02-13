import 'dart:io';
import 'package:image/image.dart' as imageLib;
import 'package:path/path.dart';

class ImageCompressor {
  static File? resize(File file, {int maxWidth = 500, int quality = 90}) {
    // assume image ratio is 1:1

    imageLib.Image? image = imageLib.decodeImage(file.readAsBytesSync());
    if (image != null) {
      // if image already smaller than maxWidth, do not resize
      if (image.width <= maxWidth) {
        return file;
      }

      imageLib.Image smallerImage = imageLib.copyResize(image, width: maxWidth);
      file = File('${file.parent.path}/${basename(file.path)}')
        ..writeAsBytesSync(imageLib.encodeJpg(smallerImage, quality: quality));
      return file;
    }

    return null;
  }
}