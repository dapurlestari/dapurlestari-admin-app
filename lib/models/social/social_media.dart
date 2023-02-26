import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/strapi_response.dart';

class SocialMedia {
  SocialMedia({
    this.id = 0,
    this.name = '',
    this.icon = '',
    this.link = '',
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  int id;
  String name;
  String icon;
  String link;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;

  factory SocialMedia.fromJson(Map<String, dynamic> json, int id) => SocialMedia(
    id: id,
    name: json["name"],
    icon: json["icon"],
    link: json["link"],
    active: json["active"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
  );

  factory SocialMedia.dummy() => SocialMedia(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    publishedAt: DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icon": icon,
    "link": link,
    "active": active,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "publishedAt": publishedAt.toIso8601String(),
  };

  static Future<List<SocialMedia>> get({
    int page = 1
  }) async {
    StrapiResponse response = await API.get(
      page: 'social-medias',
      paginate: true,
      paginationPage: page,
      populateMode: APIPopulate.all,
      // showLog: true
    );

    if (response.isSuccess) {
      return (response.data as List).map((e)
      => SocialMedia.fromJson(e[ConstLib.attributes], e[ConstLib.id])).toList();
    }

    return [];
  }
}