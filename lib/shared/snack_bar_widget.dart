import 'package:flutter/material.dart';

showSnackBar(String data, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(data),
    ),
  );
}
