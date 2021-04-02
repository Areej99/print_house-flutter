import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:print_house/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Tshirts extends StatefulWidget {
  @override
  _TshirtsState createState() => _TshirtsState();
}

User loggedInUser;

class _TshirtsState extends State<Tshirts> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _fireStoreVar = FirebaseFirestore.instance;

  List<String> _extension = ['pdf', 'png', 'jpg'];
  List<PlatformFile> _path;
  String path;
  String name;
  FileType pickType = FileType.custom;
  List<StorageUploadTask> tasks = <StorageUploadTask>[];
  String extension;
  PlatformFile file;
  String url;
  String copiesNum;
  String address;
  uploadToFirebase(fileName, filePath) async {
    extension = fileName.toString().split('.').last;
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = storageReference.putFile(
        File(filePath), StorageMetadata(contentType: '$pickType/$extension'));
    setState(() {
      tasks.add(uploadTask);
    });
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    setState(() {
      url = dowurl.toString();
    });
  }

  void _openFileExplorer() async {
    try {
      _path = (await FilePicker.platform.pickFiles(
              type: pickType,
              allowMultiple: false,
              allowedExtensions: (_extension)))
          ?.files;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        flexibleSpace: kAppBarDecoration,
        centerTitle: true,
        title: Text(
          'T-Shirts',
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
                      height: extension != 'pdf' ? 240 : 80,
                      child: Scrollbar(
                          child: ListView.separated(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          var fileName =
                              _path.map((e) => e.name).toList()[index];
                          var filePath = _path
                              .map((e) => e.path)
                              .toList()[index]
                              .toString();
                          return Column(
                            children: [
                              Center(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  extension != 'pdf'
                                      ? Image.file(
                                          File(filePath),
                                          height: 150,
                                          width: 400,
                                        )
                                      : Container(),
                                  GestureDetector(
                                    onTap: () {
                                      _openFileExplorer();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          fileName,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _path = null;
                                                fileName = '';
                                                filePath = '';
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
                              )),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          height: 1,
                        ),
                      )),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Center(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/image.jpeg',
                                width: 50,
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
                                          decoration: TextDecoration.underline),
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
                          )),
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
                            if(url!=null) {
                              _fireStoreVar.collection('tshirts').add({
                                'copies': int.parse(copiesNum),
                                'address': address,
                                'url': url,
                                'uid': loggedInUser.email,
                                'extension': extension,
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
