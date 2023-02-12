class MapMarker {
  MapMarker({
    this.id = 0,
    this.label = '',
    this.description = '',
    this.latitude = 0,
    this.longitude = 0,
    this.clickable = false,
    this.draggable = false,
  });

  int id;
  String label;
  String description;
  double latitude;
  double longitude;
  bool clickable;
  bool draggable;

  factory MapMarker.fromJson(Map<String, dynamic> json) => MapMarker(
    id: json["id"],
    label: json["label"],
    description: json["description"] ?? '',
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    clickable: json["clickable"],
    draggable: json["draggable"],
  );

  factory MapMarker.dummy() => MapMarker();

  Map<String, dynamic> toJson() => {
    // "id": id,
    "label": label,
    "description": description,
    "latitude": latitude,
    "longitude": longitude,
    "clickable": clickable,
    "draggable": draggable,
  };
}