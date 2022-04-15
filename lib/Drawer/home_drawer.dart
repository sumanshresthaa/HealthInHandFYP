import 'package:flutter/material.dart';
import 'package:health_in_hand/Textstyle/constraints.dart';
import 'package:health_in_hand/UI/BottomNavigations/bottom_navigation_arthritis.dart';
import 'package:health_in_hand/UI/Chatroom/chat_room.dart';
import 'package:health_in_hand/UI/Screens/BookAppointment/appointment.dart';
import 'package:health_in_hand/UI/Screens/BookAppointment/view_appointments.dart';
import 'package:health_in_hand/UI/Screens/Doctors/doctor_list.dart';

import '../FirebaseChat/FirebaseModel/helperfunction.dart';
import '../Models/create_appointment.dart';
import '../UI/Login/logout.dart';


class DrawerListView extends StatefulWidget {

  @override
  State<DrawerListView> createState() => _DrawerListViewState();
}

class _DrawerListViewState extends State<DrawerListView> {

  var userIsLoggedIn;
  var myName;

  getUserName() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
      myName =  await HelperFunctions.getUserNameSharedPreference();


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Image(
                image: AssetImage('assets/healthinhandlogo.png',),
                semanticLabel: 'Company logo, Health In Hand'
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('$myName', style: kStyleDoctorName.copyWith(color: Colors.black),),
        ),
        DividerLine(),

        ListTile(
          title: Text('Home'),

          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return BottomNavigationArthritis();
                }
            ),);
            // Update the state of the app.
            // ...
          },
        ),

        ListTile(
          title: Text('Messages'),
          onTap: () {
            // Update the state of the app.
            Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return ChatRoom();
                }
            ),);
            // ...
          },
        ),
        ListTile(
          title: Text('Doctors List'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return DoctorList();
                }
            ),);
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Create Appointment'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return BookAppointment();
                }
            ),);

            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('View my appointment'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return ViewAppointments();
                }
            ),);


            // Update the state of the app.
            // ...
          },
        ),

        ListTile(
          title: Text('Help'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),

        ListTile(
          title: Text('Log Out'),
          onTap: () {
            LogoutDialog().showDialogLogout(context);

          },
        ),
      ],
    );
  }
}

class DividerLine extends StatelessWidget {
  const DividerLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Divider(
        color: Colors.black38,
        thickness: 0.5,
      ),
    );
  }
}