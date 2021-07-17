import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget tiles(Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: ListTile(
          minLeadingWidth: 80.0,
          leading: Image(
            height: MediaQuery.of(context).size.height * 0.1,
            image: AssetImage("asset/profile.png"),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 60.0, horizontal: 16.0),
          tileColor: color,
          title: Text(
            "Birds",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          trailing: Stack(
            children: [
              Positioned(
                left: 1.0,
                top: 4.0,
                child: Icon(Icons.play_circle_filled_rounded,
                    color: Colors.black38, size: 55.0),
              ),
              Icon(
                Icons.play_circle_filled_rounded,
                size: 55.0,
                color: Colors.white,
              ),
            ],
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
            title: Text(
              "Quiz",
              style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Comic Sans',
                  color: Colors.black),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              tiles(Colors.green),
              tiles(Colors.yellow),
              tiles(Colors.red),
              tiles(Colors.purple),
            ],
          ),
        ));
  }
}
