import 'package:flutter/material.dart';
import 'package:print_house/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:print_house/components/message_stream.dart';

User loggedInUser;
final _firestoreVar = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  String messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
//----------------------------------------------------------------------------------------------------------
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });

      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async{
  //  final messages= await _firestoreVar.collection('messages').get();
  //  for (var msgs in messages.docs){
  //    print(msgs.data()); //gets all the messages
  //  }
  // }

  // void messegesStresm() async{
  //   await for (var snapshot in _firestoreVar.collection('messages').snapshots()){
  //     for (var msgs in snapshot.docs) {
  //       print(msgs.data()); //gets all the messages
  //     }
  //   } //the stream gets the new changes
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('Admin contact'),
        flexibleSpace: kAppBarDecoration,
      ),
      body:
      SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(loggedInUser:loggedInUser ,),

          ],
        ),
      ),
    );
  }
}

