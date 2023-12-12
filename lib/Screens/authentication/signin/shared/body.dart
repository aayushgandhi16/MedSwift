import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:medswift/screens/landing_view.dart';
import 'package:medswift/controller/authentication_ctr.dart';
import 'package:medswift/shared/colors.dart';
import 'package:medswift/shared/route.dart';
import 'package:medswift/shared/snack_bar_widget.dart';

final _authCtr = Get.put(AuthCtr());

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();

    onSignIn() async {
      if (formkey.currentState!.validate()) {
        try {
          await _authCtr.signInUsingEmailAndPassword().then(
                (value) => pushAndRemoveRoute(
                  const LandingView(),
                  context,
                ),
              );
        } catch (err) {
          showSnackBar(err.toString(), context);
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: _authCtr.email,
                decoration: const InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter an email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _authCtr.password,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onSignIn,
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: secondary,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("OR"),
              ),
              SizedBox(
                width: double.infinity,
                child: SignInButton(
                  Buttons.Google,
                  text: "Sign In with Google",
                  onPressed: () async {
                    await _authCtr.signInWithGoogle().then(
                          (value) => pushAndRemoveRoute(
                            const LandingView(),
                            context,
                          ),
                        );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
