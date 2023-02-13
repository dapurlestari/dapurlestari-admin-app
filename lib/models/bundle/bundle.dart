import 'package:admin/models/product/product.dart';
import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/strapi_response.dart';

class Bundle {
  Bundle({
    this.id = 0,
    this.name = '',
    this.description = '',
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.products,
  });

  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;
  List<Product> products;

  factory Bundle.fromJson(Map<String, dynamic> json, int id) => Bundle(
    id: id,
    name: json["name"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
    products: List<Product>.from(json["products"]["data"].map((x) => Product.fromJson(x))),
  );

  factory Bundle.dummy() => Bundle(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    publishedAt: DateTime.now(),
    products: [],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "publishedAt": publishedAt.toIso8601String(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };

  static Future<List<Bundle>> get({
    int page = 1
  }) async {
    StrapiResponse response = await API.get(
        page: 'bundles',
        paginate: true,
        paginationPage: page,
        populateMode: APIPopulate.all,
        showLog: true
    );

    if (response.isSuccess) {
      return (response.data as List).map((e)
        => Bundle.fromJson(e[ConstLib.attributes], e[ConstLib.id])).toList();
    }

    return [];
  }
}