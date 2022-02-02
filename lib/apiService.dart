import 'dart:convert';
import 'package:example/updateDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiService {



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


  Future<Datum> addUser(Datum users, String Authorization) async {
    Map<String, String> datahead = {
      'Authorization': Authorization,
    };
    print(users.phone);
    Map data = {
      'name': users.name,
      'address': users.address,
      'phone': users.phone,
      'email': users.email
    };
 print(jsonEncode(data));
    final Response response = await http.post(
      Uri.parse("https://sandbox.9930i.com/admin/add_users"),
      headers:datahead,
      body: (data),
    );
    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if (resposne['status'] == 0) {

      }
      return Datum.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to post cases');
    }
  }

  Future<Datum> updateUser( String id,Datum users, String Authorization) async {

    Map<String, String> datahead = {
      'Authorization': Authorization,
    };Map data = {

      'id':id,
      'name': users.name,
      'address': users.address,
      'phone': users.phone,
      'email': users.email
    };

    final Response response = await http.post(
      Uri.parse("https://sandbox.9930i.com/admin/update_user")
      ,
      headers: datahead,
      body: (data),
    );
    if (response.statusCode == 200) {

      return Datum.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteUser(String id, String Authorization) async {
    Map<String, String> datahead = {
      'Authorization': Authorization,
    };
    Map data = {

      'id': id,
    };

    Response res = await http.post(
        Uri.parse("https://sandbox.9930i.com/admin/delete_user"),
        headers: datahead,
        body: (data));
    print(res.body);
    print(id);
    if (res.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(res.body);



    } else {
      throw "Failed to delete a case.";

    }

  }

}
