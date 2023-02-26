import 'package:admin/models/image/media_file.dart';

class Galleryful {
  Galleryful({
    this.id = 0,
    this.title = '',
    this.subtitle = '',
    required this.image,
  });

  int id;
  String title;
  String subtitle;
  MediaFile image;

  factory Galleryful.fromJson(Map<String, dynamic> json) => Galleryful(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    image: json["image"]['data'] == null
        ? MediaFile.dummy()
        : MediaFile.fromJson(json["image"]['data']),
  );

  factory Galleryful.dummy() => Galleryful(
    image: MediaFile.dummy(),
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    "title": title,
    "subtitle": subtitle,
    "image": image.id,
  };

  // String get controllerTag => '$';
}