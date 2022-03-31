import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/Chatroom/search.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../FirebaseChat/FirebaseModel/constant_names.dart';
import '../../FirebaseChat/FirebaseModel/database_methods.dart';
import '../../FirebaseChat/FirebaseModel/helperfunction.dart';
import '../../FirebaseChat/Services/auth.dart';
import '../../ViewModel/changenotifier.dart';
import 'conversation_screen.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethod authMethod = AuthMethod();
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream<QuerySnapshot>? chatRoomStream;

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  //Since the name will be retrieved many time we call the name while building this page
  getUserInfo() async{
    ConstantName.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    databaseMethods.getChatroomData(ConstantName.myName).then((val){
      setState(() {
        chatRoomStream = val;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        actions: [
          GestureDetector(
            onTap: () async{
              setState(() {
                authMethod.signOut();
              });

              SharedPreferences preferences = await SharedPreferences.getInstance();
              setState(() async {
                await preferences.remove('ISLOGGEDIN');
                Navigator.pop(context);


              });

            },
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        child: chatRoomList(),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return SearchScreen();
          }));
        },
      child: Icon(Icons.search),),


    );
  }

 Widget chatRoomList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRoomStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              return Container(
                height: 50,
                child: ChatRoomTile(
                    snapshot.data!.docs[index].get("chatroomId").toString().replaceAll("_", "").replaceAll(ConstantName.myName,""  ),
                    snapshot.data!.docs[index].get("chatroomId")),
              );
            }
        ): Container();
      },
    );
 }
}

class ChatRoomTile extends StatelessWidget {
final userName;
final chatRoomId;
ChatRoomTile(this.userName, this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return Container(

      child: GestureDetector(
        onTap: (){
          context.read<DataProvider>().personNames(userName);

          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ConversationScreen(chatRoomId);

          }));
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xff0D5D40),
              child: Text(userName.substring(0,1).toUpperCase(),),
            ),
            SizedBox(width: 8,),
            Text(userName.toUpperCase()),
            Text(userName.substring(0,1) )
          ],
        ),
      ),
    );
  }
}
