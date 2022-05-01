import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../FirebaseChat/FirebaseModel/constant_names.dart';
import '../../FirebaseChat/FirebaseModel/database_methods.dart';
import '../../Textstyle/constraints.dart';
import '../../ViewModel/changenotifier.dart';
import '../Extracted Widgets/bluetextfield.dart';
import 'package:intl/intl.dart';
import '../ScrollableAppBar/backappbar.dart';
import 'package:timeago/timeago.dart' as timeago;



class ConversationScreen extends StatefulWidget {
  ConversationScreen({this.chatRoomId, this.userName});
  final chatRoomId;
  final userName;

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}


class _ConversationScreenState extends State<ConversationScreen> {
  //late var userName = context.watch<DataProvider>().personName;

  Stream<QuerySnapshot>? chatMessageStream;
  final TextEditingController messageController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();


  //When the icon is pressed this is called. The final function in chat
  sendMessage(){
    Map<String, dynamic> messageMap= {
      "message" : messageController.text,
      "sentby" : ConstantName.myName,
      "timeStamp" : DateTime.now().millisecondsSinceEpoch
    };

    if(messageController.text.isNotEmpty){
      Map<String, dynamic> lastMessageInfoMap ={
        "lastMessage":  messageController.text,
        "lastMessageTimeStamp": DateTime.now().millisecondsSinceEpoch,
        "sentby" : ConstantName.myName,
      };
//Adds the message as well as updates the last message collection as well
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      databaseMethods.updateLastMessageSent(widget.chatRoomId, lastMessageInfoMap);
      clearTextField();
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
                return MessageTile(snapshot.data!.docs[index].get("message"), snapshot.data!.docs[index].get("sentby") == ConstantName.myName, snapshot.data!.docs[index].get("timeStamp")  );
              }) : CircularProgressIndicator();
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: ChatAppBar(title: '${widget.userName}',),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0,top: 5),
              child: chatMessageList(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: MessageChat(nameController: messageController, hintText: "Write a Message", icon: "assets/send.png", onPress:
                  (){
                  sendMessage();


                  } ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatefulWidget {
 final message;
 final isSentByMe;
 final timeStamp;
 MessageTile(this.message, this.isSentByMe, this.timeStamp);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
 bool isShowingTime = false;

  @override
  Widget build(BuildContext context) {

    var date = DateTime.fromMillisecondsSinceEpoch(widget.timeStamp );
    var timeAgo = timeago
        .format(date)
        .toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              children: [
                isShowingTime  ?  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(timeAgo.toString()),
                ): Container(
                  alignment: widget.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,

                ),
                Container(
                  padding: EdgeInsets.only(
                    left: widget.isSentByMe ? MediaQuery.of(context).size.width * 0.5 : 24,
                    right: widget.isSentByMe ? 24 : MediaQuery.of(context).size.width * 0.5,
                  ),
                  width: MediaQuery.of(context).size.width,
                  alignment: widget.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        isShowingTime =! isShowingTime;
                      });
                    },
                    child: Container(

                      decoration: BoxDecoration(

                        borderRadius: widget.isSentByMe ? BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(0), topLeft: Radius.circular(20), topRight: Radius.circular(20)) :
                        BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(20), topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        color: widget.isSentByMe ?  Color(0xff3FA5DF) : Color(0xffF6F6F6)  //Put gradient here
                      ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(widget.message, style: widget.isSentByMe ? kStyleChatMe : kStyleChatDoctor),
                        )),
                  ),
                ),


              ],
            ),
          ],
        ),
        SizedBox(height: 10,)

      ],
    );
  }
}
