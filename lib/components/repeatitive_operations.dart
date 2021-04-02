import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'file:///D:/projects/print_house/lib/screens/admin/admin_msg_page.dart';
import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class RepeatitiveOperations extends StatelessWidget {
  RepeatitiveOperations({this.name,this.url,this.id,this.collectionName,this.email});
  final String name ;
  final String url ;
  final String id;
  final String collectionName;
  final String email;
  final _firestoreVar = FirebaseFirestore.instance;
  var dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) =>
     Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          GestureDetector(
            onTap: () async {
              final exDirectory =
              await ExtStorage.getExternalStoragePublicDirectory(
                  ExtStorage.DIRECTORY_DOWNLOADS);
              final status = await Permission.storage.request();
              try {
                Response response = await dio.get(url,
                    options: Options(responseType: ResponseType.bytes,));
                File file = File("$exDirectory/$name");
                var raf = file.openSync(mode: FileMode.write);
                raf.writeFromSync(response.data);
                await raf.close();
              }//////////////////////////////////////
              catch (e) {
                print(e);
                final snackBar = SnackBar(
                    content: Text(
                      'there was a problem with downloading , try again later',
                      style: TextStyle(color: Colors.black54),
                    ),
                    backgroundColor: Colors.green,
                    action: SnackBarAction(
                      label: 'got it',
                      textColor: Colors.white,
                      onPressed: () {
                        Scaffold.of(context).hideCurrentSnackBar();
                      },
                    ));
                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
            child: Icon(
              Icons.file_download,
              color: Colors.green,
              size: 30,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          GestureDetector(
              onTap: () {
                Alert(
                    context: context,
                    title: 'sure you want to delete ? ',
                    buttons: [
                      DialogButton(
                        child: Text('delete'),
                        onPressed: () {
                          _firestoreVar.collection(collectionName).doc(id).delete();
                          Navigator.pop(context);
                        },
                      ),

                      DialogButton(
                        child: Text('cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]).show();



                //print (new DateFormat('yyyy.MM.dd  HH:mm:ss').format(new DateTime.now()));
              },
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
             Navigator.push(context, MaterialPageRoute(builder: (context) => AdminChat(customerMail: email,),));
            },
              child: Icon (Icons.chat, color: Colors.blue.shade900, size: 30,)),
        ],
      ),
    );
  }
}

