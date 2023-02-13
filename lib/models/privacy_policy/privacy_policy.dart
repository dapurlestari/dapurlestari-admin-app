import 'package:admin/models/components/contentful.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/strapi_response.dart';

class PrivacyPolicy {
  PrivacyPolicy({
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.contentful,
    required this.seo,
  });

  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;
  Contentful contentful;
  Seo seo;

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => PrivacyPolicy(
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
    contentful: Contentful.fromJson(json["contentful"]),
    seo: json["seo"] == null ? Seo.dummy() : Seo.fromJson(json["seo"]),
  );

  factory PrivacyPolicy.dummy() => PrivacyPolicy(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    publishedAt: DateTime.now(),
    contentful: Contentful.dummy(),
    seo: Seo.dummy(),
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "publishedAt": publishedAt.toIso8601String(),
    "contentful": contentful.toJson(),
    "seo": seo.toJson(),
  };

  static Future<PrivacyPolicy> get() async {
    StrapiResponse response = await API.get(
      page: ConstLib.privacyPolicyPage,
      populateMode: APIPopulate.all,
      // showLog: true
    );

    if (response.isSuccess) {
      return PrivacyPolicy.fromJson(response.data[ConstLib.attributes]);
    }

    return PrivacyPolicy.dummy();
  }
}