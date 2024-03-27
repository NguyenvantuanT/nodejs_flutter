import 'dart:convert';

import 'package:fontend/model/user_model.dart';
import 'package:http/http.dart' as http;

class Repo {
  String dataUrl = 'http://localhost:8000';
  var client = http.Client();

  Future<List<UserModel>> getUser() async {
    var response = await client.get(Uri.parse('$dataUrl/v1/user'));
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      List<UserModel> users = result.map((item) => UserModel.fromJson(item)).toList();
      return users;
    } else {
      throw Exception("Lỗi khi gửi yêu cầu POST");
    }
  }

  Future<bool> postUser(UserModel object) async {
    try {
      var response = await client.post(Uri.parse('$dataUrl/v1/user'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(object));
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Fail");
      }
    } catch (e) {
      throw Exception("Lỗi khi gửi yêu cầu POST");
    }
  }

  Future<String> deleteUser(String user) async {
    try {
      await client.delete(Uri.parse('$dataUrl/v1/user/$user'));
      return "Success";
    } catch (e) {
      throw Exception("Lỗi khi gửi yêu cầu POST");
    }
  }

  Future<bool> updateUser(String user, UserModel object) async {
    try {
      await client.put(Uri.parse('$dataUrl/v1/user/$user'),
          body: jsonEncode(object),
          headers: {
            "Content-Type": "application/json",
          });
      return true;
    } catch (e) {
      throw Exception("Lỗi khi gửi yêu cầu POST");
    }
  }

  Future<List<UserModel>> searchUser(int age) async {
    try {
      var response = await client.get(Uri.parse('$dataUrl/v1/user/search?age=$age'));
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        List<UserModel> userModel = result.map((e) => UserModel.fromJson(e)).toList();
        return userModel;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Lỗi khi gửi yêu cầu POST");
    }
  }
}
