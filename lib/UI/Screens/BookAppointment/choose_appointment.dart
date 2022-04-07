import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/Login/login.dart';
import 'package:health_in_hand/UI/Screens/BookAppointment/appointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../FirebaseChat/Services/auth.dart';

class ChooseAppointment extends StatefulWidget {
  @override
  State<ChooseAppointment> createState() => _ChooseAppointmentState();
}

class _ChooseAppointmentState extends State<ChooseAppointment> {
  AuthMethod authMethod = AuthMethod();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return LoginPage(isFromProfile: false, page: BookAppointment());
              }));

            },
            child: Text('Create Appointment'),
          ),
          TextButton(
            onPressed: ()async{
              _signOut();
              SharedPreferences preferences = await SharedPreferences.getInstance();
                await preferences.remove('ISLOGGEDIN');

            },
            child: Text('View Appointment'),
          )

        ],
      ),
    );
  }
}
