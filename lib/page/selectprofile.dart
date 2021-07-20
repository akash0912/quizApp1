import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/avatar.dart';
import 'package:flutter_application_2/page/homepage.dart';
import 'package:flutter_application_2/page/learning.dart';
import 'package:flutter_application_2/page/quiz.dart';
import 'package:flutter_application_2/services/api_manager.dart';
import 'package:flutter_application_2/controller/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectProfile extends StatefulWidget {
  SelectProfile({Key? key}) : super(key: key);

  @override
  _SelectProfileState createState() => _SelectProfileState();
}

class _SelectProfileState extends State<SelectProfile> {
  Future<Avatar>? _avtrModel;
  User? user = auth.currentUser;
  bool added = false;
  var avtCollection = FirebaseFirestore.instance.collection("avatar");

  DocumentSnapshot? ds;
  String avtarname =
      "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";

  Widget image(String url) {
    return Image.network(
      url,
      fit: BoxFit.fill,
    );
  }

  Future<bool> selected() {
    if (added) {
      avtCollection.doc(user!.uid).collection("avatarName").doc(ds!.id).update({
        "avatarName": avtarname,
        "time": DateTime.now(),
      });
      return Future.value(true);
    } else {
      var userid = user!.uid;
      avtCollection.doc(userid).collection("avatarName").add({
        "avatarName": avtarname,
        "time": DateTime.now(),
      });
      return Future.value(true);
    }
  }

  @override
  void initState() {
    super.initState();
    _avtrModel = APIManager().getAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00A5F3),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xff00A5F3),
        elevation: 0.0,
        title: Text(
          "Select Profile Picture",
          style: TextStyle(fontSize: 25.0, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    height: 100.0,
                    width: 100.0,
                    child: image(avtarname),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.maybeOf(context)!.size.height * 0.46,
                width: MediaQuery.maybeOf(context)!.size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.black.withOpacity(0.2),
                ),
                child: FutureBuilder<Avatar>(
                  future: _avtrModel,
                  builder: (context, snapshot) {
                    return GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(
                        9,
                        (index) {
                          var avatar = snapshot.data!.avatarList[index];
                          return Center(
                            child: InkWell(
                              child: Image.network(
                                avatar.avatarName,
                                width: MediaQuery.of(context).size.width * 0.25,
                              ),
                              onTap: () {
                                setState(() {
                                  avtarname = avatar.avatarName;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: ElevatedButton(
                  onPressed: () => selected().whenComplete(() =>
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Quiz()))),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
                    shadowColor: Colors.black,
                    primary: Colors.black,
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
