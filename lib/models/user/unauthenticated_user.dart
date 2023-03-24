import 'dart:convert';

import 'package:admin/models/user/authenticated_user.dart';
import 'package:admin/models/user/user.dart';
import 'package:admin/services/api.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/strapi_response.dart';
import 'package:get_storage/get_storage.dart';

class UnauthenticatedUser {
  UnauthenticatedUser({
    this.username = '',
    required this.email,
    required this.password,
  });

  String username;
  String email;
  String password;

  factory UnauthenticatedUser.fromJson(Map<String, dynamic> json) => UnauthenticatedUser(
    username: json["username"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "password": password,
  };

  Map<String, dynamic> toJsonLogin() => {
    "identifier": email,
    "password": password,
  };

  Future<AuthenticatedUser> login() async {
    StrapiResponse response = await API.post(
      page: 'auth/local',
      data: toJsonLogin(),
      dataRequestKey: '',
      customSuccessMessage: 'Login Success!',
      useToken: false,
      showLog: true
    );

    if (response.isSuccess) {
      final auth = AuthenticatedUser.fromJson(response.data);
      auth.saveUserToStorage();
      return auth;
    }

    return AuthenticatedUser(jwt: '', user: User());
  }
}