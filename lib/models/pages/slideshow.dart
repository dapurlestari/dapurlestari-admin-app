import 'package:admin/models/image/media_file.dart';

class Slideshow {
  Slideshow({
    this.id = 0,
    this.title = '',
    this.subtitle = '',
    required this.image,
  });

  int id;
  String title;
  String subtitle;
  MediaFile image;

  factory Slideshow.fromJson(Map<String, dynamic> json) => Slideshow(
    id: json["id"],
    title: json["title"] ?? '',
    subtitle: json["subtitle"] ?? '',
    image: json["image"] == null || json["image"]["data"] == null ? MediaFile.dummy() : MediaFile.fromJson(json["image"]["data"]),
  );

  factory Slideshow.dummy() => Slideshow(
    image: MediaFile.dummy(),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
    "image": image.toJson(),
  };
}