import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Models/get_changepassword.dart';
import '../Models/get_email.dart';
import '../Models/get_login.dart';
import '../Models/get_logut.dart';
import '../Models/get_otp.dart';
import '../Models/get_register.dart';


//Mostly offline api. API LOGIN AND REGISTER. No use right now
class NetworkHelper {


  //Very important method called by all the methods in api cache manager class 'api_links.dart'. Return the json Response
  Future<dynamic> getData(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        /*'Bearer 6033fee8-fd94-11eb-9a03-0242ac130003'*/
      });
      if (response.statusCode == 200) {
        var data = response.body;

        return data;
      }
    } catch (Exception) {}
  }


//Post request for registration. Sign up
  Future<Register>? getRegData(
    String name,
    String email,
    String phoneNo,
    String password,
    String confirmPassword,
  ) async {
    var registerModel;
    http.Response response = await http.post(
      Uri.parse('http://103.109.230.18/api/register'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'phone_no': phoneNo,
        'password': password,
        'confirm_password': confirmPassword,
      }),
    );
    if (response.statusCode == 200) {
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("Register: $jsonMap");
      registerModel = Register.fromJson(jsonMap);
    }
    return registerModel;
  }

  // Login Network Helper (offline)
  Future<Login> getLoginData(
    String email,
    String password,
  ) async {
    var loginModel;
    var lastFinalLoginModel;
    http.Response response = await http.post(
      Uri.parse('http://103.109.230.18/api/login'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: jsonEncode(<dynamic, dynamic>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("login: $jsonMap");
      loginModel = Login.fromJson(jsonMap);
    }
    return loginModel;
  }

  //Forget password post request
  Future<ForgetPassword> getEmailData(
    String email,
  ) async {
    var getEmailModel;
    http.Response response = await http.post(
      Uri.parse('http://103.109.230.18/api/forgot-password'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: jsonEncode(
        <dynamic, dynamic>{
          'email': email,
        },
      ),
    );
    if (response.statusCode == 200) {
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("getemail: $jsonMap");
      getEmailModel = ForgetPassword.fromJson(jsonMap);
    }
    return getEmailModel;
  }

  //Change Password api post
  Future<ChangePassword> getFPasswordData(
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    var getForgetPasswordModel;
    http.Response response = await http.post(
      Uri.parse('http://103.109.230.18/api/update-password'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: jsonEncode(
        <dynamic, dynamic>{
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("getForgetPasswordModel: $jsonMap");
      getForgetPasswordModel = ChangePassword.fromJson(jsonMap);
    }
    return getForgetPasswordModel;
  }

//Get the otp from mail (FAKE MAIL)
  Future<OTPVerification> getOTPData(
    String email,
    String otp,
  ) async {
    var getOTPModel;
    http.Response response = await http.post(
      Uri.parse('http://103.109.230.18/api/verify-code'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: jsonEncode(
        <dynamic, dynamic>{
          'email': email,
          'otp_code': otp,
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("getOTPModel: $jsonMap");
      getOTPModel = OTPVerification.fromJson(jsonMap);
    }
    return getOTPModel;
  }

//Logout post request
  Future<LogoutData?> getLogoutData(String url, var token) async {
    var logoutModel;

    try {
      http.Response response = await http
          .post(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = response.body;

        var jsonMap = jsonDecode(data);
        logoutModel = LogoutData.fromJson(jsonMap);
        print(logoutModel);
      }
      return logoutModel;
    } catch (e) {
      print(e);
    }
  }


}
