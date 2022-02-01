import 'dart:convert';
import 'package:example/updateDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'userDetails.dart';
import 'package:http/http.dart' as http;

class ApiService {

  final String apiUrl = "";

  Future<List<userDetails>> getUsers(Authorization) async {
    Map<String, String> data = {
      'Authorization': Authorization,
    };
    Response res = await http.post(
        Uri.parse("https://sandbox.9930i.com/admin/fetch_users"),
        headers: data,
        encoding: Encoding.getByName("utf-8"));

    print(Authorization);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<userDetails> users = body.map((dynamic item) =>
          userDetails.fromJson(item)).toList();

      return users;
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<List<Datum>> getUsersWithId(Authorization) async {
    Map<String, String> data = {
      'Authorization': Authorization,
    };
    Response res = await http.post(
        Uri.parse("https://sandbox.9930i.com/admin/fetch_users"),
        headers: data,
        encoding: Encoding.getByName("utf-8"));
    print(res.body);
    print(Authorization);
    if (res.statusCode == 200) {

     var body = detailsFromJson(res.body);
      List<Datum> updateUser = body.data!;
      return updateUser;
    } else {
      throw "Failed to load cases list";
    }
  }


  Future<userDetails> addUser(userDetails users) async {
    getUsers(users);
    Map<String, String> datahead = {
      'Authorization': users.Authorization,
    };
    Map data = {
      'name': users.name,
      'address': users.address,
      'phone': users.phone,
      'email': users.email
    };

    final Response response = await http.post(
      Uri.parse("https://sandbox.9930i.com/admin/add_users")
      ,
      headers:datahead,

      body: jsonEncode(data),
    );
    print(response.body);
    print (users.Authorization);
    if (response.statusCode == 200) {

      return userDetails.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to post cases');
    }
  }

  Future<Details> updateUser( String id,userDetails users) async {
    Map data = {
      'Authorization': users.Authorization,
      'id': id,
      'name': users.name,
      'address': users.address,
      'phone': users.phone,
      'email': users.email
    };

    final Response response = await http.post(
      Uri.parse("https://sandbox.9930i.com/admin/update_user")
      ,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {

      return Details.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteUser(String id, String Authorization) async {
    Map data = {
      'Authorization': Authorization,
      'id': id,
    };
    Response res = await http.post(
        Uri.parse("https://sandbox.9930i.com/admin/delete_user"),
        body: jsonEncode(data));
    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }

}
