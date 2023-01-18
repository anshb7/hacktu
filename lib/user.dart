import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  String name = "";
  String email = "";
  String gender = "";
  String phone_no = "";
  String hostel = "";
  String team = "";
  User(
      {required this.name,
      required this.email,
      required this.gender,
      required this.hostel,
      required this.phone_no,
      required this.team});
  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "gender": gender,
        "phone_no": phone_no,
        "hostel": hostel,
        "team": team
      };
  static User fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        email: json['email'],
        gender: json['gender'],
        hostel: json['hostel'],
        phone_no: json['phone_no'],
        team: json['team']);
  }
}
