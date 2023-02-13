import 'package:admin/models/image/media_file.dart';

class MetaSocial {
  MetaSocial({
    this.id = 0,
    this.socialNetwork = '',
    this.title = '',
    this.description = '',
    this.image,
  });

  int id;
  String socialNetwork;
  String title;
  String description;
  MediaFile? image;

  factory MetaSocial.fromJson(Map<String, dynamic> json) => MetaSocial(
    id: json["id"],
    socialNetwork: json["socialNetwork"],
    title: json["title"],
    description: json["description"],
    image: json["image"]["data"] != null ? MediaFile.fromJson(json["image"]["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    "socialNetwork": socialNetwork,
    "title": title,
    "description": description,
    "image": image?.id,
  };
}