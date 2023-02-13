import 'package:admin/models/components/contentful.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/strapi_response.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TermsService {
  TermsService({
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

  factory TermsService.fromJson(Map<String, dynamic> json) => TermsService(
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
    contentful: Contentful.fromJson(json["contentful"]),
    seo: json["seo"] == null ? Seo.dummy() : Seo.fromJson(json["seo"]),
  );

  factory TermsService.dummy() => TermsService(
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

  static Future<TermsService> get() async {
    StrapiResponse response = await API.get(
      page: ConstLib.termsServicePage,
      populateMode: APIPopulate.deep,
      // showLog: true
    );

    if (response.isSuccess) {
      return TermsService.fromJson(response.data[ConstLib.attributes]);
    }

    return TermsService.dummy();
  }

  Future<TermsService> save() async {
    StrapiResponse response = await API.put(
      page: ConstLib.termsServicePage,
      data: toJson(),
      populateMode: APIPopulate.deep,
      // showLog: true
    );

    if (response.isSuccess) {
      Fluttertoast.showToast(msg: 'Terms od Services Updated!');
      return TermsService.fromJson(response.data[ConstLib.attributes]);
    }

    return TermsService.dummy();
  }
}