///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
const String _jsonKeyRegisterError = 'error';
const String _jsonKeyRegisterMessage = 'message';
const String _jsonKeyRegisterData = 'data';
const String _jsonKeyRegisterMeta = 'meta';
const String _jsonKeyRegisterDataToken = 'token';
const String _jsonKeyRegisterDataMessage = 'message';
const String _jsonKeyRegisterDataUser = 'user';
const String _jsonKeyRegisterDataUserName = 'name';
const String _jsonKeyRegisterDataUserEmail = 'email';
const String _jsonKeyRegisterDataUserPhoneNo = 'phone_no';
const String _jsonKeyRegisterDataUserUpdatedAt = 'updated_at';
const String _jsonKeyRegisterDataUserCreatedAt = 'created_at';
const String _jsonKeyRegisterDataUserId = 'id';

class RegisterDataUser {
/*
{
  "name": "Avash",
  "email": "avash@gmail.com",
  "phone_no": "982343433",
  "updated_at": "2021-11-29 09:39:52",
  "created_at": "2021-11-29 09:39:52",
  "id": 24
}
*/

  String? name;
  String? email;
  String? phoneNo;
  String? updatedAt;
  String? createdAt;
  int? id;
  Map<String, dynamic> __origJson = {};

  RegisterDataUser({
    this.name,
    this.email,
    this.phoneNo,
    this.updatedAt,
    this.createdAt,
    this.id,
  });
  RegisterDataUser.fromJson(Map<String, dynamic> json) {
    __origJson = json;
    name = json[_jsonKeyRegisterDataUserName]?.toString();
    email = json[_jsonKeyRegisterDataUserEmail]?.toString();
    phoneNo = json[_jsonKeyRegisterDataUserPhoneNo]?.toString();
    updatedAt = json[_jsonKeyRegisterDataUserUpdatedAt]?.toString();
    createdAt = json[_jsonKeyRegisterDataUserCreatedAt]?.toString();
    id = int.tryParse(json[_jsonKeyRegisterDataUserId]?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[_jsonKeyRegisterDataUserName] = name;
    data[_jsonKeyRegisterDataUserEmail] = email;
    data[_jsonKeyRegisterDataUserPhoneNo] = phoneNo;
    data[_jsonKeyRegisterDataUserUpdatedAt] = updatedAt;
    data[_jsonKeyRegisterDataUserCreatedAt] = createdAt;
    data[_jsonKeyRegisterDataUserId] = id;
    return data;
  }

  Map<String, dynamic> origJson() => __origJson;
}

class RegisterData {
/*
{
  "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijg1ZmJlZTdhZjM3NTc1ZGNhNjczNjg0YWVjMTBhMzJlZjk2MzY3Y2EyZjI3M2ZjOGVmNzA5YWQ4YjU1N2M2MmUxZTYxYWIzOGMwOWYyNTk0In0.eyJhdWQiOiI1IiwianRpIjoiODVmYmVlN2FmMzc1NzVkY2E2NzM2ODRhZWMxMGEzMmVmOTYzNjdjYTJmMjczZmM4ZWY3MDlhZDhiNTU3YzYyZTFlNjFhYjM4YzA5ZjI1OTQiLCJpYXQiOjE2MzgxNzg3OTIsIm5iZiI6MTYzODE3ODc5MiwiZXhwIjoxNjY5NzE0NzkyLCJzdWIiOiIyNCIsInNjb3BlcyI6W119.wNKbG_GzQXwApylmw_y_pU3F6muzqwmHPf0C6a6htcVovREcvsyjP8riq5DUghSmjQ9Y3oCjfXKNzO2Gu8wjDYFTcnJJ_SNC0ZW95VTGdbym0T8YATxjHa9PYuwXzBX-Maz5PHf6DSaiN-URbUbQ4ToGV9OwSx4bZQsWzZI7Btxrp_z6EqJknQTDRQENfC0V5KKM2nF8JMaKOfh5qnV83JCcMWUmvDw5d5NIRN7ah4urCklc4hASJGyC0zOmMbUQvRPaD1F8z1RJq_mEEg-ypPkS6h8Szj6REotj5xs5HykY-F390xkkL_zVf4Pdb7uvjNXo56AMcoZuPIVPCiwb5n3-VGeudVsQd3LeaficKrn9ecafYautCAOfzWxI60hBzyBppoSZvuIzfUAAcqmaWdzgi6EV4-WS2PAc9gAXykDapVzmloU-mfuMPrT5LUHRA0Y1GM094lTyJAes60sgIvrahn4wADsY6w44D0S2lMs9mTPB336m1EQKpwIH-qCW7xKN_eQHbxEfU5BWLgabVjK2VdWT8waAKu8Lh3f5hLw93xtwJbUq7h8Sxx1-UhYvyzY8L4vLtaV_NSG2F1uIcC7dZg6cfmufh28lYkCUwCedmV4c0xEsTrOJOXeBqGKb9QEPXOw8mhggjjtLLBr3uznxRMksqgJbb2tw5gzSF4E",
  "message": "Registration successfull..",
  "user": {
    "name": "Avash",
    "email": "avash@gmail.com",
    "phone_no": "982343433",
    "updated_at": "2021-11-29 09:39:52",
    "created_at": "2021-11-29 09:39:52",
    "id": 24
  }
}
*/

