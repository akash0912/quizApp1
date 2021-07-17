import 'package:flutter/material.dart';

class First extends StatefulWidget {
  First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xff00A5F3),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(
            "Learning",
            style: TextStyle(
                fontSize: 30.0, fontFamily: 'Comic Sans', color: Colors.black),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Scrollbar(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width * 0.9,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              10,
              (index) {
                return SingleChildScrollView(
                  child: Center(
                    /*  height: MediaQuery.of(context).size.height * 0.2,
                    margin: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    color: Colors.yellowAccent, */
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        alignment: Alignment.center,
                        color: Colors.yellowAccent,
                        child: InkWell(
                          child: Image(
                            image: AssetImage("asset/profile.png"),
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                          onTap: () {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
