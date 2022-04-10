import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/Chatroom/chat_room.dart';
import '../../Textstyle/constraints.dart';
import '../Extracted Widgets/buttons.dart';
import '../Login/login.dart';
import '../ScrollableAppBar/backappbar.dart';
import '../Signup/signup.dart';


//Ask if the user wants to login or signup before taking them to the screen
class LoginPermission extends StatefulWidget {
  LoginPermission({this.page});
  final page;
  @override
  _LoginPermissionState createState() => _LoginPermissionState();
}

class _LoginPermissionState extends State<LoginPermission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleHomeColor,
      body: BackAppBar(
        Scaffold(
          backgroundColor: kStyleHomeColor,
          body: LoginPermissionBody(),
        ),
        kStyleHomeColor,
      ),
    );
  }
}

class LoginPermissionBody extends StatelessWidget {
  const LoginPermissionBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xffF3F7FF)),
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
            child: Column(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/loginpermission.png'),
                        height: 193.42,
                        width: 159.4,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Login First",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'NutinoSansReg',
                          fontWeight: FontWeight.w700,
                            color: Color(0xff0D5D40)
                        ),
                      ),
                      SizedBox(
                        height: 4.00,
                      ),
                      Text(
                        "To get benefits like Booking appointment and chat features you need to login first",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NutinoSansReg',
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45.0, bottom: 12),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 17.0),
                              child: Image(
                                image: AssetImage('assets/checkbox.png'),
                                height: 16,
                                width: 16,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Book an appointment with the Health Care Centers ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'NutinoSansReg',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                  height: 1.5,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45.0, bottom: 12),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 17.0),
                              child: Image(
                                  image: AssetImage('assets/checkbox.png'),
                                  height: 16,
                                  width: 16),
                            ),
                            Text(
                              'Get consulted by professionals.',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'NutinoSansReg',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF333333),
                                height: 1.5,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45.0, bottom: 24),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 17.0),
                              child: Image(
                                  image: AssetImage('assets/checkbox.png'),
                                  height: 16,
                                  width: 16),
                            ),
                            Text(
                              'Get the best solution to your queries.',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'NutinoSansReg',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF333333),
                                height: 1.5,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 40),
                        child: LoginButton('Log in', () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return LoginPage(isFromProfile: false,page: ChatRoom(),);
                              }));
                        }),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      LangButton(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return SignupPage(isFromProfile: false, page: ChatRoom());
                            }));
                      }, 'Sign Up')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

