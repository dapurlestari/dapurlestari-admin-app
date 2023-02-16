import 'package:admin/models/bundle/bundle.dart';
import 'package:admin/models/category/category.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/models/seo/seo.dart';
import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/strapi_response.dart';

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
  Category category;
  Bundle bundle;
  List<MediaFile> images;
  Seo seo;

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
    required this.category,
    required this.bundle,
    required this.images,
    required this.seo,
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
    bundle: Bundle.dummy(),
    category: Category.dummy(),
    seo: Seo.dummy(),
    images: []
  );

  factory Product.fromJsonWithImages(Map<String, dynamic> json, int id) => Product(
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
    bundle: Bundle.dummy(),
    category: Category.dummy(),
    seo: Seo.dummy(),
    images: json['images']['data'] == null
        ? []
        : (json['images']['data'] as List).map((e)
    => MediaFile.fromJson(e)).toList(),
  );

  factory Product.fromJsonDetail(Map<String, dynamic> json, int id) => Product(
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
    category: json["category"]['data'] == null
        ? Category.dummy()
        : Category.fromJson(
          json["category"]["data"]['attributes'],
          json["category"]["data"]['id']
    ),
    bundle: json["bundle"]['data'] == null
        ? Bundle.dummy()
        : Bundle.fromJson(
        json["bundle"]["data"]['attributes'],
        json["bundle"]["data"]['id']
    ),
    images: json['images']['data'] == null ? [] : (json['images']['data'] as List).map((e) => MediaFile.fromJson(e)).toList(),
    seo: json['seo'] == null ? Seo.dummy() : Seo.fromJson(json['seo']),
  );

  factory Product.dummy() => Product(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    publishedAt: DateTime.now(),
    category: Category.dummy(),
    bundle: Bundle.dummy(),
    seo: Seo.dummy(),
    images: []
  );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // data['id'] = id;
    data['slug'] = slug;
    data['name'] = name;
    data['description'] = description;
    data['description_rich'] = descriptionRich;
    data['release_year'] = releaseYear;
    data['netto'] = nett;
    data['unit'] = unit;
    data['pirt_code'] = pirtCode;
    data['price'] = price;
    data['discount_price'] = discountPrice;
    data['stock'] = stock;
    data['active'] = active;
    // data['created_at'] = createdAt.toIso8601String();
    // data['updated_at'] = updatedAt.toIso8601String();
    // data['deleted_at'] = deletedAt.toIso8601String();
    if (images.isNotEmpty) data['images'] = images.map((e) => e.id).toList();
    if (category.id > 0) data['category'] = category.id;
    if (bundle.id > 0) data['bundle'] = bundle.id;
    if (seo.metaTitle.isNotEmpty) data['seo'] = seo.toJson();
    return data;
  }

  bool get isEmpty => id == 0;
  bool get isNotEmpty => id > 0;
  bool get hasImages => images.isNotEmpty;
  String get thumbnail => hasImages
      ? images.first.formats!.thumbnail.url
      : MediaFile.dummyImage();
  String get image => hasImages
      ? images.first.url
      : MediaFile.dummyImage();

  static Future<List<Product>> get({
    int page = 1
  }) async {
    StrapiResponse response = await API.get(
      page: 'products',
      paginate: true,
      paginationPage: page,
      populateMode: APIPopulate.custom,
      populateList: [
        'images'
      ],
      sortList: [
        ConstLib.sortLatest
      ],
      // showLog: true
    );

    if (response.isSuccess) {
      return (response.data as List).map((e)
        => Product.fromJsonWithImages(e[ConstLib.attributes], e[ConstLib.id])
      ).toList();
    }

    return [];
  }

  Future<Product> view() async {
    StrapiResponse response = await API.get(
      page: 'products/$id',
      populateMode: APIPopulate.custom,
      populateList: [
        'bundle',
        'category',
        'images',
        'seo.metaImage',
        'seo.metaSocial.image'
      ],
      // showLog: true
    );

    if (response.isSuccess) {
      return Product.fromJsonDetail(
        response.data[ConstLib.attributes],
        response.data[ConstLib.id]
      );
    }

    return Product.dummy();
  }

  Future<Product> getBySlug() async {
    StrapiResponse response = await API.get(
      page: 'slugify/slugs/product/$slug',
      showLog: true
    );

    if (response.isSuccess) {
      return Product.fromJson(
        response.data[ConstLib.attributes],
        response.data[ConstLib.id]
      );
    }

    return Product.dummy();
  }

  Future<Product> add() async {
    StrapiResponse response = await API.post(
      page: 'products',
      data: toJson(),
      populateMode: APIPopulate.custom,
      populateList: [
        'bundle',
        'category',
        'images',
        'seo.metaImage',
        'seo.metaSocial.image'
      ],
      // showLog: true
    );

    if (response.isSuccess) {
      logInfo(Product.fromJsonWithImages(
          response.data[ConstLib.attributes],
          response.data[ConstLib.id]
      ).toJson(), logLabel: 'product_edit');

      return Product.fromJsonDetail(
        response.data[ConstLib.attributes],
        response.data[ConstLib.id]
      );
    }

    return Product.dummy();
  }

  Future<Product> edit() async {
    // logInfo(toJson(), logLabel: 'product_edit');
    StrapiResponse response = await API.put(
      page: 'products/$id',
      data: toJson(),
      populateMode: APIPopulate.custom,
      populateList: [
        'bundle',
        'category',
        'images',
        'seo.metaImage',
        'seo.metaSocial.image'
      ],
      // showLog: true
    );

    if (response.isSuccess) {
      logInfo(Product.fromJsonWithImages(
          response.data[ConstLib.attributes],
          response.data[ConstLib.id]
      ).toJson(), logLabel: 'product_edit');

      return Product.fromJsonDetail(
        response.data[ConstLib.attributes],
        response.data[ConstLib.id]
      );
    }

    return Product.dummy();
  }
}
