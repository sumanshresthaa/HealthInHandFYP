// To parse this JSON data, do
//
//     final registerApi = registerApiFromJson(jsonString);

import 'dart:convert';

RegisterApi registerApiFromJson(String str) => RegisterApi.fromJson(json.decode(str));

String registerApiToJson(RegisterApi data) => json.encode(data.toJson());

class RegisterApi {
  RegisterApi({
    this.created,
    this.user,
    this.token,
  });

  bool? created;
  User? user;
  String? token;

  factory RegisterApi.fromJson(Map<String, dynamic> json) => RegisterApi(
    created: json["created"],
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "created": created,
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  User({
    this.name,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? name;
  String? email;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
