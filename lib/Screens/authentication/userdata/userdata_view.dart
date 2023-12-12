import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medswift/controller/authentication_ctr.dart';
import 'package:medswift/shared/colors.dart';
import 'package:medswift/shared/route.dart';
import 'package:medswift/shared/snack_bar_widget.dart';

import '../../../services/firebase/authentication.dart';
import '../../landing_view.dart';

final _authCtr = Get.put(AuthCtr());

class UserDataView extends StatelessWidget {
  const UserDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    onSignUp() async {
      try {
        await _authCtr.createUser().then(
          (value) {
            pushAndRemoveRoute(const LandingView(), context);
          },
        );
      } catch (err) {
        showSnackBar(err.toString(), context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
        title: const Text("User Information"),
        leading: BackButton(
          onPressed: () async {
            await Authentication().signOut();
            await GoogleSignIn().signOut();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _authCtr.name,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _authCtr.age,
                  decoration: const InputDecoration(
                    hintText: "Age",
                    labelText: "Age",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _authCtr.height,
                  decoration: const InputDecoration(
                    hintText: "Height",
                    labelText: "Height",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _authCtr.weight,
                  decoration: const InputDecoration(
                    hintText: "Weight",
                    labelText: "Weight",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Gender :"),
                        GetBuilder(
                          init: _authCtr,
                          builder: (__) {
                            return DropdownButton<String>(
                              underline: Container(),
                              value: _authCtr.gender,
                              items: ["Male", "Female"]
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                _authCtr.setGender(value!);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Blood group :"),
                        GetBuilder(
                          init: _authCtr,
                          builder: (__) {
                            return DropdownButton<String>(
                              underline: Container(),
                              value: _authCtr.bloodGroup,
                              items: [
                                "O+ve",
                                "O-ve",
                                "A+ve",
                                "A-ve",
                                "B+ve",
                                "B-ve",
                                "AB+ve",
                                "AB-ve"
                              ]
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                _authCtr.setBloodGroup(value!);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _authCtr.address,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: "Address",
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _authCtr.insurances,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: "Insurances (if any)",
                    labelText: "Insurances",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _authCtr.diseases,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: "Diseases (if any)",
                    labelText: "Diseases",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(secondary),
                    ),
                    onPressed: onSignUp,
                    child: const Text("Create Account"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
