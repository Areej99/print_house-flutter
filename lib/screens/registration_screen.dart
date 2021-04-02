import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'file:///D:/projects/print_house/lib/screens/home_page.dart';
import 'package:print_house/components/constants.dart';
import 'package:print_house/screens/login_page.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Future<bool> checkInternetConnectevity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      return true;
    }
  }

  var _formKey = GlobalKey<FormState>();

  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: const EdgeInsets.only(left:15.0,right:15.0,bottom:50.0,top:90.0),
              child: ListView(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: 40,),
                      Text("print",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                      Image.asset(
                        'images/house.jpg',
                        width: 80,
                        height: 80,
                      ),
                      Text("house",style: TextStyle(fontSize: 35,fontWeight: FontWeight.normal),),

                    ],
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!value.contains('@') ||
                                  !value.contains('.')) {
                                return 'please enter a proper email format example@ex.ex';
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
//Do something with the user input.
                            },
                            decoration: kInputDecoration.copyWith(
                                hintText: 'Enter your Email')),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          // ignore: missing_return
                            obscureText: true, //for password
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });

//Do something with the user input.
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 8) {
                                return 'password must be more than 8 characters';
                              } //-----------------------------------------------------------------
                              else {
                                bool hasUpperCase = false;

                                for (int i = 0; i < value.length; i++) {
                                  if (value[i].toUpperCase() == value[i]) {
                                    hasUpperCase = true;
                                    break;
                                  }
                                }

                                return !hasUpperCase
                                    ? 'password must have at least one upper cas character'
                                    : null;
                              }
                            },
                            decoration: kInputDecoration.copyWith(
                                hintText: 'Enter your password')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool result = await checkInternetConnectevity();
                      if (!result) {
                        final snackBar = SnackBar(
                            content: Text(
                              'you don\'t have an internet connection',
                              style: TextStyle(color: Colors.black54),
                            ),
                            backgroundColor: Colors.lightBlueAccent,
                            action: SnackBarAction(
                              label: 'got it',
                              textColor: Colors.white,
                              onPressed: () {
                                Scaffold.of(context).hideCurrentSnackBar();
                              },
                            ));
                        Scaffold.of(context).showSnackBar(snackBar);
                      }else{
                        if (_formKey.currentState.validate()){
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                            print(
                                '$email -------------------------------------------------------------------------------------------------');
                            if (newUser != null) {

                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return HomePage(isAdmin: false,);
                                },
                              ));
                            }
                            setState(() {
                              showSpinner = false;
                            });
//Implement registration functionality.
                          } catch (e) {
                            setState(() {
                              showSpinner = false;
                            });
                            if (e.toString().contains('already in use')) {
                              final snackBar = SnackBar(
                                  content: Text(
                                    'this email already exists , try another email',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  backgroundColor: Colors.lightBlueAccent,
                                  action: SnackBarAction(
                                    label: 'got it',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Scaffold.of(context).hideCurrentSnackBar();
                                    },
                                  ));

                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          }
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),

                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(50.0),color: Colors.green),
                      child:
                        Text('Register',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'already have an account ? ',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }));
                        },
                        child: Text(' log in here ',
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
