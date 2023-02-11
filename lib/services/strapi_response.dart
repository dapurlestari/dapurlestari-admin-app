class StrapiResponse {
  final Meta? meta;
  final Error? error;
  final dynamic data;

  StrapiResponse({
    this.meta,
    this.error,
    this.data
  });

  factory StrapiResponse.response(Map<String, dynamic> json) {
    if (json.containsKey('error')) {
      return StrapiResponse.error(json);
    } else if (json.containsKey('meta')) {
      return StrapiResponse.success(json);
    } else if (json.containsKey('data')) {
      return StrapiResponse.successNoMeta(json);
    } else {
      return StrapiResponse();
    }
  }

  factory StrapiResponse.success(Map<String, dynamic> json) => StrapiResponse(
    meta: Meta.fromJson(json["meta"]),
    data: json['data']
  );

  factory StrapiResponse.successNoMeta(Map<String, dynamic> json) => StrapiResponse(
    data: json['data']
  );

  factory StrapiResponse.error(Map<String, dynamic> json) => StrapiResponse(
    meta: Meta.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
  };

  bool get isSuccess => meta != null || data != null;
  bool get isError => !isSuccess;
}

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  int page;
  int pageSize;
  int pageCount;
  int total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: json["page"],
    pageSize: json["pageSize"],
    pageCount: json["pageCount"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "pageSize": pageSize,
    "pageCount": pageCount,
    "total": total,
  };
}

class Error {
  Error({
    required this.status,
    required this.name,
    required this.message,
    required this.details,
  });

  int status;
  String name;
  String message;
  ErrorDetails details;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    status: json["status"],
    name: json["name"],
    message: json["message"],
    details: ErrorDetails.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "name": name,
    "message": message,
    "details": details.toJson(),
  };
}

class ErrorDetails {
  ErrorDetails();

  factory ErrorDetails.fromJson(Map<String, dynamic> json) => ErrorDetails(
  );

  Map<String, dynamic> toJson() => {
  };
}