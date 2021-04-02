import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:print_house/components/constants.dart';
import 'package:print_house/screens/registration_screen.dart';
import 'home_page.dart';
final _auth = FirebaseAuth.instance;
String email;
String password;


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              padding: const EdgeInsets.only(left:15.0,right:15.0,bottom:50.0,top:150.0),
              child: ListView(
                //mainAxisAlignment: MainAxisAlignment.center,
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
                            final user =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            print(
                                '$email -------------------------------------------------------------------------------------------------');
                            if (user != null) {
                              if(email=='admin@g.com') {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return HomePage(isAdmin: true,); //change it to admin page
                                  },
                                ));
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return HomePage(isAdmin: false,);
                                  },
                                ));
                              }

                            }
                            setState(() {
                              showSpinner = false;
                            });
//Implement registration functionality.
                          } catch (e) {
                            setState(() {
                              showSpinner = false;
                            });
                            if (e.toString().contains('no user')) {
                              final snackBar = SnackBar(
                                  content: Text(
                                    'this email doesn\'t exist',
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
                    },child: Container(
                    padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(25),color: Colors.green),
                      child: Text('Login',textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'don\'t have an account ? ',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return RegistrationScreen();
                              }));
                        },
                        child: Text(' Register here ',
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

