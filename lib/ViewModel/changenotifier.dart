import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider extends ChangeNotifier {
  late bool data;
  late bool language;
  late var newValue;
  late var tokenValue;
  late var cpName;
  late var postValue;
  late var emailAddress;
  late var contact;
  late var verifyEmailAddress;
  late var emailValue;
  late var phoneNumValue;
   var purposes;
   var personName;

  //Initial data is true which is english. If the data is already in shared preference then
  //it will choose accordingly
  DataProvider() {
    data = true;
    loadFromPrefs();
    loadPurposeFromPrefs();
  }

  loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.getBool('languageData')!;
    notifyListeners();
  }

  loadPurposeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    purposes = prefs.getBool('choosePreference')!;
    notifyListeners();
  }

  void changeString(bool newString) async {
    data = newString;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getBool('chooseLanguage')!;
    print(language);
    notifyListeners();
  }

  void futureBuilderValue(var value) {
    newValue = value;
    notifyListeners();
  }

  void token(var token) {
    tokenValue = token;
    print("tokenvalue: $tokenValue");
    notifyListeners();
  }

  void email(var email) {
    emailValue = email;
    print("emailValue: $emailValue");
    notifyListeners();
  }

  void phoneNum(var phoneNum) {
    phoneNumValue = phoneNum;
    print("phoneNumValue: $phoneNumValue");
    notifyListeners();
  }

  void createPostName(var name) {
    cpName = name;
    print("cpName: $cpName");
    notifyListeners();
  }

  void createProfile(var email, var phone) {
    emailAddress = email;
    contact = phone;
    notifyListeners();
  }

  void emailForVerify(var verifyEmail) {
    print(verifyEmail);
    verifyEmailAddress = verifyEmail;

    notifyListeners();
  }

  void postId(var postId) {
    postValue = postId;
    print("postValue: $postValue");
    notifyListeners();
  }

  void purpose(var selectPurpose) async{
    purposes = selectPurpose;
    loadPurposeFromPrefs();

  }

  void personNames(var personName) {
    this.personName = personName;
    notifyListeners();
  }


}
