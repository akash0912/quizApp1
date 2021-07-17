import 'dart:convert';

Avatar avatarFromJson(String str) => Avatar.fromJson(json.decode(str));

String avatarToJson(Avatar data) => json.encode(data.toJson());

class Avatar {
  Avatar({
    required this.avatarList,
    required this.status,
  });

  List<AvatarList> avatarList;
  int status;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        avatarList: List<AvatarList>.from(
            json["avatar_list"].map((x) => AvatarList.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "avatar_list": List<dynamic>.from(avatarList.map((x) => x.toJson())),
        "status": status,
      };
}

class AvatarList {
  AvatarList({
    required this.id,
    required this.avatarName,
  });

  String id;
  String avatarName;

  factory AvatarList.fromJson(Map<String, dynamic> json) => AvatarList(
        id: json["id"],
        avatarName: json["avatar_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar_name": avatarName,
      };
}
