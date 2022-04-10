import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_in_hand/Network/api_links.dart';
import 'package:health_in_hand/UI/Login/login.dart';
import 'package:health_in_hand/UI/Screens/BookAppointment/appointment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../FirebaseChat/FirebaseModel/helperfunction.dart';
import '../../../FirebaseChat/Services/auth.dart';
import '../../../ViewModel/changenotifier.dart';

class ChooseAppointment extends StatefulWidget {
  @override
  State<ChooseAppointment> createState() => _ChooseAppointmentState();
}

class _ChooseAppointmentState extends State<ChooseAppointment> {
  var userIsLoggedIn;
  AuthMethod authMethod = AuthMethod();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late var token = Provider.of<DataProvider>(context, listen: false).tokenValue;

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
                 userIsLoggedIn = value;});

              if(userIsLoggedIn != null){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return BookAppointment();
                }));
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginPage(isFromProfile: false, page: BookAppointment());
                }));
              }



            },
            child: Text('Create Appointment'),
          ),
          TextButton(
            onPressed: ()async{
             // _signOut();
              SharedPreferences preferences = await SharedPreferences.getInstance();
                await preferences.remove('ISLOGGEDIN');

            },
            child: Text('View Appointment'),
          ),
          TextButton(
            onPressed: ()async{
              await ApiData().getAppointmentDetails(token);

            },
            child: Text('check Appointment'),
          )

        ],
      ),
    );
  }
}
