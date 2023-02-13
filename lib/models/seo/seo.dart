import 'package:admin/models/image/media_file.dart';

import 'meta_social.dart';

class Seo {
  Seo({
    this.id = 0,
    this.metaTitle = '',
    this.metaDescription = '',
    this.keywords = '',
    this.metaRobots = '',
    this.structuredData = '',
    this.metaViewport = '',
    this.canonicalUrl = '',
    this.metaImage,
    required this.metaSocial,
  });

  int id;
  String metaTitle;
  String metaDescription;
  String keywords;
  String metaRobots;
  dynamic structuredData;
  String metaViewport;
  String canonicalUrl;
  MediaFile? metaImage;
  List<MetaSocial> metaSocial;

  factory Seo.fromJson(Map<String, dynamic> json) => Seo(
    id: json["id"],
    metaTitle: json["metaTitle"] ?? '',
    metaDescription: json["metaDescription"] ?? '',
    keywords: json["keywords"] ?? '',
    metaRobots: json["metaRobots"] ?? '',
    structuredData: json["structuredData"],
    metaViewport: json["metaViewport"] ?? '',
    canonicalUrl: json["canonicalURL"] ?? '',
    metaImage: json["metaImage"]["data"] != null ? MediaFile.fromJson(json["metaImage"]["data"]) : null,
    metaSocial: List<MetaSocial>.from(json["metaSocial"].map((x) => MetaSocial.fromJson(x))),
  );

  factory Seo.dummy() => Seo(
    metaImage: MediaFile.dummy(),
    metaSocial: [],
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    "metaTitle": metaTitle,
    "metaDescription": metaDescription,
    "keywords": keywords,
    "metaRobots": metaRobots,
    "structuredData": structuredData,
    "metaViewport": metaViewport,
    "canonicalURL": canonicalUrl,
    "metaImage": metaImage?.id,
    "metaSocial": List<dynamic>.from(metaSocial.map((x) => x.toJson())),
  };
}