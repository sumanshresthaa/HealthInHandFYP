// To parse this JSON data, do
//
//     final detailsOfArthritis = detailsOfArthritisFromJson(jsonString);

import 'dart:convert';

DetailsOfArthritis detailsOfArthritisFromJson(String str) => DetailsOfArthritis.fromJson(json.decode(str));

String detailsOfArthritisToJson(DetailsOfArthritis data) => json.encode(data.toJson());

class DetailsOfArthritis {
  DetailsOfArthritis({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory DetailsOfArthritis.fromJson(Map<String, dynamic> json) => DetailsOfArthritis(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.arthritisDetails,
  });

  List<ArthritisDetail>? arthritisDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    arthritisDetails: List<ArthritisDetail>.from(json["arthritis_details"].map((x) => ArthritisDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "arthritis_details": List<dynamic>.from(arthritisDetails!.map((x) => x.toJson())),
  };
}

class ArthritisDetail {
  ArthritisDetail({
    this.id,
    this.name,
    this.nameNe,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.children,
  });

  int? id;
  String? name;
  String? nameNe;
  int? parentId;
  dynamic createdAt;
  dynamic updatedAt;
  List<ArthritisDetail>? children;

  factory ArthritisDetail.fromJson(Map<String, dynamic> json) => ArthritisDetail(
    id: json["id"],
    name: json["name"],
    nameNe: json["name_ne"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    children: json["children"] == null ? null : List<ArthritisDetail>.from(json["children"].map((x) => ArthritisDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ne": nameNe,
    "parent_id": parentId == null ? null : parentId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "children": children == null ? null : List<dynamic>.from(children!.map((x) => x.toJson())),
  };
}
