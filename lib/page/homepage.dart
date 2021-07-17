import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/loginModel.dart';
import 'package:flutter_application_2/page/Settings.dart';
import 'package:flutter_application_2/page/leaderboard.dart';
import 'package:flutter_application_2/page/learning.dart';
import 'package:flutter_application_2/page/quiz.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  final UserDetail? userDetail;
  HomePage({Key? key, @required this.userDetail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(userDetail);
}

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class _HomePageState extends State<HomePage> {
  final UserDetail? userDetail;
  _HomePageState(this.userDetail);
  List<Widget> _buildScreens() {
    return [
      Learning(),
      Quiz(),
      LeaderBoard(),
      Settings(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.school,
          size: 30.0,
        ),
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        title: ("Home"),
        activeColorPrimary: Colors.orangeAccent,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.grading_outlined,
          size: 30.0,
        ),
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        title: ("Quiz"),
        activeColorPrimary: Colors.orangeAccent,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.leaderboard_rounded,
          size: 30.0,
        ),
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        contentPadding: 20.0,
        title: ("Leaderboards"),
        activeColorPrimary: Colors.orangeAccent,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.settings,
          size: 30.0,
        ),
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        title: "Settings",
        activeColorPrimary: Colors.orangeAccent,
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xff00A5F3),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Color(0xff00A5F3),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        curve: Curves.ease,
        duration: Duration(
          milliseconds: 200,
        ),
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style13,
    );
  }
}

/* 
bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "Learn",
            icon: Icon(
              Icons.school,
            ),
            backgroundColor: Color(0xff00A5F3),
          ),
          BottomNavigationBarItem(
            label: "Quiz",
            icon: Icon(Icons.grading_outlined),
            backgroundColor: Color(0xff00A5F3),
          ),
          BottomNavigationBarItem(
            label: "Leaderboard",
            icon: Icon(
              Icons.leaderboard,
            ),
            backgroundColor: Color(0xff00A5F3),
          ),
          BottomNavigationBarItem(
              label: "Setting",
              icon: Icon(
                Icons.settings,
              ),
              backgroundColor: Color(0xff00A5F3)),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        selectedLabelStyle: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500),
        onTap: _ontapped,
      ), 
      
      
      var _selectedIndex = 0;
  String _title = "";
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold);

  static List<Widget> widgetOptions = [
    Learning(),
    Quiz(),
    LeaderBoard(),
    Settings(),
  ];

  void _ontapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = "Learning";
  }
      
      */
