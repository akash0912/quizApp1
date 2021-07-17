import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/controller/authentication.dart';
import 'package:flutter_application_2/page/homepage.dart';
import 'package:flutter_application_2/page/learning.dart';
import 'package:flutter_application_2/services/api_manager.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/services/api_manager.dart';

class signin extends StatefulWidget {
  signin({Key? key}) : super(key: key);

  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
  late ConnectivityResult prev;
  bool dialogShown = false;
  late StreamSubscription streamSubscription;
  String email = "";
  String password = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var userDetail;

  void signin() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      signIn(email, password).then((value) {
        // if (value != null) {
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(
        //       builder: (context) => HomePage(uid: value.uid),
        //     ),
        //   );
        // }
      });
    }
  }

  Future<bool> checkInternet() async {
    try {
      var res = await InternetAddress.lookup("google.com");
      if (res.isNotEmpty && res[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connres) {
      if (connres == ConnectivityResult.none) {
        dialogShown = true;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text("Error"),
                  content: Text(" No Internet Connection"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMapMethod('SystemNavigator.pop');
                      },
                      child: Text("Exit"),
                    ),
                  ],
                ));
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text("Error"),
                  content: Text(" No Internet Connection"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMapMethod('SystemNavigator.pop');
                      },
                      child: Text("Exit"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          var net = checkInternet();
                          if (net == true) {
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Text(
                        "Try Agian",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ));
      } else {
        if (prev == ConnectivityResult.none) {
          checkInternet().then((value) {
            if (value == true) {
              if (dialogShown == true) {
                dialogShown = false;
                //Navigator.pop(context);
              }
            }
          });
        }
        prev = connres;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void validate() {
      if (formKey.currentState!.validate()) {
        print("validated");
      } else {
        print("Not validated");
      }
    }

    String validatePass(value) {
      if (value.isEmpty) {
        return "Required*";
      } else {
        return "null";
      }
    }

    ;

    return Scaffold(
        backgroundColor: Color(0xff00A5F3),
        appBar: AppBar(
          backgroundColor: Color(0xff00A5F3),
          elevation: 0.0,
          title: Text(
            "Sign In",
            style: TextStyle(fontSize: 32.0, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(top: 40.0),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Email is required"),
                                // EmailValidator(
                                //     errorText: 'enter a valid email address'),
                              ]),
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w600),
                              autofocus: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(),
                                hintText: "Email",
                                suffixIcon: Icon(Icons.verified_user),
                              ),
                              onChanged: (_val) {
                                email = _val;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                                autofocus: false,
                                obscureText: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                      borderSide: BorderSide(width: 10.0)),
                                  hintText: "Password",
                                  suffixIcon: Icon(Icons.lock),
                                ),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Password Is Required"),
                                  MinLengthValidator(3,
                                      errorText:
                                          "Minimum 6 Characters Required"),
                                ]),
                                onChanged: (_val) {
                                  password = _val;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => HomePage()));

                                APIManager()
                                    .login(email, password)
                                    .then((value) {
                                  userDetail = value.userDetails[0];
                                  print(userDetail.runtimeType);
                                  if (value.status == 1) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(
                                                userDetail: userDetail)));
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 60.0),
                                shadowColor: Colors.black,
                                primary: Colors.black,
                              ),
                              child: Text(
                                "Sign In",
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Not Registered?",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: signin,
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.black,
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              // googleSignIn().whenComplete(() async {
                              //   User? user = auth.currentUser!;
                              //   Navigator.of(context).pushReplacement(
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               HomePage(uid: user.uid)));
                              // });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2.0),
                              child: Container(
                                width: 220.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF397AF3),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                        child: Container(
                                          color: Colors.white,
                                          child: Image.asset(
                                            "asset/google.png",
                                            height: 40.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.0,
                                      ),
                                      Text(
                                        "Sign-In with Google",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  )),
            ),
          ),
        ));
  }
}

/*TextField(
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                autofocus: false,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                        borderSide: BorderSide(width: 10.0)),
                    hintText: "Username",
                    suffixIcon: Icon(Icons.verified_user)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Password",
                      border: new OutlineInputBorder(
                          borderSide: BorderSide(width: 10.0)),
                      hintText: "Password",
                      suffixIcon: Icon(Icons.lock)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 60.0),
                        shadowColor: Colors.black,
                        primary: Colors.black,
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not Registered?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Signup()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),*/