  String? token;
  String? message;
  RegisterDataUser? user;
  Map<String, dynamic> __origJson = {};

  RegisterData({
    this.token,
    this.message,
    this.user,
  });
  RegisterData.fromJson(Map<String, dynamic> json) {
    __origJson = json;
    token = json[_jsonKeyRegisterDataToken]?.toString();
    message = json[_jsonKeyRegisterDataMessage]?.toString();
    user = (json[_jsonKeyRegisterDataUser] != null &&
            (json[_jsonKeyRegisterDataUser] is Map))
        ? RegisterDataUser.fromJson(json[_jsonKeyRegisterDataUser])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[_jsonKeyRegisterDataToken] = token;
    data[_jsonKeyRegisterDataMessage] = message;
    if (user != null) {
      data[_jsonKeyRegisterDataUser] = user!.toJson();
    }
    return data;
  }

  Map<String, dynamic> origJson() => __origJson;
}

class Register {
/*
{
  "error": false,
  "message": "list_success",
  "data": {
    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijg1ZmJlZTdhZjM3NTc1ZGNhNjczNjg0YWVjMTBhMzJlZjk2MzY3Y2EyZjI3M2ZjOGVmNzA5YWQ4YjU1N2M2MmUxZTYxYWIzOGMwOWYyNTk0In0.eyJhdWQiOiI1IiwianRpIjoiODVmYmVlN2FmMzc1NzVkY2E2NzM2ODRhZWMxMGEzMmVmOTYzNjdjYTJmMjczZmM4ZWY3MDlhZDhiNTU3YzYyZTFlNjFhYjM4YzA5ZjI1OTQiLCJpYXQiOjE2MzgxNzg3OTIsIm5iZiI6MTYzODE3ODc5MiwiZXhwIjoxNjY5NzE0NzkyLCJzdWIiOiIyNCIsInNjb3BlcyI6W119.wNKbG_GzQXwApylmw_y_pU3F6muzqwmHPf0C6a6htcVovREcvsyjP8riq5DUghSmjQ9Y3oCjfXKNzO2Gu8wjDYFTcnJJ_SNC0ZW95VTGdbym0T8YATxjHa9PYuwXzBX-Maz5PHf6DSaiN-URbUbQ4ToGV9OwSx4bZQsWzZI7Btxrp_z6EqJknQTDRQENfC0V5KKM2nF8JMaKOfh5qnV83JCcMWUmvDw5d5NIRN7ah4urCklc4hASJGyC0zOmMbUQvRPaD1F8z1RJq_mEEg-ypPkS6h8Szj6REotj5xs5HykY-F390xkkL_zVf4Pdb7uvjNXo56AMcoZuPIVPCiwb5n3-VGeudVsQd3LeaficKrn9ecafYautCAOfzWxI60hBzyBppoSZvuIzfUAAcqmaWdzgi6EV4-WS2PAc9gAXykDapVzmloU-mfuMPrT5LUHRA0Y1GM094lTyJAes60sgIvrahn4wADsY6w44D0S2lMs9mTPB336m1EQKpwIH-qCW7xKN_eQHbxEfU5BWLgabVjK2VdWT8waAKu8Lh3f5hLw93xtwJbUq7h8Sxx1-UhYvyzY8L4vLtaV_NSG2F1uIcC7dZg6cfmufh28lYkCUwCedmV4c0xEsTrOJOXeBqGKb9QEPXOw8mhggjjtLLBr3uznxRMksqgJbb2tw5gzSF4E",
    "message": "Registration successfull..",
    "user": {
      "name": "Avash",
      "email": "avash@gmail.com",
      "phone_no": "982343433",
      "updated_at": "2021-11-29 09:39:52",
      "created_at": "2021-11-29 09:39:52",
      "id": 24
    }
  },
  "meta": [
    null
  ]
}
*/

  bool? error;
  String? message;
  RegisterData? data;
  List<Register>? meta;
  Map<String, dynamic> __origJson = {};

  Register({
    this.error,
    this.message,
    this.data,
    this.meta,
  });
  Register.fromJson(Map<String, dynamic> json) {
    __origJson = json;
    error = json[_jsonKeyRegisterError];
    message = json[_jsonKeyRegisterMessage]?.toString();
    data = (json[_jsonKeyRegisterData] != null &&
            (json[_jsonKeyRegisterData] is Map))
        ? RegisterData.fromJson(json[_jsonKeyRegisterData])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[_jsonKeyRegisterError] = error;
    data[_jsonKeyRegisterMessage] = message;
    if (data != null) {
      data[_jsonKeyRegisterData] = this.data!.toJson();
    }
    return data;
  }

  Map<String, dynamic> origJson() => __origJson;
}