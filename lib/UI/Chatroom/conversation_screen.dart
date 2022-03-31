import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../FirebaseChat/FirebaseModel/constant_names.dart';
import '../../FirebaseChat/FirebaseModel/database_methods.dart';
import '../../Textstyle/constraints.dart';
import '../../ViewModel/changenotifier.dart';
import '../Extracted Widgets/bluetextfield.dart';
import '../ScrollableAppBar/backappbar.dart';


class ConversationScreen extends StatefulWidget {
  ConversationScreen(this.chatRoomId);
  final chatRoomId;

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}


class _ConversationScreenState extends State<ConversationScreen> {
  late var userName = context.watch<DataProvider>().personName;

  Stream<QuerySnapshot>? chatMessageStream;
  final TextEditingController messageController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();


  sendMessage(){
    Map<String, dynamic> messageMap= {
      "message" : messageController.text,
      "sentby" : ConstantName.myName,
      "timeStamp" : DateTime.now().millisecondsSinceEpoch
    };

    if(messageController.text.isNotEmpty){
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    receiveMessage();
    super.initState();
  }

  receiveMessage(){
     databaseMethods.getConversationMessages(widget.chatRoomId).then((val){
      print(val.toString());
      setState(() {
        chatMessageStream = val;

      });

  });}

  clearTextField(){
    messageController.clear();
  }


  Widget chatMessageList(){
    //God damn bug always use query snapshot
    return StreamBuilder<QuerySnapshot>(
      stream: chatMessageStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
            reverse: true,
            itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                return MessageTile(snapshot.data!.docs[index].get("message"), snapshot.data!.docs[index].get("sentby") == ConstantName.myName );
              }) : CircularProgressIndicator();
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: ChatAppBar(title: 'Dr. ${userName}',),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: chatMessageList(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: MessageChat(nameController: messageController, hintText: "Write a Message", icon: "assets/send.png", onPress:
                  (){
                  sendMessage();
                  clearTextField();

                  } ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
 final message;
 final isSentByMe;
 MessageTile(this.message, this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: isSentByMe ? MediaQuery.of(context).size.width * 0.5 : 24,
        right: isSentByMe ? 24 : MediaQuery.of(context).size.width * 0.5,
      ),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(

        decoration: BoxDecoration(

          borderRadius: isSentByMe ? BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(0), topLeft: Radius.circular(20), topRight: Radius.circular(20)) :
          BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(20), topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: isSentByMe ?  Color(0xff0D5D40) : Color(0xffF6F6F6)  //Put gradient here
        ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(message, style: isSentByMe ? kStyleChatMe : kStyleChatDoctor),
          )),
    );
  }
}

