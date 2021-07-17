import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import "package:flutter/material.dart";
import 'package:flutter_application_2/page/signin.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(accentColor: Colors.redAccent),
      home: loading(),
    );
  }
}

// ignore: camel_case_types
class loading extends StatefulWidget {
  loading({Key? key}) : super(key: key);

  @override
  _loadingState createState() => _loadingState();
}

// ignore: camel_case_types
class _loadingState extends State<loading> {
  Connectivity connectivity = Connectivity();
  ConnectivityResult? previous = ConnectivityResult.none;
  bool shownDialog = false;

  Future<bool> checkInternet() async {
    try {
      var res = await InternetAddress.lookup("google.com");
      if (res.isNotEmpty && res[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } on SocketException catch (_) {
      return Future.value(false);
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      InternetAddress.lookup("google.com").then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => signin()));
        } else {
          _showDialog();
        }
      }).catchError((error) {
        _showDialog();
      });
    } on SocketException catch (_) {
      _showDialog();
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult res) {
      if (res == ConnectivityResult.none) {
        shownDialog = true;
        _showDialog();
      } else {
        if (previous == ConnectivityResult.none) {
          if (shownDialog == true) {
            shownDialog = false;
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => signin()));
          }
        }
      }
      previous = res;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Container(
          height: 120.0,
          child: Column(
            children: [
              Icon(
                Icons.warning_rounded,
                color: Colors.blueAccent,
                size: 55.0,
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                "OOPS!",
                style: TextStyle(fontSize: 20.0),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Text("No Internet Connection"),
            ],
          ),
        ),
        title: Text("ERROR"),
        actions: [
          TextButton(
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: Text(
              "Exit",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              checkInternet();
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* Image(
              image: AssetImage(
                "asset/splash.jpg",
              ),
            ), */
          ],
        ),
      )),
    );
  }
}
