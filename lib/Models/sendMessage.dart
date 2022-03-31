import 'package:flutter/material.dart';

import '../FirebaseChat/FirebaseModel/constant_names.dart';
import '../FirebaseChat/FirebaseModel/database_methods.dart';
import '../UI/Chatroom/conversation_screen.dart';

class SendMessage{

//Dont know logic but it creates a unique id for user and another user
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  //will send to chat room and start conversation
  sendMessageFromProfileLogin (String userName, String anotherName,BuildContext context){
    if(userName != anotherName){
      List<String> users = [userName , anotherName]; //userName is my acc name and constant.myName is the other user

      String chatRoomId = getChatRoomId(anotherName,userName);//Sending user and another user

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

}