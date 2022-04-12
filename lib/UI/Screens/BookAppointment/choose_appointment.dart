import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/Screens/BookAppointment/view_appointments.dart';

import 'package:provider/src/provider.dart';

import '../../../FirebaseChat/FirebaseModel/helperfunction.dart';
import '../../../Textstyle/constraints.dart';
import '../../Login/login.dart';
import 'appointment.dart';



class ChooseAppointment extends StatefulWidget {
  const ChooseAppointment({Key? key}) : super(key: key);

  @override
  State<ChooseAppointment> createState() => _ChooseAppointmentState();
}

class _ChooseAppointmentState extends State<ChooseAppointment> {
  var userIsLoggedIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F7FF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffFFFFFF),
          title: Text('Appointments', style: kStyleHomeWelcome.copyWith(color: Color(0xff324F81)),),
          leading: Icon(Icons.arrow_back, color: Color(0xff324F81),),
          centerTitle: true,


        ),
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 12.0, left: 16.0, right: 16.0, bottom: 27.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                      color: Colors.blue.shade100
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 16.0),
                        child: Text(
                            'Create a new appointment',
                            textAlign: TextAlign.center,
                            style: kStyleO2OMain),
                      ),
                      Center(
                          child: Image.asset(
                        'assets/O2OSecondPage2.png',
                        height: 225,
                        width: 252,
                      )),
                      SizedBox(
                        height: 21.79,
                      ),
                      SizedBox(
                        width: 190,
                        // height: 37,
                        child: ElevatedButton(
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
                          child: Text(
                            'Create an Appointment',
                            style: TextStyle(color: Color(0xff000000)),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xffFFFFFF)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Color(0xffA3A3A3)))),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 0.0, left: 16.0, right: 16.0, bottom: 12),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red.shade200



                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 16.0),
                    child: Column(
                      children: [
                        Text(
                            'View your appointments',
                            textAlign: TextAlign.center,
                            style: kStyleO2OMain.copyWith(color: Colors.white)),
                        Center(
                            child: Image.asset(
                              'assets/O2OSecondPage.png',
                              height: 225,
                              width: 252,
                            )),
                        SizedBox(
                          height: 21.79,
                        ),
                        SizedBox(
                          width: 190,
                          // height: 37,
                          child: ElevatedButton(
                            onPressed: () async {
                              await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
                                userIsLoggedIn = value;});

                              if(userIsLoggedIn != null){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return ViewAppointments();
                                }));
                              }
                              else{
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return LoginPage(isFromProfile: false, page: ViewAppointments());
                                }));
                              }
                            },
                            child: Text(
                              'View Appointments',
                              style: TextStyle(color: Color(0xff000000)),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffFFFFFF)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                                side: MaterialStateProperty.all(
                                    BorderSide(color: Color(0xffA3A3A3)))),
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

      ],
    ));
  }
}







// go to Appointment button
//

//          TextButton(
//             onPressed: () async {
//
//
//
//
//             },
//             child: Text('Create Appointment'),
//           ),