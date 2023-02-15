import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/strapi_response.dart';

class Faq {
  Faq({
    this.id = 0,
    this.question = '',
    this.answer = '',
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  int id;
  String question;
  String answer;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;

  factory Faq.fromJson(Map<String, dynamic> json, int id) => Faq(
    id: id,
    question: json["question"] ?? '',
    answer: json["answer"] ?? '',
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
  );

  factory Faq.dummy() => Faq(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    publishedAt: DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "publishedAt": publishedAt.toIso8601String(),
  };

  static Future<List<Faq>> get({
    int page = 1
  }) async {
    StrapiResponse response = await API.get(
      page: 'faqs',
      paginate: true,
      paginationPage: page,
      populateMode: APIPopulate.all,
      // showLog: true
    );

    if (response.isSuccess) {
      return (response.data as List).map((e)
      => Faq.fromJson(e[ConstLib.attributes], e[ConstLib.id])).toList();
    }

    return [];
  }
}