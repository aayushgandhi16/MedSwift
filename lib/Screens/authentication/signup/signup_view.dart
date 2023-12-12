import 'package:flutter/material.dart';
import 'package:medswift/screens/authentication/signin/signin_view.dart';
import 'package:medswift/shared/route.dart';
import 'shared/body.dart';
import 'shared/header.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
                pushReplacementRoute(const SignInView(), context);
              },
              child: const Text("Already have an account?"),
            ),
          ],
        ),
      ),
    );
  }
}
