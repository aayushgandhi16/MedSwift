import 'package:flutter/material.dart';
import 'package:medswift/screens/authentication/signup/signup_view.dart';
import 'package:medswift/shared/route.dart';
import 'shared/body.dart';
import 'shared/header.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),
            const Body(),
            TextButton(
              onPressed: () {
                pushReplacementRoute(const SignUpView(), context);
              },
              child: const Text("Don't have an account?"),
            ),
          ],
        ),
      ),
    );
  }
}
