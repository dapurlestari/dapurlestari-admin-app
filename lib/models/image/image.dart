
import '../../env/env.dart';

class Image {
  Image({
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
  });

  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  ImageFormat formats;
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

  factory Image.fromJson(Map<String, dynamic> map) {
    final json = map['attributes'];
    return Image(
      name: json["name"],
      alternativeText: json["alternativeText"] ?? '',
      caption: json["caption"] ?? '',
      width: json["width"],
      height: json["height"],
      formats: ImageFormat.fromJson(json["formats"]),
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

  factory Image.dummy() {
    return Image(
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
    "formats": formats.toJson(),
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