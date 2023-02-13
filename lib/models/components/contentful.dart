import 'package:admin/models/image/media_file.dart';

class Contentful {
  Contentful({
    this.id = 0,
    this.title = '',
    this.subtitle = '',
    this.content = '',
    required this.featuredImage,
  });

  int id;
  String title;
  String subtitle;
  String content;
  MediaFile featuredImage;

  factory Contentful.fromJson(Map<String, dynamic> json) => Contentful(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    content: json["content"],
    featuredImage: json["featured_image"]['data'] == null
        ? MediaFile.dummy()
        : MediaFile.fromJson(json["featured_image"]['data']),
  );

  factory Contentful.dummy() => Contentful(
    featuredImage: MediaFile.dummy(),
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    "title": title,
    "subtitle": subtitle,
    "content": content,
    "featured_image": featuredImage.id,
  };

  // String get controllerTag => '$';
}