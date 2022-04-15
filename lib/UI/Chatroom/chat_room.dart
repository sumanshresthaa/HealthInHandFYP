import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/Chatroom/search.dart';
import 'package:health_in_hand/UI/Extracted%20Widgets/buttons.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../FirebaseChat/FirebaseModel/constant_names.dart';
import '../../FirebaseChat/FirebaseModel/database_methods.dart';
import '../../FirebaseChat/FirebaseModel/helperfunction.dart';
import '../../FirebaseChat/Services/auth.dart';
import '../../Textstyle/constraints.dart';
import '../../ViewModel/changenotifier.dart';
import 'conversation_screen.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethod authMethod = AuthMethod();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream<QuerySnapshot>? chatRoomStream;
  var userName;

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  //Since the name will be retrieved many time we call the name while building this page
  getUserInfo() async{
    ConstantName.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    userName = ConstantName.myName;
    databaseMethods.getChatRoomLastMessage().then((val){
      setState(() {
        chatRoomStream = val;
      });
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F7FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFFFFF),
        title: Text('Chat Room', style: kStyleHomeWelcome.copyWith(color: Color(0xff324F81)),),
        leading: Icon(Icons.arrow_back, color: Color(0xff324F81),),
        centerTitle: true,


      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: chatRoomList(),),
      ),


    );
  }

 Widget chatRoomList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRoomStream,
      builder: (context, snapshot){

        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              return Container(
                child: ChatRoomTile(
                  //These are from the last message collection made from getChatRoomLastMessage
                    snapshot.data!.docs[index]["lastMessage"],
                    snapshot.data!.docs[index].id, userName,
                  snapshot.data!.docs[index]["sentby"],
                ),

              );
            }
        ): Container();
      },
    );
 }
}

class ChatRoomTile extends StatefulWidget {
final lastMessage;
final chatRoomId;
final userName;
final sentBy;
ChatRoomTile(this.lastMessage, this.chatRoomId, this.userName, this.sentBy);

  @override
  State<ChatRoomTile> createState() => _ChatRoomTileState();
}

class _ChatRoomTileState extends State<ChatRoomTile> {
  var userName;


getThisUserInfo() async {
  userName =
      widget.chatRoomId.replaceAll(widget.userName, "").replaceAll("_", "");

  setState(() {});
}

@override
  void initState() {
    // TODO: implement initState
  getThisUserInfo();
  print('chaliracha');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 3,
            offset: Offset(
                0, 2), // changes position of shadow
          ),
        ],

      ),

      child: GestureDetector(
        onTap: (){
          context.read<DataProvider>().personNames(widget.userName);

          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ConversationScreen(widget.chatRoomId);

          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  CircleAvatar(
                    backgroundColor: Color(0xff3FA5DF),
                    child: Text(userName.substring(0,1).toUpperCase(),),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName, style: kStyleHomeWelcome,),
                      SizedBox(height: 4,),
                      //sent by just using the first name
                      Text("${widget.sentBy.substring(0, widget.sentBy.indexOf(' '))}: ${widget.lastMessage}", style: kStyleContent,),

                    ],
                  ),
                ],
              ),

         /*   Container(
              decoration: BoxDecoration(
                color: Color(0xff3FA5DF),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 3,
                    offset: Offset(
                        0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Message', style: TextStyle(color: Colors.white),),
              ),
            )*/
             // Text(userName.substring(0,1) )
            ],
          ),
        ),
      ),
    );
  }
}
