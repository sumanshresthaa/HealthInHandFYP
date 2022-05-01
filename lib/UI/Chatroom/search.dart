import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../FirebaseChat/FirebaseModel/constant_names.dart';
import '../../FirebaseChat/FirebaseModel/database_methods.dart';
import '../Extracted Widgets/bluetextfield.dart';
import '../ScrollableAppBar/backappbar.dart';
import 'conversation_screen.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();

 QuerySnapshot? searchSnapshot;

 //As the name suggest it will search and if found saves the value in searchSnapshot
  initiateSearch() {
    databaseMethods.getUserByUserName(searchController.text).then((val){
      print(val.toString());
      setState(() {
        searchSnapshot = val;

      });
    });

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
   if(userName != ConstantName.myName){
     List<String> users = [userName , ConstantName.myName]; //userName is my acc name and constant.myName is the other user

     String chatRoomId = getChatRoomId(ConstantName.myName,userName);//Sending user and another user

     //Used for the creating the fields in chatroom. User is the list of me and my friend and chatRoomId is going to be same for us both.
     Map<String, dynamic> chatRoomMap = {
       "users" : users,
       "chatroomId": chatRoomId
     };

     DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);//creates the db chatroom and provides the value

     Navigator.push(context, MaterialPageRoute(
         builder: (context) => ConversationScreen(chatRoomId:
            chatRoomId
         )
     ));
   }
   else{
     print("Cant chat with yourself mate");
   }

  }

Widget SearchTile({required String userName, required String email, required String profile}){
    return ListTile(
        leading: Column(
          children: [
            Text(userName),
            Text(email),
            Text('$profile hi')
          ],
        ),
        trailing: TextButton(child: Text('Message'),onPressed: (){
          print(userName);
          print(ConstantName.myName);
          sendMessage(userName); //user name of the person we are going to talk
        },)
    );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(title: 'Search',),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: BlueTextFormField(
                      'Search People',
                      'assets/search.png',
                      searchController,
            (String? value) {
                       if (value!.isEmpty) {
                            return "This field is required";
                               }
                              return null;}
    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                      child: Icon(Icons.search))
                ],
              ),
              searchList(context),
            ],
          ),
        ),
      ),

    );
  }

  Widget searchList(BuildContext context){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot!.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
        return SearchTile(
          userName: searchSnapshot!.docs[index].get("name") ?? "not found",
          email:  searchSnapshot!.docs[index].get("email")  ?? "not found",
          profile: searchSnapshot!.docs[index].get("profile")  ?? "not found",
        );
        }): Container();

  }



}



/*class SearchTile extends StatelessWidget {
   final userName;
   final email;

  SearchTile({this.userName, this.email});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        children: [
          Text(userName),
          Text(email),
        ],
      ),
      trailing: TextButton(child: Text('Message'),onPressed: (){
        sendMessage(context: context, )
      },)
    );
  }
}*/

