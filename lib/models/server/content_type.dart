import 'package:admin/services/api.dart';
import 'package:admin/services/strapi_response.dart';

import 'content_schema.dart';

class ContentType {
  ContentType({
    required this.uid,
    required this.plugin,
    required this.apiId,
    required this.schema,
  });

  String uid;
  String plugin;
  String apiId;
  ContentSchema schema;

  factory ContentType.fromJson(Map<String, dynamic> json) => ContentType(
    uid: json["uid"],
    plugin: json.containsKey("plugin") ? json["plugin"] : '',
    apiId: json["apiID"],
    schema: ContentSchema.fromJson(json["schema"]),
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "plugin": plugin,
    "apiID": apiId,
    "schema": schema.toJson(),
  };

  bool get isPlugin => plugin.isNotEmpty;
  bool get isNotPlugin => !isPlugin;
  bool get isConfig => apiId == 'config';
  bool get isNotConfig => !isConfig;

  static Future<List<ContentType>> get() async {
    StrapiResponse response = await API.get(
        page: 'content-type-builder/content-types',
        populateMode: APIPopulate.all,
        // showLog: true
    );

    // logInfo(response.data, logLabel: 'strapi');
    if (response.isSuccess) {
      return (response.data as List).map((e) {
        ContentType contentType = ContentType.fromJson(e);
        return contentType;
      }).toList();
    }

    return [];
  }
}