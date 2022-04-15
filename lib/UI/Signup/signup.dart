import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../FirebaseChat/FirebaseModel/database_methods.dart';
import '../../FirebaseChat/Services/auth.dart';
import '../../Network/NetworkHelper.dart';
import '../Extracted Widgets/bluetextfield.dart';
import '../Extracted Widgets/snackbar.dart';
import '../Login/login.dart';
import '../ScrollableAppBar/backappbar.dart';

class SignupPage extends StatefulWidget {
  final toggle;
  final page;
  final isFromProfile;

  SignupPage({this.toggle, this.page, this.isFromProfile});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;
  bool isHiddenPassword = true;
  bool isConfirmHiddenPassword = true;
  bool isChecked = false;
  ConnectivityResult result = ConnectivityResult.none;

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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthMethod authMethod = AuthMethod();
  DatabaseMethods databaseMethods = DatabaseMethods();

  //Calls the api and firebase for sign up
  callApiFirebase() async {
    // pload/Sign up in api
    /* NetworkHelper networkHelper = NetworkHelper();
     RegisterApi? registerApi = await networkHelper.getRegData(name, email, password);
     registerApi*/

    //Register Firebase from here
    var name = nameController.text;
    var password = passwordController.text;
    var email = emailController.text;
    Map<String, String> userInfo = {"name": name, "email": email};
    authMethod.signUpWithEmailAndPassword(email, password).then((value) async {
      if (value != null) {
        await databaseMethods.uploadUserInfo(userInfo); //Upload in database
        NetworkHelper().getRegData(name, email, password);
        showSnackBar(
          context,
          "Success",
          Colors.red,
          Icons.info,
          "Successfully, created an account",
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) =>
                  LoginPage(page: widget.page, isFromProfile: false),
            ),
            (route) => route.isFirst);
      } else {
        showSnackBar(
          context,
          "Attention",
          Colors.red,
          Icons.info,
          "The email has already been taken.",
        );
        setState(() {
          isLoading = false;

        });

      }
    });
  }

  signMeUp() {
    if (_formKey.currentState!.validate()) {
      try {
        callApiFirebase();

        print("sucess");
      } catch (e) {
        print(e);
        print("failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackAppBar(
        Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            reverse: false,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40),
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          /*   height: MediaQuery.of(context).size.height * 0.5,*/
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Register',
                                          style: TextStyle(
                                              fontFamily: 'NutinoSansReg',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff0D5D40)),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Become our member',
                                          style: TextStyle(
                                            fontFamily: 'NutinoSansReg',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff777777),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Hero(
                                      tag: 'logo',
                                      child: Image.asset(
                                        'assets/logo.png',
                                        width: 55,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  height: 32.00,
                                ),
                                BlueTextFormField(
                                  'Username',
                                  'assets/usericon.png',
                                  nameController,
                                  (String? value) {
                                    if (value!.isEmpty) {
                                      return "Please enter username";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                BlueTextFormField(
                                  'Email',
                                  'assets/email.png',
                                  emailController,
                                  (String? value) {
                                    if (value!.isEmpty) {
                                      return "Please enter email";
                                    }
                                    if (!RegExp(
                                            "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                        .hasMatch(value)) {
                                      return "Please enter valid email";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                BlueTextFormFieldPN(
                                  'Phone no.',
                                  'assets/phone.png',
                                  phoneNoController,
                                  (String? value) {
                                    if (value!.isEmpty) {
                                      return "Please enter phone number";
                                    }
                                    if (value.length < 10) {
                                      return "Please enter valid phone number";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
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
                                          width: 1, color: Color(0xff0D5D40)),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xff0D5D40)),
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
                                          width: 1, color: Color(0xff0D5D40)),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    hintText: 'Password',
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
                                        color: Color(0xff0D5D40),
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
                                          color: Color(0xff0D5D40),
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
                                    if (!value.contains(RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                                      return "Your password must contain certain letters eg:(Aa9@)";
                                    }
/*                                    if (!value.contains(RegExp(r"[a-z]"))) {
                                      return "Your password must have a letter";
                                    }
                                    if (!value.contains(RegExp(r"[A-Z]"))) {
                                      return "Your password should contain at least one uppercase letter";
                                    }
                                    if (!value.contains(RegExp(r"[0-9]"))) {
                                      return "Your password should contain a numerical value";
                                    }
                                    if (!value.contains(
                                        RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                      return "Your password should contain one special character";
                                    }*/
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
                                          width: 1, color: Color(0xff0D5D40)),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xff0D5D40)),
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
                                          width: 1, color: Color(0xff0D5D40)),
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
                                        color: Color(0xff0D5D40),
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
                                          color: Color(0xff0D5D40),
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
                                  height: 32.0,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (isLoading) return;
                                    setState(() => isLoading = true);
                                    result = await Connectivity()
                                        .checkConnectivity();
                                    if (result == ConnectivityResult.mobile ||
                                        result == ConnectivityResult.wifi) {
                                      await signMeUp();
                                    } else {
                                      setState(() => isLoading = false);

                                      showSnackBar(
                                        context,
                                        "Attention",
                                        Color(0xff0D5D40),
                                        Icons.info,
                                        "You must be connected to the internet.",
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        color: Color(0xff0D5D40),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: isLoading
                                          ? CircularProgressIndicator.adaptive()
                                          : Text(
                                              'Register',
                                              style: TextStyle(
                                                fontFamily: 'NutinoSansReg',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffFFFFFF),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                /*LoginButton('Sign Up', () async {
                                  result =
                                  await Connectivity().checkConnectivity();
                                  if (result == ConnectivityResult.mobile ||
                                      result == ConnectivityResult.wifi) {
                                    signMeUp(); //Firebase registration
                                  } else {
                                    showSnackBar(
                                      context,
                                      "Attention",
                                      Color(0xff0D5D40),
                                      Icons.info,
                                      "You must be connected to the internet.",
                                    );
                                  }
                                }),*/
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account?  ',
                                      style: TextStyle(
                                        fontFamily: 'NutinoSansReg',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return LoginPage(
                                            page: widget.page,
                                            isFromProfile: false,
                                          );
                                        }));
                                      },
                                      child: Text(
                                        'Log In',
                                        style: TextStyle(
                                            fontFamily: 'NutinoSansReg',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff0D5D40)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Colors.white,
      ),
    );
  }
}
