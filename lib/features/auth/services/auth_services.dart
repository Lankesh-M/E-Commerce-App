// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      print(user.toJson());
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

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          });
      print(res.body);
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const HomeScreen()));
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (rounte) => false,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
