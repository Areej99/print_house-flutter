import 'package:flutter/material.dart';
import 'package:print_house/components/constants.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AdminChat extends StatelessWidget {
  AdminChat({this.customerMail});
 final String customerMail ;
  Timestamp time;
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final _firestoreVar = FirebaseFirestore.instance;
    final messageTextController = TextEditingController();
    String messageText;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: kAppBarDecoration,
        centerTitle: true,
        title: Text(
          customerMail,
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Builder(
        builder: (context) => Row(children: [
          Expanded(
            child: TextField(
              controller:
              messageTextController, //clears the text fiels when we hit send
              onChanged: (value) {
                messageText = value;
                //Do something with the user input.
              },
              decoration: kMessageTextFieldDecoration,
            ),
          ),
          FlatButton(
            onPressed: () {
              messageTextController
                  .clear(); //clears the text fiels when we hit send
              final date = new DateFormat('yyyy.MM.dd HH:mm:ss').format(new DateTime.now());
              _firestoreVar.collection('messages').doc(date).set({

                'text': messageText,
                  'receiver': customerMail,
                  'sender'  : 'admin@g.com',
                  'dateTime': date
              });
              //Implement send functionality.

              final snackBar = SnackBar(
                  content: Text(
                    'your message is sent successfully',
                    style: TextStyle(color: Colors.black54),
                  ),
                  backgroundColor: Colors.lightBlueAccent,
                  duration: Duration(seconds: 2),);
              Scaffold.of(context).showSnackBar(snackBar);
            },
            child: Text(
              'Send',
              style: kSendButtonTextStyle,
            ),
          ),

        ],),
      ),

    );
  }
}
