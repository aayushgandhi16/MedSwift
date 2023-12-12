import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medswift/services/firebase/authentication.dart';

class PatientSettingsView extends StatelessWidget {
  const PatientSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          onTap: () {},
          title: const Text("Edit profile"),
          trailing: const Icon(Icons.account_circle),
        ),
        ListTile(
          onTap: () {
            showAboutDialog(
              applicationName: "Medswift",
              context: context,
            );
          },
          title: const Text("About app"),
          trailing: const Icon(Icons.info),
        ),
        const Divider(),
        ListTile(
          onTap: () async {
            await Authentication().signOut();
            await GoogleSignIn().signOut();
          },
          title: const Text("Signout"),
          trailing: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
