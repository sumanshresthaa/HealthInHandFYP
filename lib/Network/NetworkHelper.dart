import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Models/create_appointment.dart';
import '../Models/get_changepassword.dart';
import '../Models/get_email.dart';
import '../Models/get_login.dart';
import '../Models/get_logut.dart';
import '../Models/get_otp.dart';
import '../Models/get_register.dart';
import '../Models/registerapi.dart';


//Mostly offline api. API LOGIN AND REGISTER. No use right now
class NetworkHelper {

  // 'http://192.168.254.15/cms/public'; //College
//office:  10.3.5.145
  // home: 192.168.254.15
  var baseUrl = 'http://10.3.5.145/cms/public';

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
  Future<RegisterApi>? getRegData(
    String name,
    String email,
    String password,
  ) async {
    var registerModel;
    http.Response response = await http.post(
      Uri.parse('$baseUrl/api/register'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    print(response.body);
    print("not ok");

    if (response.statusCode == 200) {
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("Register: $jsonMap");
      registerModel = RegisterApi.fromJson(jsonMap);
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
      Uri.parse('$baseUrl/api/login'),
      headers: {HttpHeaders.contentTypeHeader: "application/json",},
      body: jsonEncode(<dynamic, dynamic>{
        'email': email,
        'password': password,
      }),
    );
    print(response.body);
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
      headers: {HttpHeaders.contentTypeHeader: "application/json", },
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


  /*Future<CreateAppointment>? createAppointment(
      String name,
      String age,
      String gender,
      String phone,
      String datetime,
      String doctorName,
      String hospitalName,
      String describeProblem,
      String optional1,
      var token,
      ) async {
    var createModel;
    http.Response response = await http.post(
      Uri.parse('$baseUrl/fypapi/public/api/appointment/add'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'age': age,
        'gender': gender,
        'phone': phone,
        'datetime': datetime,
        'doctorName': doctorName,
        'hospitalName': hospitalName,
        'describeProblem': describeProblem,
        'optional1': optional1,
      }),
    );
    print(response.statusCode);
    print("not ok");

    if (response.statusCode == 200) {
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("Register: $jsonMap");
      createModel = CreateAppointment.fromJson(jsonMap);
    }
    return createModel;
  }
*/


  //Post request for appointment.
  Future<CreateAppointment>? createAppointment(
      String name,
      String age,
      String gender,
      String datetime,
      String doctorName,
      String hospitalName,
      String describeProblem,
      String phone,
      String optional1,
      String optional2,
      var token,

      ) async {
    print( name + age + gender +datetime+doctorName+hospitalName+describeProblem+phone+optional1+optional2+token);
    var createModel;
    http.Response response = await http.post(
      Uri.parse('$baseUrl/api/createAppointment'),

      headers: { HttpHeaders.contentTypeHeader: "application/json", 'Authorization': 'Bearer $token'},
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'age': age,
        'gender': gender,
        'datetime': datetime,
        'doctorName': doctorName,
        'hospitalName': hospitalName,
        'describeProblem': describeProblem,
        'phone': phone,
        'optional1': optional1,
        'optional2': optional2,
      }),
    );
    print(response.statusCode);
    print("not ok");

    if (response.statusCode == 200) {
      var data = response.body;
      var jsonMap = jsonDecode(data);
      print("Register: $jsonMap");
      createModel = CreateAppointment.fromJson(jsonMap);
    }
    return createModel;
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
