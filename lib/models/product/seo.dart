class Seo {
  Seo({
    required this.id,
    required this.metaTitle,
    required this.metaDescription,
    required this.keywords,
    this.metaRobots,
    this.structuredData,
    this.metaViewport,
    required this.canonicalUrl,
  });

  int id;
  String metaTitle;
  String metaDescription;
  String keywords;
  dynamic metaRobots;
  dynamic structuredData;
  dynamic metaViewport;
  String canonicalUrl;

  factory Seo.fromJson(Map<String, dynamic> json) => Seo(
    id: json["id"] ?? 0,
    metaTitle: json["metaTitle"] ?? '',
    metaDescription: json["metaDescription"] ?? '',
    keywords: json["keywords"] ?? '',
    metaRobots: json["metaRobots"],
    structuredData: json["structuredData"],
    metaViewport: json["metaViewport"],
    canonicalUrl: json["canonicalURL"] ?? '',
  );

  factory Seo.defaultSEO() => Seo(
    id: 0,
    metaTitle: 'Dapur Lestari',
    metaDescription: 'Dapur Lestari merupakan produsen kue kering',
    keywords: 'cookies, cakes, pastry',
    canonicalUrl: 'https://dapurlestari.id',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "metaTitle": metaTitle,
    "metaDescription": metaDescription,
    "keywords": keywords,
    "metaRobots": metaRobots,
    "structuredData": structuredData,
    "metaViewport": metaViewport,
    "canonicalURL": canonicalUrl,
  };
}