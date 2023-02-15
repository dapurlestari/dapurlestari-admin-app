import 'package:admin/models/product/product.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/strapi_response.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Category {
  Category({
    this.id = 0,
    this.name = '',
    this.iconName = '',
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.seo,
  });

  int id;
  String name;
  String iconName;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;
  Seo seo;

  factory Category.fromJson(Map<String, dynamic> json, int id) => Category(
    id: id,
    name: json["name"],
    iconName: json["icon_name"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
    seo: json["seo"] != null ? Seo.fromJson(json["seo"]) : Seo.dummy(),
  );

  factory Category.dummy() => Category(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    publishedAt: DateTime.now(),
    seo: Seo.dummy(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icon_name": iconName,
    // "createdAt": createdAt.toIso8601String(),
    // "updatedAt": updatedAt.toIso8601String(),
    // "publishedAt": publishedAt.toIso8601String(),
    // "seo": seo.toJson(),
  };

  bool get isNotEmpty => id > 0;

  static Future<List<Category>> get({
    int page = 1
  }) async {
    StrapiResponse response = await API.get(
        page: 'categories',
        paginate: true,
        paginationPage: page,
        populateMode: APIPopulate.all,
        // showLog: true
    );

    if (response.isSuccess) {
      return (response.data as List).map((e)
      => Category.fromJson(e[ConstLib.attributes], e[ConstLib.id])).toList();
    }

    return [];
  }

  Future<Category> add() async {
    StrapiResponse response = await API.post(
        page: 'categories',
        data: toJson()
      // showLog: true
    );

    if (response.isSuccess) {
      Fluttertoast.showToast(msg: 'Success add category');
      return Category.fromJson(response.data[ConstLib.attributes], response.data[ConstLib.id]);
    }

    return Category.dummy();
  }

  Future<Category> save() async {
    StrapiResponse response = await API.put(
        page: 'categories/$id',
        data: toJson()
      // showLog: true
    );

    if (response.isSuccess) {
      Fluttertoast.showToast(msg: 'Success edit category');
      return Category.fromJson(response.data[ConstLib.attributes], response.data[ConstLib.id]);
    }

    return Category.dummy();
  }
}