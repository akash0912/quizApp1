import 'dart:convert';
import 'package:flutter_application_2/model/loginModel.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_application_2/model/avatar.dart';

class APIManager {
  Future<Avatar> getAvatar() async {
    var client = http.Client();
    var avtrModel;

    try {
      var response = await client
          .get(Uri.parse("https://mangukiyagroup.com/api/avatar_list.php"));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);

        avtrModel = Avatar.fromJson(jsonMap);

        print(jsonMap);
      }
    } catch (Exception) {
      return avtrModel;
    }
    return avtrModel;
  }

  Future<Userdetails> login(String username, String password) async {
    var loginModel;
    var testData = {
      "username": username,
      "password": password,
      "device_type": "Android"
    };
    var client = http.Client();

    try {
      var response = await client.post(
          Uri.parse("https://mangukiyagroup.com/api/login_api.php"),
          body: testData);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);

        loginModel = Userdetails.fromJson(jsonMap);

        print("This is response");
        print(jsonMap);
      }
    } catch (Exception) {
      print(Exception);
      return loginModel;
    }
    return loginModel;
  }
}
