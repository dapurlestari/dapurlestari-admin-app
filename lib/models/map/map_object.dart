import 'map_marker.dart';

class MapObject {
  MapObject({
    this.id = 0,
    this.zoom = 0,
    this.draggable = false,
    this.scaleControl = false,
    this.streetViewControl = false,
    this.rotateControl = false,
    this.fullscreenControl = false,
    this.zoomControl = false,
    this.mapTypeControl = false,
    this.placeholderImageUrl,
    required this.markers,
  });

  int id;
  int zoom;
  bool draggable;
  bool scaleControl;
  bool streetViewControl;
  bool rotateControl;
  bool fullscreenControl;
  bool zoomControl;
  bool mapTypeControl;
  dynamic placeholderImageUrl;
  List<MapMarker> markers;

  factory MapObject.fromJson(Map<String, dynamic> json) => MapObject(
    id: json["id"],
    zoom: json["zoom"],
    draggable: json["draggable"],
    scaleControl: json["scaleControl"],
    streetViewControl: json["streetViewControl"],
    rotateControl: json["rotateControl"],
    fullscreenControl: json["fullscreenControl"],
    zoomControl: json["zoomControl"],
    mapTypeControl: json["mapTypeControl"],
    placeholderImageUrl: json["placeholder_image_url"] ?? '',
    markers: List<MapMarker>.from(json["markers"].map((x) => MapMarker.fromJson(x))),
  );

  factory MapObject.dummy() => MapObject(
    markers: [MapMarker.dummy()],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "zoom": zoom,
    "draggable": draggable,
    "scaleControl": scaleControl,
    "streetViewControl": streetViewControl,
    "rotateControl": rotateControl,
    "fullscreenControl": fullscreenControl,
    "zoomControl": zoomControl,
    "mapTypeControl": mapTypeControl,
    "placeholder_image_url": placeholderImageUrl,
    "markers": List<dynamic>.from(markers.map((x) => x.toJson())),
  };
}