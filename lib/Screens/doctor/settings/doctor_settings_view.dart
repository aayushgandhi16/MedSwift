import 'package:flutter/material.dart';
import 'package:medswift/services/firebase/authentication.dart';

class DoctorSettingsView extends StatelessWidget {
  const DoctorSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Authentication().signOut();
      },
      title: const Text("Signout"),
      trailing: const Icon(Icons.logout),
    );
  }
}
