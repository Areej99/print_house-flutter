import 'package:flutter/material.dart';
import 'package:print_house/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///D:/projects/print_house/lib/screens/customer/web_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Shields extends StatefulWidget {
  @override
  _ShieldsState createState() => _ShieldsState();
}
User loggedInUser;

class _ShieldsState extends State<Shields> {
  final _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _fireStoreVar = FirebaseFirestore.instance;
  String name;
  String script;
  String address;
  String model = 'model: 1';

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
          'Shields',
          style: TextStyle(color: Colors.white70, fontSize: 35),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return WebViewExample(
                              appBarText: "model one",
                              url:
                                  'https://sketchfab.com/models/068d9b12fc67404198a772485c1e861d/embed?autostart=0&amp',
                            );
                          },
                        ));
                      },
                      child: Image.asset(
                        'images/model1.jpeg',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Text('model: 1')
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return WebViewExample(
                              appBarText: "model two",
                              url:
                                  'https://sketchfab.com/models/dae1584afbc84be0893eb0de61150968/embed?autostart=0&amp',
                            );
                          },
                        ));
                      },
                      child: Image.asset(
                        'images/model2.jpeg',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Text('model: 2')
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return WebViewExample(
                              appBarText: "model three",
                              url:
                                  'https://sketchfab.com/models/9bf82063dc144bd58860919c8439d768/embed?autostart=0&amp;ui_controls=1&amp',
                            );
                          },
                        ));
                      },
                      child: Image.asset(
                        'images/model3.jpeg',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Text('model: 3')
                  ],
                ),
              ],
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
                      hint: Text(model),
                      value: model,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.red,
                      ),
                      iconSize: 20,
                      elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          model = newValue;
                        });
                      },
                      items: <String>['model: 1', 'model: 2', 'model: 3']
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
                    'Enter Script:',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter a value';
                        }
                      },
                      onChanged: (value) {
                        script = value;
                      },
                      decoration: kInputDecoration.copyWith(
                          hintText: 'Enter Your Script')),
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
                            _fireStoreVar.collection('shields').add({
                              'model': model,
                              'address': address,
                              'script': script,
                              'uid': loggedInUser.email
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
