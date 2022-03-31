// To parse this JSON data, do
//
//     final tbMedication = tbMedicationFromJson(jsonString);

import 'dart:convert';

TbMedication tbMedicationFromJson(String str) => TbMedication.fromJson(json.decode(str));

String tbMedicationToJson(TbMedication data) => json.encode(data.toJson());

class TbMedication {
  TbMedication({
    required this.error,
    required this.message,
    required this.data,
    required this.meta,
  });

  bool error;
  String message;
  Data data;
  List<dynamic> meta;

  factory TbMedication.fromJson(Map<String, dynamic> json) => TbMedication(
    error: json["error"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data.toJson(),
    "meta": List<dynamic>.from(meta.map((x) => x)),
  };
}

class Data {
  Data({
    required this.tbMedication,
  });

  List<TbMedicationElement> tbMedication;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tbMedication: List<TbMedicationElement>.from(json["tb_medication"].map((x) => TbMedicationElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tb_medication": List<dynamic>.from(tbMedication.map((x) => x.toJson())),
  };
}

class MedicationDetail {
  MedicationDetail({
    required this.id,
    this.dose,
    this.doseNe,
    required this.effect,
    required this.effectNe,
    required this.management,
    required this.managementNe,
    required this.status,
    required this.medicationId,
    required this.medicationEffectId,
    required this.componentId,
    this.insertedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.medicationEffect,
  });

  int id;
  dynamic dose;
  dynamic doseNe;
  String effect;
  String effectNe;
  String management;
  String managementNe;
  int status;
  int medicationId;
  int medicationEffectId;
  int componentId;
  dynamic insertedAt;
  DateTime createdAt;
  DateTime updatedAt;
  TbMedicationElement medicationEffect;

  factory MedicationDetail.fromJson(Map<String, dynamic> json) => MedicationDetail(
    id: json["id"],
    dose: json["dose"],
    doseNe: json["dose_ne"],
    effect: json["effect"],
    effectNe: json["effect_ne"],
    management: json["management"],
    managementNe: json["management_ne"],
    status: json["status"],
    medicationId: json["medication_id"],
    medicationEffectId: json["medication_effect_id"],
    componentId: json["component_id"],
    insertedAt: json["inserted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    medicationEffect: TbMedicationElement.fromJson(json["medication_effect"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dose": dose,
    "dose_ne": doseNe,
    "effect": effect,
    "effect_ne": effectNe,
    "management": management,
    "management_ne": managementNe,
    "status": status,
    "medication_id": medicationId,
    "medication_effect_id": medicationEffectId,
    "component_id": componentId,
    "inserted_at": insertedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "medication_effect": medicationEffect.toJson(),
  };
}

class TbMedicationElement {
  TbMedicationElement({
    required this.id,
    required this.name,
    required this.nameNe,
    required this.status,
    required this.componentId,
    required this.insertedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.medicationDetail,
  });

  int id;
  String name;
  String nameNe;
  int status;
  int componentId;
  DateTime? insertedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<MedicationDetail>? medicationDetail;

  factory TbMedicationElement.fromJson(Map<String, dynamic> json) => TbMedicationElement(
    id: json["id"],
    name: json["name"],
    nameNe: json["name_ne"],
    status: json["status"],
    componentId: json["component_id"],
    insertedAt: json["inserted_at"] == null ? null : DateTime.parse(json["inserted_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    medicationDetail: json["medication_detail"] == null ? null : List<MedicationDetail>.from(json["medication_detail"].map((x) => MedicationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ne": nameNe,
    "status": status,
    "component_id": componentId,
    "inserted_at": insertedAt == null ? null : insertedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "medication_detail": medicationDetail == null ? null : List<dynamic>.from(medicationDetail!.map((x) => x.toJson())),
  };
}
