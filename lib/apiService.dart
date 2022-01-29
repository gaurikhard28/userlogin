import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'userDetails.dart';
import 'package:http/http.dart' as http;

class ApiService {
}
  final String apiUrl = "";

  Future<List<userDetails>> getUsers() async {
    Response res = await http.post(Uri.parse("https://sandbox.9930i.com/admin/fetch_users"));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<userDetails> users = body.map((dynamic item) => userDetails.fromJson(item)).toList();
      return users;
    } else {
      throw "Failed to load cases list";
    }
  }


  Future<userDetails> addUser(userDetails users) async {
    Map data = {
      'Authorization': users.Authorization,
      'name': users.name,
      'address': users.address,
      'phone': users.phone,
      'email': users.email
    };

    final Response response = await http.post(Uri.parse("https://sandbox.9930i.com/admin/add_users")
     ,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return userDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

  Future<userDetails> updateUser(String id, userDetails users) async {
    Map data = {
      'Authorization': users.Authorization,
      'name': users.name,
      'address': users.address,
      'phone': users.phone,
      'email': users.email
    };

    final Response response = await http.post(Uri.parse("https://sandbox.9930i.com/admin/update_user")
      ,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return userDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteUser(String id,userDetails users) async {
    Map data = {
      'Authorization': users.Authorization,
    };
    Response res = await http.post(Uri.parse("https://sandbox.9930i.com/admin/delete_user"),
    body: jsonEncode(data));
    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }


