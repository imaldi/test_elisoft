// To parse this JSON data, do
//
//     final userLoginResponse = userLoginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

UserLoginResponse userLoginResponseFromJson(String str) => UserLoginResponse.fromJson(json.decode(str));

String userLoginResponseToJson(UserLoginResponse data) => json.encode(data.toJson());

class UserLoginResponse extends Equatable{
  UserLoginResponse({
    this.code,
    this.status,
    this.message,
    this.user,
  });

  int? code;
  bool? status;
  String? message;
  User? user;

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) => UserLoginResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "user": user?.toJson(),
  };

  @override
  List<Object?> get props => [
    code,
    status,
    message,
    user
  ];
}

class User extends Equatable {
  User({
    this.name,
    this.email,
    this.phoneNumber,
    this.created,
    this.uuid,
  });

  String? name;
  String? email;
  String? phoneNumber;
  Created? created;
  String? uuid;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    created: Created.fromJson(json["created"]),
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "created": created?.toJson(),
    "uuid": uuid,
  };

  @override
  List<Object?> get props => [
    name,
    email,
    phoneNumber,
    created,
    uuid,
  ];
}

class Created extends Equatable{
  Created({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  DateTime? date;
  int? timezoneType;
  String? timezone;

  factory Created.fromJson(Map<String, dynamic> json) => Created(
    date: DateTime.parse(json["date"]),
    timezoneType: json["timezone_type"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "timezone_type": timezoneType,
    "timezone": timezone,
  };

  @override
  List<Object?> get props => [
    date,
    timezone,
    timezoneType,
  ];
}
