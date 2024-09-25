import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  void signUpUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      User user = User(
          name: name,
          id: '',
          email: email,
          password: password,
          token: '',
          address: '',
          type: '');

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          //For checking purporse
          // body: jsonEncode({
          //   'name': 'John Doe',
          //   'email': 'johndoe@example.com',
          //   'password': '123456',
          //   'address': '123 Main St',
          //   'type': 'user'
          // }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          });
      // print(user.toJson());
      // print(res.body);
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account Created!, Login with the same Credential!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
