import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medswift/models/user_model.dart';
import 'package:medswift/screens/authentication/signin/signin_view.dart';
import 'package:medswift/screens/authentication/userdata/userdata_view.dart';
import 'package:medswift/screens/patient/patient_landing_view.dart';
import 'package:medswift/controller/authentication_ctr.dart';
import 'package:medswift/shared/loading_widget.dart';

import 'doctor/doctor_landing_view.dart';

final _authCtr = Get.put(AuthCtr());

class LandingView extends StatelessWidget {
  const LandingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authCtr.getUserChanges,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.data != null) {
          return FutureBuilder(
            future: _authCtr.isUserCreated(snapshot.data!.uid),
            builder: (context, AsyncSnapshot<UserModel?> userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: LoadingWidget(),
                );
              }
              if (userSnapshot.hasData) {
                return (userSnapshot.data!.role == "DOCTOR")
                    ? const DoctorLandingView()
                    : const PatientLandingView();
              }
              return const UserDataView();
            },
          );
        }
        return const SignInView();
      },
    );
  }
}
