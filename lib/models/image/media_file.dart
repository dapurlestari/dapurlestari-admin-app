
import 'dart:io';

import 'package:admin/services/api.dart';
import 'package:admin/services/logger.dart';
import 'package:admin/services/strapi_response.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart' show MediaType;

import '../../env/env.dart';

class MediaFile {
  MediaFile({
    this.id = 0,
    this.name = '',
    this.alternativeText = '',
    this.caption = '',
    this.width = 0,
    this.height = 0,
    required this.formats,
    this.hash = '',
    this.ext = '',
    this.mime = '',
    this.size = 0,
    this.url = '',
    this.previewUrl,
    required this.provider,
    this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
    this.selected = false
  });

  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  ImageFormat? formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;
  dynamic previewUrl;
  String provider;
  dynamic providerMetadata;
  DateTime createdAt;
  DateTime updatedAt;
  bool selected;

  factory MediaFile.fromJson(Map<String, dynamic> map) {
    int id = map['id'];
    final json = map.containsKey('attributes') ? map['attributes'] : map;
    return MediaFile(
      id: id,
      name: json["name"],
      alternativeText: json["alternativeText"] ?? '',
      caption: json["caption"] ?? '',
      width: json["width"] ?? 0,
      height: json["height"] ?? 0,
      formats: json["formats"] != null ? ImageFormat.fromJson(json["formats"]) : null,
      hash: json["hash"],
      ext: json["ext"],
      mime: json["mime"],
      size: json["size"]?.toDouble(),
      url: '${Env.baseURL}${json["url"]}',
      previewUrl: json["previewUrl"],
      provider: json["provider"],
      providerMetadata: json["provider_metadata"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }

  factory MediaFile.dummy() {
    return MediaFile(
      formats: ImageFormat.dummy(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      provider: '',
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "alternativeText": alternativeText,
    "caption": caption,
    "width": width,
    "height": height,
    "formats": formats?.toJson(),
    "hash": hash,
    "ext": ext,
    "mime": mime,
    "size": size,
    "url": url,
    "previewUrl": previewUrl,
    "provider": provider,
    "provider_metadata": providerMetadata,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };

  String get getAlternativeText => alternativeText.isNotEmpty ? alternativeText : 'No Alternative Text Provided';
  String get mimeExtOnly => mime.split('/')[1].toUpperCase();
  bool get isImage => mime.contains('image');
  bool get hasURL => url.isNotEmpty;

  static Future<List<MediaFile>?> get() async {
    StrapiResponse response = await API.get(
        page: 'upload/files',
        // populateMode: APIPopulate.all,
        // showLog: true
    );

    if (response.isSuccess) {
      return (response.data as List).map((e) => MediaFile.fromJson(e)).toList();
    }

    return null;
  }

  static Future<MediaFile?> upload({
    required File file
  }) async {
    Map<String, dynamic> data = {
      'files': MultipartFile.fromBytes(
        file.readAsBytesSync(),
        filename: basename(file.path),
        contentType: MediaType('image', extension(file.path).replaceAll('.', ''))
      ),
    };
    StrapiResponse response = await API.post(
      page: 'upload',
      files: data,
      encodedData: false,
      // populateMode: APIPopulate.all,
      // showLog: true
    );

    if (response.isSuccess) {
      Fluttertoast.showToast(msg: 'Success upload media!');
      logInfo(response.data, logLabel: 'upload_response');
      return MediaFile.fromJson(response.data[0]); // response is a list
    } else {
      Fluttertoast.showToast(msg: 'Failed upload media!');
    }

    return null;
  }

  static String dummyImage({
    int width = 500,
    int height = 400,
    String extension = 'jpg',
    String text = 'No Image',
  }) {
    return 'https://placehold.co/${width}x$height@2x.$extension?text=$text&font=montserrat';
  }
}

class ImageFormat {
  ImageFormat({
    // required this.small,
    required this.thumbnail,
  });

  // SizeFormat small;
  SizeFormat thumbnail;

  factory ImageFormat.fromJson(Map<String, dynamic> json) => ImageFormat(
    // small: SizeFormat.fromJson(json["small"]),
    thumbnail: SizeFormat.fromJson(json["thumbnail"]),
  );

  factory ImageFormat.dummy() => ImageFormat(
    // small: SizeFormat.fromJson(json["small"]),
    thumbnail: SizeFormat.dummy(),
  );

  Map<String, dynamic> toJson() => {
    // "small": small.toJson(),
    "thumbnail": thumbnail.toJson(),
  };
}

class SizeFormat {
  SizeFormat({
    this.ext = '',
    this.url = '',
    this.hash = '',
    this.mime = '',
    this.name = '',
    this.path = '',
    this.size = 0,
    this.width = 0,
    this.height = 0,
  });

  String ext;
  String url;
  String hash;
  String mime;
  String name;
  String path;
  double size;
  int width;
  int height;

  factory SizeFormat.fromJson(Map<String, dynamic> json) => SizeFormat(
    ext: json["ext"] ?? '',
    url: '${Env.baseURL}${json["url"]}',
    hash: json["hash"] ?? '',
    mime: json["mime"] ?? '',
    name: json["name"] ?? '',
    path: json["path"] ?? '',
    size: json["size"]?.toDouble(),
    width: json["width"] ?? 0,
    height: json["height"] ?? 0,
  );

  factory SizeFormat.dummy() => SizeFormat();

  Map<String, dynamic> toJson() => {
    "ext": ext,
    "url": url,
    "hash": hash,
    "mime": mime,
    "name": name,
    "path": path,
    "size": size,
    "width": width,
    "height": height,
  };
}