// To parse this JSON data, do
//
//     final hivMedication = hivMedicationFromJson(jsonString);

import 'dart:convert';

HivMedication hivMedicationFromJson(String str) =>
    HivMedication.fromJson(json.decode(str));

String hivMedicationToJson(HivMedication data) => json.encode(data.toJson());

class HivMedication {
  HivMedication({
    this.error,
    this.message,
    this.data,
    this.meta,
  });

  bool? error;
  String? message;
  Data? data;
  List<dynamic>? meta;

  factory HivMedication.fromJson(Map<String, dynamic> json) => HivMedication(
        error: json["error"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data!.toJson(),
        "meta": List<dynamic>.from(meta!.map((x) => x)),
      };
}

class Data {
  Data({
    this.hivMedication,
  });

  List<HivMedicationElement>? hivMedication;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        hivMedication: List<HivMedicationElement>.from(json["hiv_medication"]
            .map((x) => HivMedicationElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hiv_medication":
            List<dynamic>.from(hivMedication!.map((x) => x.toJson())),
      };
}

class HivMedicationElement {
  HivMedicationElement({
    this.id,
    this.componentId,
    this.topicEn,
    this.topicNe,
    this.contentEn,
    this.contentNe,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.effects,
  });

  int? id;
  int? componentId;
  String? topicEn;
  String? topicNe;
  dynamic contentEn;
  dynamic contentNe;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Effect>? effects;

  factory HivMedicationElement.fromJson(Map<String, dynamic> json) =>
      HivMedicationElement(
        id: json["id"],
        componentId: json["component_id"],
        topicEn: json["topic_en"],
        topicNe: json["topic_ne"],
        contentEn: json["content_en"],
        contentNe: json["content_ne"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        effects:
            List<Effect>.from(json["effects"].map((x) => Effect.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "component_id": componentId,
        "topic_en": topicEn,
        "topic_ne": topicNe,
        "content_en": contentEn,
        "content_ne": contentNe,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "effects": List<dynamic>.from(effects!.map((x) => x.toJson())),
      };
}

class Effect {
  Effect({
    this.id,
    this.treatmentId,
    this.contentEn,
    this.contentNe,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? treatmentId;
  String? contentEn;
  String? contentNe;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Effect.fromJson(Map<String, dynamic> json) => Effect(
        id: json["id"],
        treatmentId: json["treatment_id"],
        contentEn: json["content_en"],
        contentNe: json["content_ne"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "treatment_id": treatmentId,
        "content_en": contentEn,
        "content_ne": contentNe,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
