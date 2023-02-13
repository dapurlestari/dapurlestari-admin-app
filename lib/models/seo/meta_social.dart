import 'package:admin/models/image/media_file.dart';
import 'package:admin/services/constant_lib.dart';

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

  static List<MetaSocial> defaultSocials({
    required String title,
    required String description,
    required MediaFile mediaFile
  }) {
    return [
      MetaSocial(
        title: title,
        description: description,
        socialNetwork: ConstLib.metaFacebook,
        image: mediaFile
      ),
      MetaSocial(
        title: title,
        description: description,
        socialNetwork: ConstLib.metaTwitter,
        image: mediaFile
      ),
    ];
  }

  Map<String, dynamic> toJson() => {
    // "id": id,
    "socialNetwork": socialNetwork,
    "title": title,
    "description": description,
    "image": image?.id,
  };
}