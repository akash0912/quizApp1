import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  Widget tiles() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: Image(
            height: MediaQuery.of(context).size.height * 0.05,
            image: AssetImage("asset/profile.png"),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          tileColor: Colors.white,
          title: Text(
            "User 1",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          trailing: Text(
            "00",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget profileImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 0.0, right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: InkWell(
          child: Container(
            color: Colors.white,
            child: Image(
              image: AssetImage("asset/profile.png"),
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff00A5F3),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Color(0xff00A5F3),
            elevation: 0.0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: [profileImage()],
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LeaderBoard",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: "Comic Sans",
                      color: Colors.black),
                ),
              ],
            ),
            /* bottom: PreferredSize(
                child: Container(
                  color: Color(0xff00A5F3),
                  height: 4.0,
                ),
                preferredSize: Size.fromHeight(6.0)), */
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              tiles(),
              tiles(),
              tiles(),
              tiles(),
              tiles(),
              tiles(),
              tiles(),
              tiles(),
              tiles(),
              tiles(),
              tiles(),
              tiles(),
              tiles(),
            ],
          ),
        ));
  }
}
