import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../FirebaseChat/FirebaseModel/constant_names.dart';
import '../../FirebaseChat/FirebaseModel/database_methods.dart';
import '../../FirebaseChat/FirebaseModel/helperfunction.dart';
import '../../FirebaseChat/Services/auth.dart';
import '../../Models/get_login.dart';
import '../../Models/registerapi.dart';
import '../../Network/NetworkHelper.dart';
import '../../ViewModel/changenotifier.dart';
import '../BottomNavigations/bottom_navigation_covid.dart';
import '../Chatroom/chat_room.dart';
import '../Chatroom/conversation_screen.dart';
import '../Extracted Widgets/bluetextfield.dart';
import '../Extracted Widgets/buttons.dart';
import '../Extracted Widgets/snackbar.dart';
import '../ScrollableAppBar/backappbar.dart';
import '../Signup/signup.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.page, this.isFromProfile, this.doctorName});
  final page;
  final isFromProfile;
  final doctorName;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHiddenPassword = true;
  bool isChecked = false;
  bool isFromThisPage = true;

  //For obscure text
  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ConnectivityResult result = ConnectivityResult.none;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //For validation form is required
  AuthMethod authMethod = AuthMethod();
  DatabaseMethods databaseMethods = DatabaseMethods();
  QuerySnapshot? snapshotUserInfo;

  credentialDontMatch() {
    Navigator.pop(context);
    showSnackBar(
      context,
      "Attention",
      Colors.red,
      Icons.info,
      "Credentials does not matched.",
    );
  }

//Dont know logic but it creates a unique id for user and another user
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }



  //will send to chat room and start conversation
  sendMessage (String userName){
    print(ConstantName.myName);
    if(userName != widget.doctorName){
      List<String> users = [userName , widget.doctorName]; //userName is my acc name and constant.myName is the other user

      String chatRoomId = getChatRoomId(widget.doctorName,userName);//Sending user and another user

      //Used for the creating the fields in chatroom. User is the list of me and my friend and chatRoomId is going to be same for us both.
      Map<String, dynamic> chatRoomMap = {
        "users" : users,
        "chatroomId": chatRoomId
      };

      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);//creates the db chatroom and provides the value

      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(
              chatRoomId
          )
      ));
    }
    else{
      print("Cant chat with yourself mate");
    }

  }






//When the sign in button is tapped the following method executes
  //TODO the shared preference doesn't work when log out and credential doesn't match doesn't work
  signIn() async {
    result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      if (_formKey.currentState!.validate()) {
        _showDialog();
        final email = emailController.text;
        final password = passwordController.text;
        try {
          //Write the firebase credential here
          databaseMethods.getUserByEmail(email).then((val) {
            snapshotUserInfo = val;
            HelperFunctions.saveUserNameSharedPreference(
                snapshotUserInfo!.docs[0].get("name"));
          });
          HelperFunctions.saveUserLoggedInSharedPreference(true);

          //checking if the login is working is still necessary
          Login login =await NetworkHelper().getLoginData(email, password);
          var error = login.message;
          var token = login.token;
          context.read<DataProvider>().personNames(token);
          print(error);
          print(token);
          if(error == null ){

          authMethod.signInWithEmailAndPassword(email, password).then((val) {
            if (val != null) {
              widget.isFromProfile ? sendMessage(snapshotUserInfo!.docs[0].get("name")) :
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return widget.page;
              }));
            }
          }).onError((error, stackTrace) => credentialDontMatch());}
        } catch (e) {
          print("failed");
        }
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
  }

  //Call in the button to register new user
/*  Future<void> loginWithApi() async {
    var email = emailController.text;
    var password = passwordController.text;
    RegisterApi? signup = await NetworkHelper()
        .getRegData(email
        password);
    var error = signup!.message;

  }*/

  //Shows when login is tapped before letting user to another page
  _showDialog() async {
    await Future.delayed(
      Duration(milliseconds: 10),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Text('Loading...'),
          content: Row(
            children: [
              CircularProgressIndicator(
                color: Colors.blue,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(child: Text('The app is loading.'))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        backgroundColor: Colors.white,
        body: BackAppBar(
          Scaffold(

            backgroundColor: Colors.white,
            body: ListView(
              reverse: false,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 90.0, horizontal: 40),
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Hero(
                                      tag: 'logo',
                                      child: Image.asset(
                                        'assets/logo.png',
                                        width: 85,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 32.04,
                                  ),
                                  Text(
                                    'Log In',
                                    style: TextStyle(
                                        fontFamily: 'NutinoSansReg',
                                        fontSize: 20,
                                        color: Color(0xff0D5D40)),
                                  ),
                                  SizedBox(height: 5,),
                                  Text('For exclusive access', style: TextStyle(
                                    fontFamily: 'NutinoSansReg',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff777777),
                                  ),),
                                  SizedBox(
                                    height: 32.00,
                                  ),
                                  //Normal Text field which is extracted in extracted widget
                                  BlueTextFormField(
                                    'Email',
                                    'assets/usericon.png',
                                    emailController,
                                    (String? value) {
                                      if (value!.isEmpty) {
                                        return "This field is required";
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
                                  //TextField for password
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
                                            isHiddenPassword
                                                ? 'assets/eye.png'
                                                : 'assets/eye.png',
                                            width: 20,
                                            color: Color(0xff0D5D40),
                                          ),
                                        ),
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "This field is required";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),


                                  LoginButton('Log In', () async {
                                    /*    if (internetConnection())*/
                                    signIn();
                                  }),
                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return BottomNavigationCovid();
                                                  }));
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            fontFamily: 'NutinoSansReg',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff333333),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),

                                  Divider(
                                    thickness: 1.0,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'New to this account?  ',
                                        style: TextStyle(
                                          fontFamily: 'NutinoSansReg',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff333333),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return SignupPage();
                                          }));
                                        },
                                        child: Text(
                                          'Sign Up',
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
      ),
    );
  }
}
