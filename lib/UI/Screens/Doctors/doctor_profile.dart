import 'package:flutter/material.dart';
import 'package:health_in_hand/FirebaseChat/FirebaseModel/helperfunction.dart';
import 'package:health_in_hand/Models/get_login.dart';
import 'package:health_in_hand/Models/sendMessage.dart';
import 'package:health_in_hand/UI/Chatroom/chat_room.dart';
import 'package:health_in_hand/UI/Login/login.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../FirebaseChat/FirebaseModel/constant_names.dart';
import '../../../FirebaseChat/FirebaseModel/database_methods.dart';
import '../../../Textstyle/constraints.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../Chatroom/conversation_screen.dart';

class DoctorProfile extends StatefulWidget {
  DoctorProfile({this.index, this.details});
  final index;
  final details;

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {

  bool? userIsLoggedIn;
  var userName;

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }

  getUserName() async {
    await HelperFunctions.getUserNameSharedPreference().then((value){
      setState(() {
        userName  = value;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getLoggedInState();
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //will send to chat room and start conversation

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                     Navigator.pop(context);
                    },
                    child: Image.asset('assets/arrow.png', height: 20,)),

                Icon(Icons.more_vert)

              ],
            ),

            Expanded(
              child: ListView(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/profile.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(child: Text('Dr ${widget.details[widget.index].name}', style: kStyleDoctorName,)),
                  SizedBox(height: 5,),

                  Center(child: Text('Internal Medicine', style: kStyleDoctorSpeciality,)),
                  Row(
                    children: [
                      DoctorAchievement(logo: 'assets/icon1doctorprofile.png', number: '1000+', nameType: 'Patients',),
                      DoctorAchievement(logo: 'assets/icon2doctorprofile.png', number: '10 Yrs', nameType: 'Experience',),
                      DoctorAchievement(logo: 'assets/icon3doctorpofile.png', number: '4.5', nameType: 'Ratings',),


                    ],
                        ),
                  SizedBox(height: 30,),
                  Text('About Doctor', style: kStyleTime,),
                  SizedBox(height: 12,),

                  Text('${widget.details[widget.index].about}',style:kStyleDoctorSpeciality.copyWith(fontSize: 12.sp) ,),
                  SizedBox(height: 30,),

                  Text('Working Time', style: kStyleTime,),
                  SizedBox(height: 12,),

                  Text('${widget.details[widget.index].availability}', style:kStyleDoctorSpeciality.copyWith(fontSize: 12.sp)),
                    Text('Communication',  style: kStyleTime),
                  GestureDetector(
                    onTap: () async{
                      print(userIsLoggedIn);

                      context.read<DataProvider>().personNames(widget.details[widget.index].name);
                      print(userName);

                      userIsLoggedIn != null ? userIsLoggedIn == false ?
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return LoginPage(isFromProfile: true, doctorName: '${widget.details[widget.index].name}' );
                      })) : SendMessage().sendMessageFromProfileLogin(userName!,'${widget.details[widget.index].name}', context) : Navigator.push(context, MaterialPageRoute(builder: (context){
                        return LoginPage(isFromProfile: true, doctorName: '${widget.details[widget.index].name}' );
                      }));
                    },
                    child: Row(
                      children: [
                        Container(child: Image.asset('assets/messagedoctorprofile.png',height: 50,),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('Messaging', style: kStyleContent,),
                              SizedBox(height: 5,),

                              Text('Chat me up', style:kStyleDoctorSpeciality.copyWith(fontSize: 10.sp))
                            ]
                          ),
                        )
                      ],
                    ),
                  )


                    ],
                  ),
            )

              ],
            )

        ),

    );
  }
}

class DoctorAchievement extends StatelessWidget {
DoctorAchievement({this.logo, this.number, this.nameType});
final logo;
final number;
final nameType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(21)),
              boxShadow: [
          BoxShadow(
          color:
          Colors.grey.withOpacity(0.05),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0,
              -2), // changes position of shadow

          ),],),

          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Image.asset(logo,height: 50,),
              SizedBox(height: 17),
              Text('$number', style: kStyleChatDoctor),
              SizedBox(height: 4),


              Text('$nameType', style: kStyleDoctorSpeciality,),
              SizedBox(height: 12),


            ],
          ) ,),
      ));
  }
}
