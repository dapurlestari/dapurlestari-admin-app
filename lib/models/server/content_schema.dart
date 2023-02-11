class ContentSchema {
  ContentSchema({
    required this.displayName,
    required this.singularName,
    required this.pluralName,
    required this.description,
    required this.draftAndPublish,
    required this.kind,
    required this.collectionName,
  });

  String displayName;
  String singularName;
  String pluralName;
  String description;
  bool draftAndPublish;
  String kind;
  String collectionName;

  factory ContentSchema.fromJson(Map<String, dynamic> json) => ContentSchema(
    displayName: json["displayName"],
    singularName: json["singularName"],
    pluralName: json["pluralName"],
    description: json["description"],
    draftAndPublish: json["draftAndPublish"],
    kind: json["kind"],
    collectionName: json["collectionName"],
  );

  Map<String, dynamic> toJson() => {
    "displayName": displayName,
    "singularName": singularName,
    "pluralName": pluralName,
    "description": description,
    "draftAndPublish": draftAndPublish,
    "kind": kind,
    "collectionName": collectionName,
  };

  bool get isSingleType => kind == 'singleType';
  bool get isCollectionType => kind == 'collectionType';
}