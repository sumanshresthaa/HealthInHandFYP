import 'package:flutter/material.dart';

import '../../FirebaseChat/FirebaseModel/helperfunction.dart';
import '../../Textstyle/constraints.dart';
import '../Login/login.dart';
import 'chat_room.dart';


class GoToChat extends StatelessWidget {
  var userIsLoggedIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFFFFF),
        title: Text('Let\'s talk', style: kStyleHomeWelcome.copyWith(color: Color(0xff324F81)),),

        centerTitle: true,


      ),
            body: Column(
        children: [
          Image.asset('assets/beforechat.png'),
          GestureDetector(
            onTap: () async {
              await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
                userIsLoggedIn = value;});

              if(userIsLoggedIn != null){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ChatRoom();
                }));
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginPage(isFromProfile: false, page: ChatRoom());
                }));
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/messagedoctorprofile.png', height: 50,),
                 SizedBox(width: 5.0,),
                 Text('Chat Now', style: kStyleContent,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
