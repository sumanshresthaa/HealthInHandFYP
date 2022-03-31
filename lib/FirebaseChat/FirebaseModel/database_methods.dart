import 'package:cloud_firestore/cloud_firestore.dart';

//This class creates user, get login info. Basically is the gateway between firebase and flutter
class DatabaseMethods{

  //Called by the textfield of search. Search using name to get username and password
  getUserByUserName(String userName) async{
    return await FirebaseFirestore.instance.collection("users").where("name", isEqualTo: userName).get();
  }
//Uploads the information email and name of user from the textfield in the sign up page
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  //Retrieve the email of user and check if the email match with the one in firebase db to login user
  getUserByEmail(String userEmail)async{
    return await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: userEmail).get();
  }

// Create a collection called chatroom
  createChatRoom(String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).set(chatRoomMap).catchError((e){print(e.toString());});
  }

  //Adds the message coming from textfield and store it to database
  addConversationMessages(String chatRoomId, messageMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).collection("chat").add(messageMap).catchError((e){print(e.toString());});
  }

  //Retrieves the messages from the database and we can use it to show in list view
  getConversationMessages(String chatRoomId) async{
    return  FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chat")
        .orderBy("timeStamp", descending: true)
        .snapshots();
  }
  
  
  getChatroomData(String userName)async{
    return await FirebaseFirestore.instance.collection("ChatRoom").where("users", arrayContains: userName).snapshots();
  }

}