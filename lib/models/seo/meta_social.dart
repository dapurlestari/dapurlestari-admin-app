class MetaSocial {
  MetaSocial({
    this.id = 0,
    this.socialNetwork = '',
    this.title = '',
    this.description = '',
  });

  int id;
  String socialNetwork;
  String title;
  String description;

  factory MetaSocial.fromJson(Map<String, dynamic> json) => MetaSocial(
    id: json["id"],
    socialNetwork: json["socialNetwork"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "socialNetwork": socialNetwork,
    "title": title,
    "description": description,
  };
}