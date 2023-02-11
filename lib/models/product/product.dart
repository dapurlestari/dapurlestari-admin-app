import 'package:admin/models/image/image.dart';
import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/strapi_response.dart';

import 'seo.dart';

class Product {

  int id = 0;
  String code = '';
  String name = '';
  String description = '';
  int releaseYear = 0;
  int nett = 0;
  String unit = 'g';
  String pirtNumber = '';
  int price = 0;
  int stock = 0;
  int status = 0;
  String slug;
  String? createdAt;
  String? updatedAt;
  String deletedAt = '';
  int productCategoryId = 0;
  int bundleId = 0;
  List<Image>? images;
  Seo? seo;

  Product({
    this.id = 0,
    this.code = '',
    this.name = '',
    this.description = '',
    this.releaseYear = 0,
    this.nett = 0,
    this.unit = '',
    this.pirtNumber = '',
    this.price = 0,
    this.stock = 0,
    this.status = 0,
    this.slug = '',
    this.createdAt,
    this.updatedAt,
    this.deletedAt = '',
    this.productCategoryId = 0,
    this.bundleId = 0,
    this.images,
    this.seo,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] ?? 0,
    code: json["code"] ?? '',
    name: json["name"] ?? '',
    description: json["description"] ?? '',
    releaseYear: json["release_year"] ?? 2006,
    nett: json["netto"] ?? 0,
    unit: json["unit"] ?? '',
    pirtNumber: json["pirt_number"] ?? '',
    price: json["price"] ?? 0,
    stock: json["stock"] ?? 0,
    status: json["status"] ?? 1,
    slug: json["slug"] ?? '',
    createdAt: json["createdAt"] ?? '',
    updatedAt: json["updatedAt"] ?? '',
    deletedAt: json["deletedAt"] ?? '',
    productCategoryId: json["product_category_id"] ?? 0,
    bundleId: json["bundle_id"] ?? 0,
    images: !json.containsKey('images')
        ? null
        : (json['images']['data'] as List).map((e) => Image.fromJson(e)).toList(),
    seo: !json.containsKey('seo') ? null : json['seo'] == null ? null : Seo.fromJson(json['seo']),
  );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['description'] = description;
    data['release_year'] = releaseYear;
    data['netto'] = nett;
    data['unit'] = unit;
    data['pirt_number'] = pirtNumber;
    data['price'] = price;
    data['stock'] = stock;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['product_category_id'] = productCategoryId;
    data['bundle_id'] = bundleId;
    return data;
  }

  bool get hasImages => images != null;
  String get thumbnail => hasImages ? images!.first.formats.thumbnail.url : '';
  String get image => hasImages ? images!.first.url : '';

  static Future<List<Product>> get() async {
    StrapiResponse response = await API.get(
      page: 'products',
      populateMode: APIPopulate.all,
      showLog: true
    );

    if (response.isSuccess) {
      return (response.data as List).map((e) {
        logInfo(e, logLabel: 'data');
        int id = e[ConstLib.id];
        Product product = Product.fromJson(e[ConstLib.attributes]);
        product.id = id;
        return product;
      }).toList();
    }

    return [Product()];
  }
}
