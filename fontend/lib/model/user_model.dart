// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String? id;
    String? name;
    String? age;

    UserModel({
     this.id,
     this.name,
     this.age,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"] ,
        name: json["name"],
        age: json["age"],
    );

    Map<String, dynamic> toJson() => {
        // "_id": id ?? "",
        "name": name,
        "age": age,
    };
}
