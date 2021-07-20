import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/loginModel.dart';
import 'package:flutter_application_2/page/selectprofile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'first.dart';
import 'package:flutter_application_2/services/api_manager.dart';

class Learning extends StatefulWidget {
  final UserDetail? userDetail;

  Learning({Key? key, this.userDetail}) : super(key: key);

  @override
  _LearningState createState() => _LearningState(userDetail);
}

class _LearningState extends State<Learning> {
  final UserDetail? userDetail;

  _LearningState(this.userDetail);

  @override
  void initState() {
    super.initState();
  }

  Widget tiles(Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: ListTile(
          onTap: () => pushNewScreen(
            context,
            screen: First(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          ),
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
    var profileimgae = userDetail!.avatar;
    print(userDetail!.avatar);
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 0.0, right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: InkWell(
          child: Container(
            color: Colors.white,
            child: Image.network(profileimgae),
          ),
          onTap: () => pushNewScreen(
            context,
            screen: SelectProfile(),
            withNavBar: true,
          ),
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
              "Learning",
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
