import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/strapi_response.dart';

class Bundle {
  Bundle({
    this.id = 0,
    this.name = '',
    this.description = '',
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;

  factory Bundle.fromJson(Map<String, dynamic> json, int id) => Bundle(
    id: id,
    name: json["name"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
  );

  factory Bundle.dummy() => Bundle(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    publishedAt: DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    // "createdAt": createdAt.toIso8601String(),
    // "updatedAt": updatedAt.toIso8601String(),
    // "publishedAt": publishedAt.toIso8601String(),
    // "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };

  bool get isNotEmpty => id > 0;

  static Future<List<Bundle>> get({
    int page = 1
  }) async {
    StrapiResponse response = await API.get(
        page: 'bundles',
        paginate: true,
        paginationPage: page,
        populateMode: APIPopulate.all,
        // showLog: true
    );

    if (response.isSuccess) {
      return (response.data as List).map((e)
        => Bundle.fromJson(e[ConstLib.attributes], e[ConstLib.id])).toList();
    }

    return [];
  }

  Future<Bundle> add() async {
    StrapiResponse response = await API.post(
        page: 'bundles',
        data: toJson()
        // showLog: true
    );

    if (response.isSuccess) {
      return Bundle.fromJson(response.data[ConstLib.attributes], response.data[ConstLib.id]);
    }

    return Bundle.dummy();
  }

  Future<Bundle> save() async {
    StrapiResponse response = await API.put(
        page: 'bundles/$id',
        data: toJson()
        // showLog: true
    );

    if (response.isSuccess) {
      return Bundle.fromJson(response.data[ConstLib.attributes], response.data[ConstLib.id]);
    }

    return Bundle.dummy();
  }
}