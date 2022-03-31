import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Models/get_otp.dart';
import '../../Network/NetworkHelper.dart';
import '../../Textstyle/constraints.dart';
import '../../ViewModel/changenotifier.dart';
import '../BottomNavigations/bottom_navigation_covid.dart';
import '../Extracted Widgets/buttons.dart';
import '../Extracted Widgets/snackbar.dart';
import '../ScrollableAppBar/backappbar.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  late var email =
      Provider.of<DataProvider>(context, listen: false).verifyEmailAddress;

  ConnectivityResult result = ConnectivityResult.none;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(0.0),
    border: Border.all(
      color: const Color(0xFF777777),
    ),
  );

  bool _isResendAgain = false;

  late Timer _timer;
  int _start = 30;
  int _currentIndex = 0;

  void resend() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 30;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  @override
  void initState() {
    Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        if (!mounted) {
          timer.cancel();
        } else {
          setState(() {
            _currentIndex++;
            if (_currentIndex == 3) _currentIndex = 0;
          });
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollAppBarNoRightArrow(
        Scaffold(
          backgroundColor: Color(0xfff3f7ff),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18),
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
                                'assets/forgetpassword.png',
                                width: 189,
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              Text(
                                'Enter the verification code we just send you\non your email address.',
                                textAlign: TextAlign.center,
                                style: kStyleFPassword,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              /*    Center(
                                child: PinPut(
                                  fieldsCount: 4,
                                ),
                              ),*/
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 55.sp),
                                child: PinPut(
                                  fieldsCount: 4,
                                  textStyle: kStyleHContent.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp),
                                  eachFieldWidth: 8.0,
                                  eachFieldHeight: 8.0,
                                  focusNode: _pinPutFocusNode,
                                  controller: _pinPutController,
                                  submittedFieldDecoration: pinPutDecoration,
                                  selectedFieldDecoration: pinPutDecoration,
                                  followingFieldDecoration: pinPutDecoration,
                                  pinAnimationType: PinAnimationType.fade,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Please re enter your password";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "If you didn't receive a code",
                                    style: kStyleHContent.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFA3A3A3),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      result = await Connectivity()
                                          .checkConnectivity();
                                      if (result == ConnectivityResult.mobile ||
                                          result == ConnectivityResult.wifi) {
                                        if (_isResendAgain) return;
                                        resend();
                                        await NetworkHelper()
                                            .getEmailData(email);
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
                                    child: Text(
                                      _isResendAgain
                                          ? "Try again in " + _start.toString()
                                          : "Resend",
                                      style: kStyleHContent.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 34.0),
                                child: LoginButton('Verify', () async {
                                  result =
                                      await Connectivity().checkConnectivity();
                                  if (result == ConnectivityResult.mobile ||
                                      result == ConnectivityResult.wifi) {
                                    if (_formKey.currentState!.validate()) {
                                      final otp = _pinPutController.text;
                                      _pinPutController.clear();
                                      print(otp);
                                      try {
                                        OTPVerification otpData =
                                            await NetworkHelper()
                                                .getOTPData(email, otp);

                                        var error = otpData.error;
                                        if (error == false) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              /*            settings: RouteSettings(name: '/1'),*/
                                              builder: (context) =>
                                                  BottomNavigationCovid(),
                                            ),
                                            ModalRoute.withName('/'),
                                          );
                                        }
                                      } catch (e) {
                                        showSnackBar(
                                          context,
                                          "Attention",
                                          Colors.red,
                                          Icons.info,
                                          "Information did not matched.",
                                        );
                                      }
                                    } else {
                                      showSnackBar(
                                        context,
                                        "Attention",
                                        Colors.red,
                                        Icons.info,
                                        "The field is required.",
                                      );
                                    }
                                  } else
                                    showSnackBar(
                                      context,
                                      "Attention",
                                      Colors.blue,
                                      Icons.info,
                                      "You must be connected to the internet.",
                                    );
                                }),
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
        'Verification',
      ),
    );
  }
}
