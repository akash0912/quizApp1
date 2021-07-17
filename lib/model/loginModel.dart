// To parse this JSON data, do
//
//     final userdetails = userdetailsFromJson(jsonString);

import 'dart:convert';

Userdetails userdetailsFromJson(String str) =>
    Userdetails.fromJson(json.decode(str));

String userdetailsToJson(Userdetails data) => json.encode(data.toJson());

class Userdetails {
  Userdetails({
    required this.userDetails,
    required this.status,
  });

  List<UserDetail> userDetails;
  int status;

  factory Userdetails.fromJson(Map<String, dynamic> json) => Userdetails(
        userDetails: List<UserDetail>.from(
            json["user_details"].map((x) => UserDetail.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_details": List<dynamic>.from(userDetails.map((x) => x.toJson())),
        "status": status,
      };
}

class UserDetail {
  UserDetail({
    required this.id,
    required this.username,
    required this.avatar,
    required this.deviceType,
    required this.score,
    required this.fullname,
  });

  String id;
  String username;
  String avatar;
  String deviceType;
  String score;
  String fullname;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        username: json["username"],
        avatar: json["avatar"],
        deviceType: json["device_type"],
        score: json["score"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar": avatar,
        "device_type": deviceType,
        "score": score,
        "fullname": fullname,
      };
}
