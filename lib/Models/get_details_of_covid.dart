// To parse this JSON data, do
//
//     final detailsOfCovid = detailsOfCovidFromJson(jsonString);

import 'dart:convert';

DetailsOfCovid detailsOfCovidFromJson(String str) => DetailsOfCovid.fromJson(json.decode(str));

String detailsOfCovidToJson(DetailsOfCovid data) => json.encode(data.toJson());

class DetailsOfCovid {
  DetailsOfCovid({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory DetailsOfCovid.fromJson(Map<String, dynamic> json) => DetailsOfCovid(
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
    this.covidDetails,
  });

  List<CovidDetail>? covidDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    covidDetails: List<CovidDetail>.from(json["covid_details"].map((x) => CovidDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "covid_details": List<dynamic>.from(covidDetails!.map((x) => x.toJson())),
  };
}

class CovidDetail {
  CovidDetail({
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
  List<CovidDetail>? children;

  factory CovidDetail.fromJson(Map<String, dynamic> json) => CovidDetail(
    id: json["id"],
    name: json["name"],
    nameNe: json["name_ne"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    children: json["children"] == null ? null : List<CovidDetail>.from(json["children"].map((x) => CovidDetail.fromJson(x))),
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
