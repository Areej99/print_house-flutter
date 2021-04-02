import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///D:/projects/print_house/lib/screens/admin/admin_msg_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class ShieldsCard extends StatelessWidget {
  ShieldsCard({this.address, this.script, this.model, this.userEmail, this.id});
  final String userEmail;
  final String address;
  final String model;
  final String script;
  final String id;

  @override
  Widget build(BuildContext context) {
    final _firestoreVar = FirebaseFirestore.instance;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userEmail,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.pink.shade900),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Script:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              Container(
                child: Text(
                  script,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "Address:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      address,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    model,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  GestureDetector(
                      onTap: () {
                        Alert(
                            context: context,
                            title: 'sure you want to delete ? ',
                            buttons: [
                              DialogButton(
                                child: Text('delete'),
                                onPressed: () {
                                  _firestoreVar.collection('shields').doc(id).delete();
                                  Navigator.pop(context);
                                },
                              ),

                              DialogButton(
                                child: Text('cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ]).show();                },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      )),

                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminChat(customerMail: userEmail,),));
                      },
                      child: Icon (Icons.chat, color: Colors.blue.shade900, size: 30,)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
