import 'package:admin/models/components/contentful.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/strapi_response.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    "contentful": contentful.toJson(),
    "seo": seo.toJson(),
  };

  static Future<PrivacyPolicy> get() async {
    StrapiResponse response = await API.get(
      page: ConstLib.privacyPolicyPage,
      populateMode: APIPopulate.deep,
      // showLog: true
    );

    if (response.isSuccess) {
      return PrivacyPolicy.fromJson(response.data[ConstLib.attributes]);
    }

    return PrivacyPolicy.dummy();
  }

  Future<PrivacyPolicy> save() async {
    StrapiResponse response = await API.put(
      page: ConstLib.privacyPolicyPage,
      data: toJson(),
      populateMode: APIPopulate.deep,
      // showLog: true
    );

    if (response.isSuccess) {
      return PrivacyPolicy.fromJson(response.data[ConstLib.attributes]);
    }

    return PrivacyPolicy.dummy();
  }
}