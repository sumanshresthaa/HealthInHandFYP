import 'package:flutter/material.dart';

import '../../FirebaseChat/FirebaseModel/helperfunction.dart';
import '../Login/login.dart';
import 'chat_room.dart';


class GoToChat extends StatelessWidget {
  var userIsLoggedIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(onPressed: () async {
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
          }, child: Text('Lets Chat'))
        ],
      ),
    );
  }
}
