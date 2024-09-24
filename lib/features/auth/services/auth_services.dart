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
          name: "",
          id: '',
          email: '',
          password: '',
          token: '',
          address: '',
          type: '');

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          });

      print(res.body);
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
