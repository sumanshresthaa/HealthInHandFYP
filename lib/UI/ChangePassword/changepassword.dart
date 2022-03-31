import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../Network/NetworkHelper.dart';
import '../../ViewModel/changenotifier.dart';
import '../Extracted Widgets/buttons.dart';
import '../Extracted Widgets/snackbar.dart';
import '../ScrollableAppBar/backappbar.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

//UI to change password
class _ChangePasswordState extends State<ChangePassword> {
  bool isHiddenPassword = true;
  bool isConfirmHiddenPassword = true;

  //obscure text when the eye button is pressed
  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      isConfirmHiddenPassword = !isConfirmHiddenPassword;
    });
  }

  ConnectivityResult result = ConnectivityResult.none;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollAppBarNoRightArrow(
        Scaffold(
          backgroundColor: Color(0xffF3F7FF),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 109.0, horizontal: 51),
              child: Container(
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/changepassword.png',
                                width: 143,
                              ),
                              SizedBox(
                                height: 50.74,
                              ),
                              TextFormField(
                                controller: passwordController,
                                style: TextStyle(
                                  fontFamily: 'NutinoSansReg',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff777777),
                                ),
                                obscureText: isHiddenPassword,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xff3F84FC),
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xff3F84FC),
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xff3F84FC),
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  hintText: 'Password (Must use Aa9@)',
                                  hintStyle: TextStyle(
                                    fontFamily: 'NutinoSansReg',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff777777),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(8, 16, 0, 0),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 12),
                                    child: Image.asset(
                                      'assets/lock.png',
                                      width: 20,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 17),
                                    child: InkWell(
                                      onTap: _togglePasswordView,
                                      child: Image.asset(
                                        isConfirmHiddenPassword
                                            ? 'assets/eye.png'
                                            : 'assets/eye.png',
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Please enter a password";
                                  }
                                  if (value.length < 8) {
                                    return "Your password must be at least 8 character";
                                  }
                                  if (!value.contains(RegExp(r"[a-z]"))) {
                                    return "Your password must have a letter";
                                  }
                                  if (!value.contains(RegExp(r"[A-Z]"))) {
                                    return "Your password should contain at least one uppercase letter";
                                  }
                                  if (!value.contains(RegExp(r"[0-9]"))) {
                                    return "Your password should contain  a numerical value";
                                  }
                                  if (!value.contains(
                                      RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                    return "Your password should contain one special character";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                controller: confirmPasswordController,
                                style: TextStyle(
                                  fontFamily: 'NutinoSansReg',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff777777),
                                ),
                                obscureText: isConfirmHiddenPassword,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xff3F84FC),
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xff3F84FC),
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xff3F84FC),
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(
                                    fontFamily: 'NutinoSansReg',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff777777),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(8, 16, 0, 0),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 12),
                                    child: Image.asset(
                                      'assets/lock.png',
                                      width: 20,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 17),
                                    child: InkWell(
                                      onTap: _toggleConfirmPasswordView,
                                      child: Image.asset(
                                        isConfirmHiddenPassword
                                            ? 'assets/eye.png'
                                            : 'assets/eye.png',
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Please re enter your password";
                                  }
                                  if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    return "Both the passwords don't match";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              SizedBox(
                                height: 32.0,
                              ),
                              LoginButton(
                                'Submit',
                                () async {
                                  result =
                                      await Connectivity().checkConnectivity();
                                  if (result == ConnectivityResult.mobile ||
                                      result == ConnectivityResult.wifi) {
                                    if (_formKey.currentState!.validate()) {
                                      final password = passwordController.text;
                                      final confirmPassword =
                                          confirmPasswordController.text;
                                      final email = Provider.of<DataProvider>(
                                              context,
                                              listen: false)
                                          .verifyEmailAddress;
                                      await NetworkHelper().getFPasswordData(
                                          email, password, confirmPassword);
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/',
                                              (Route<dynamic> route) => false);
                                    } else {
                                      return print("Unsuccessful");
                                    }
                                  } else {
                                    showSnackBar(
                                      context,
                                      "Attention",
                                      Colors.blue,
                                      Icons.info,
                                      "You must be connected to the internet.",
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        'Change Password',
      ),
    );
  }
}
