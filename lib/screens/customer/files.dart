import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:print_house/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Files extends StatefulWidget {
  @override
  _FilesState createState() => _FilesState();
}
User loggedInUser;

class _FilesState extends State<Files> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _fireStoreVar = FirebaseFirestore.instance;

  List<PlatformFile> _path;
  String path;
  String name;
  FileType pickType = FileType.custom;
  List<StorageUploadTask> tasks = <StorageUploadTask>[];
  String _extension ;
  PlatformFile file;
  String url;

  uploadToFirebase(fileName, filePath) async {
    _extension=fileName.toString().split('.').last;
    StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = storageReference.putFile(File(filePath),StorageMetadata(
        contentType: '$pickType/$_extension'
    ));
    setState(() {
      tasks.add(uploadTask);
    });
    var dowUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowUrl.toString();

  }

  void _openFileExplorer() async {
    try {
      _path = (await FilePicker.platform
              .pickFiles(type: pickType, allowedExtensions: ['pdf']))
          ?.files ;
      file = _path.first;
      path = file.path;
      name=file.name;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    uploadToFirebase(name, path);
    setState(() {});
  }
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
  @override
  void initState() {
    getCurrentUser();
    // TODO: implement initState
    super.initState();
  }

  String copiesNum;
  String address;
  String printSize = 'A4';
  String printType = 'Black&White';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        flexibleSpace: kAppBarDecoration,
        centerTitle: true,
        title: Text(
          'Files',
          style: TextStyle(color: Colors.white70, fontSize: 35),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          children: [
            Builder(
              builder: (BuildContext context) => _path != null
                  ? Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      height: 80,
                      child: ListView.separated(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          // String fileName = _path
                          //               .map((e) => e.name)
                          //               .toList()[0];
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _openFileExplorer();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Add File',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CircleAvatar(
                                          radius: 7,
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 13,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 25,
                                      ),
                                      Text(
                                        name,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _path = null;
                                              name='';
                                              //fileName = '';
// path = '';
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 25,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(),
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/files.jpeg',
                                  width: 100,
                                  height: 100,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _openFileExplorer();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Add File',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CircleAvatar(
                                          radius: 7,
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 13,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 25,
                                    ),
                                    Text(
                                      'file name',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.delete,
                                      size: 25,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Number of copies:',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter a value';
                        }
                      },
                      onChanged: (value) {
                        copiesNum = value;
                      },
                      decoration: kInputDecoration.copyWith(
                          hintText: 'Enter Number of copies')),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Print Type:',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: Text(printType),
                    value: printType,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.red,
                    ),
                    iconSize: 20,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        printType = newValue;
                      });
                    },
                    items: <String>['Black&White', 'Colored']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Print Size:',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(printSize),
                      value: printSize,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.red,
                      ),
                      iconSize: 20,
                      elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          printSize = newValue;
                        });
                      },
                      items: <String>['A0', 'A1', 'A2', 'A3', 'A4']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your Address:',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      // ignore: missing_return
                      onChanged: (value) {
                        address = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter a value';
                        } else
                          return null;
                      },
                      decoration: kInputDecoration.copyWith(
                          hintText: 'Enter your address')),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    widthFactor: 20,
                    child: FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if (url != null) {
                              _fireStoreVar.collection('files').add({
                                'copies': int.parse(copiesNum),
                                'address': address,
                                'size': printSize,
                                'type': printType,
                                'url': url,
                                'uid': loggedInUser.email,
                                'name': name
                              });
                              Alert(
                                  context: context,
                                  title: ' Your order is sent ',
                                  buttons: [
                                    DialogButton(
                                      child: Text('okay'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ]).show();
                            }
                          }
                        },
                        child: Text(
                          'Send',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
