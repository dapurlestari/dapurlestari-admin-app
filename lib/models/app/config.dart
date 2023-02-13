import 'package:admin/models/map/map_object.dart';
import 'package:admin/services/api.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/strapi_response.dart';

import '../seo/seo.dart';

class Config {
  Config({
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    this.address = '',
    this.openingHours = '',
    this.email = '',
    this.phone = '',
    this.copyright = '',
    this.whatsappLink = '',
    this.title = '',
    this.subtitle = '',
    required this.seo,
    required this.map,
  });

  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;
  String address;
  String openingHours;
  String email;
  String phone;
  String copyright;
  String whatsappLink;
  String title;
  String subtitle;
  Seo seo;
  MapObject map;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
    address: json["address"],
    openingHours: json["opening_hours"],
    email: json["email"],
    phone: json["phone"],
    copyright: json["copyright"],
    whatsappLink: json["whatsapp_link"],
    title: json["title"],
    subtitle: json["subtitle"],
    seo: Seo.fromJson(json["seo"]),
    map: MapObject.fromJson(json["map"]),
  );

  factory Config.dummy() => Config(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    publishedAt: DateTime.now(),
    seo: Seo.dummy(),
    map: MapObject.dummy(),
  );

  Map<String, dynamic> toJson() => {
    // "createdAt": createdAt.toIso8601String(),
    // "updatedAt": updatedAt.toIso8601String(),
    // "publishedAt": publishedAt.toIso8601String(),
    "address": address,
    "opening_hours": openingHours,
    "email": email,
    "phone": phone,
    "copyright": copyright,
    "whatsapp_link": whatsappLink,
    "title": title,
    "subtitle": subtitle,
    "seo": seo.toJson(),
    "map": map.toJson(),
  };

  static Future<Config?> get() async {
    StrapiResponse response = await API.get(
        page: 'config',
        populateMode: APIPopulate.custom,
        populateList: [
          'seo.metaSocial',
          'seo.metaSocial.image',
          'seo.metaImage',
          'map.markers',
        ],
        // showLog: true
    );

    if (response.isSuccess) {
      return Config.fromJson(response.data['attributes']);
    }

    return null;
  }

  Future<Config?> save() async {
    StrapiResponse response = await API.put(
        page: 'config',
        data: toJson(),
        populateMode: APIPopulate.custom,
        populateList: [
          'seo.metaSocial',
          'seo.metaSocial.image',
          'seo.metaImage',
          'map.markers'
        ],
        showLog: true
    );

    if (response.isSuccess) {
      return Config.fromJson(response.data['attributes']);
    }

    return null;
  }
}