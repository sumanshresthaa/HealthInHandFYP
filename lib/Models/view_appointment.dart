// To parse this JSON data, do
//
//     final viewAppointment = viewAppointmentFromJson(jsonString);

import 'dart:convert';

ViewAppointment viewAppointmentFromJson(String str) => ViewAppointment.fromJson(json.decode(str));

String viewAppointmentToJson(ViewAppointment data) => json.encode(data.toJson());

class ViewAppointment {
  ViewAppointment({
    this.appointments,
  });

  List<Appointment>? appointments;

  factory ViewAppointment.fromJson(Map<String, dynamic> json) => ViewAppointment(
    appointments: List<Appointment>.from(json["appointments"].map((x) => Appointment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "appointments": List<dynamic>.from(appointments!.map((x) => x.toJson())),
  };
}

class Appointment {
  Appointment({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.phone,
    this.datetime,
    this.doctorName,
    this.hospitalName,
    this.describeProblem,
    this.optional1,
    this.optional2,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? age;
  String? gender;
  String? phone;
  DateTime? datetime;
  String? doctorName;
  String? hospitalName;
  String? describeProblem;
  String? optional1;
  String? optional2;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    name: json["name"],
    age: json["age"],
    gender: json["gender"],
    phone: json["phone"],
    datetime: DateTime.parse(json["datetime"]),
    doctorName: json["doctorName"],
    hospitalName: json["hospitalName"],
    describeProblem: json["describeProblem"],
    optional1: json["optional1"],
    optional2: json["optional2"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "age": age,
    "gender": gender,
    "phone": phone,
    "datetime": datetime?.toIso8601String(),
    "doctorName": doctorName,
    "hospitalName": hospitalName,
    "describeProblem": describeProblem,
    "optional1": optional1,
    "optional2": optional2,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
