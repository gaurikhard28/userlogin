

// To parse this JSON data, do
//
//     final details = detailsFromJson(jsonString);

import 'dart:convert';

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
  Details({
   this.status,
    this.msg,
    this.size,
    this.data,
  });

  int? status;
  String? msg;
  int? size;
  List<Datum>? data;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    status: json["status"],
    msg: json["msg"],
    size: json["size"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "size": size,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.email,
    this.address,
  });

  int? id;
  int? userId;
  String? name;
  String? phone;
  String?  email;
  String? address;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "phone": phone,
    "email": email,
    "address": address,
  };
}
