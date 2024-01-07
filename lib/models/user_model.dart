
import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel {

  String name,password,token;

  UserModel({required this.name,required this.password,required this.token});

  //
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json['name'] as String,
    password: json['password'] as String,
    token: json['token'] as String,

  );


  factory UserModel.fromJsonString(String string) {
    try {
      Map<String, dynamic> map = jsonDecode(string) as Map<String, dynamic>;
      return UserModel.fromJson(map);
    } catch (e){
      return UserModel(name: '', password: '', token: '');
    }
  }


  Map<String, dynamic> toJson() => {
    'name': name,
    'password': password,
    'token': token,
  };



}