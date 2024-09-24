import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  print(text);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
