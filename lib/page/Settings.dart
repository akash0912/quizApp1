import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void _launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch URL");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00A5F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(
              fontFamily: "Pangolin-Regular",
              color: Colors.black,
              fontSize: 30.0),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: ListTile(
                  onTap: () => _launchUrl("https://google.com"),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 16.0),
                  tileColor: Colors.white,
                  title: Text(
                    "Privacy Policy",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: ListTile(
                  onTap: () => _launchUrl("tel: +91 98986 14702"),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 16.0),
                  tileColor: Colors.white,
                  title: Text(
                    "Terms & Conditions",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: ListTile(
                  onTap: () => _launchUrl("sms:djkfhskf"),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 16.0),
                  tileColor: Colors.white,
                  title: Text(
                    "About Us",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
