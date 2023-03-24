import 'package:admin/models/components/galleryful.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/strapi_response.dart';

class HomePage {
  HomePage({
    this.description = '',
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.slideshows,
    required this.seo,
  });

  String description;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;
  List<Galleryful> slideshows;
  Seo seo;

  factory HomePage.fromJson(Map<String, dynamic> json) => HomePage(
    description: json["description"] ?? '',
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
    slideshows: json['slideshows'] == null
        ? [Galleryful.dummy()]
        : (json['slideshows'] as List).map((e)
    => Galleryful.fromJson(e)).toList(),
    seo: Seo.fromJson(json["seo"]),
  );

  factory HomePage.dummy() => HomePage(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    publishedAt: DateTime.now(),
    slideshows: [Galleryful.dummy()],
    seo: Seo.dummy(),
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    // "createdAt": createdAt.toIso8601String(),
    // "updatedAt": updatedAt.toIso8601String(),
    // "publishedAt": publishedAt.toIso8601String(),
    "seo": seo.toJson(),
    "slideshows": List<dynamic>.from(slideshows.map((x) => x.toJson())),
  };

  static Future<HomePage> get() async {
    StrapiResponse response = await API.get(
      page: ConstLib.homePage,
      populateMode: APIPopulate.custom,
      populateList: [
        'slideshows.image',
        'seo.metaImage',
        'seo.metaSocial.image'
      ],
      // showLog: true
    );

    if (response.isSuccess) {
      return HomePage.fromJson(
          response.data[ConstLib.attributes],
      );
    }

    return HomePage.dummy();
  }

  Future<HomePage> save() async {
    StrapiResponse response = await API.put(
      page: ConstLib.homePage,
      data: toJson(),
      populateMode: APIPopulate.custom,
      populateList: [
        'slideshows.image',
        'seo.metaImage',
        'seo.metaSocial.image'
      ],
      showLog: true
    );

    if (response.isSuccess) {
      return HomePage.fromJson(
          response.data[ConstLib.attributes],
      );
    }

    return HomePage.dummy();
  }
}