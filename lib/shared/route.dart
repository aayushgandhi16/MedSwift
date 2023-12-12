import 'package:flutter/material.dart';

pushRoute(Widget widget, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => widget),
  );
}

pushAndRemoveRoute(Widget widget, BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => widget),
    (route) => false,
  );
}

pushReplacementRoute(Widget widget, BuildContext context) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => widget),
  );
}

