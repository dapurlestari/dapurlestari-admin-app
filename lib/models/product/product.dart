import 'package:admin/models/image/media_file.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/strapi_response.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Product {

  int id = 0;
  String name = '';
  String description = '';
  String descriptionRich = '';
  int releaseYear = 0;
  int nett = 0;
  String unit = 'g';
  String pirtCode = '';
  int price = 0;
  int discountPrice = 0;
  int stock = 0;
  bool active = false;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;
  String deletedAt = '';
  int productCategoryId = 0;
  int bundleId = 0;
  List<MediaFile>? images;
  Seo? seo;

  Product({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.descriptionRich = '',
    this.releaseYear = 0,
    this.nett = 0,
    this.unit = '',
    this.pirtCode = '',
    this.price = 0,
    this.discountPrice = 0,
    this.stock = 0,
    this.active = false,
    this.slug = '',
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    this.deletedAt = '',
    this.productCategoryId = 0,
    this.bundleId = 0,
    this.images,
    this.seo,
  });

  factory Product.fromJson(Map<String, dynamic> json, int id) => Product(
    id: id,
    name: json["name"] ?? '',
    description: json["description"] ?? '',
    descriptionRich: json["description_rich"] ?? '',
    releaseYear: json["release_year"] ?? 2006,
    nett: json["netto"] ?? 0,
    unit: json["unit"] ?? '',
    pirtCode: json["pirt_code"] ?? '',
    price: json["price"] ?? 0,
    discountPrice: int.tryParse(json["discount_price"].toString()) ?? 0,
    stock: json["stock"] ?? 0,
    active: json["active"] ?? false,
    slug: json["slug"] ?? '',
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
    productCategoryId: json["product_category_id"] ?? 0,
    bundleId: json["bundle_id"] ?? 0,
    images: !json.containsKey('images')
        ? null
        : (json['images']['data'] as List).map((e) => MediaFile.fromJson(e)).toList(),
    seo: !json.containsKey('seo') ? null : json['seo'] == null ? null : Seo.fromJson(json['seo']),
  );

  factory Product.dummy() => Product(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    publishedAt: DateTime.now()
  );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['description_rich'] = descriptionRich;
    data['release_year'] = releaseYear;
    data['netto'] = nett;
    data['unit'] = unit;
    data['pirt_code'] = pirtCode;
    if (price > 0) data['price'] = price;
    if (discountPrice > 0) data['discount_price'] = discountPrice;
    data['stock'] = stock;
    data['active'] = active;
    // data['created_at'] = createdAt.toIso8601String();
    // data['updated_at'] = updatedAt.toIso8601String();
    // data['deleted_at'] = deletedAt.toIso8601String();
    // data['product_category_id'] = productCategoryId;
    // data['bundle_id'] = bundleId;
    return data;
  }

  bool get isNotEmpty => id > 0;
  bool get hasImages => images != null;
  String get thumbnail => hasImages ? images!.first.formats!.thumbnail.url : '';
  String get image => hasImages ? images!.first.url : '';

  static Future<List<Product>> get({
    int page = 1
  }) async {
    StrapiResponse response = await API.get(
      page: 'products',
      paginate: true,
      paginationPage: page,
      // showLog: true
    );

    if (response.isSuccess) {
      return (response.data as List).map((e)
        => Product.fromJson(e[ConstLib.attributes], e[ConstLib.id])
      ).toList();
    }

    return [];
  }

  Future<Product> view() async {
    StrapiResponse response = await API.get(
      page: 'products/$id',
      populateMode: APIPopulate.all,
      // showLog: true
    );

    if (response.isSuccess) {
      return Product.fromJson(response.data[ConstLib.attributes], response.data[ConstLib.id]);
    }

    return Product.dummy();
  }

  Future<Product> add() async {
    StrapiResponse response = await API.post(
      page: 'products',
      data: toJson(),
      // showLog: true
    );

    if (response.isSuccess) {
      Fluttertoast.showToast(msg: 'Success add product');
      return Product.fromJson(response.data[ConstLib.attributes], response.data[ConstLib.id]);
    }

    return Product.dummy();
  }

  Future<Product> save() async {
    // logInfo(toJson(), logLabel: 'product_edit');
    StrapiResponse response = await API.put(
      page: 'products/$id',
      data: toJson(),
      // showLog: true
    );

    if (response.isSuccess) {
      return Product.fromJson(response.data[ConstLib.attributes], response.data[ConstLib.id]);
    }

    return Product.dummy();
  }
}
