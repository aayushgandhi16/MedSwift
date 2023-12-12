import 'package:flutter/material.dart';
import 'package:medswift/models/prescription_model.dart';
import 'package:medswift/models/report_model.dart';
import 'package:medswift/services/firebase/authentication.dart';
import 'package:medswift/services/firebase/database.dart';
import 'package:medswift/shared/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientPrescriptionsView extends StatelessWidget {
  const PatientPrescriptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Database().readListOfPrescriptions(Authentication().id()),
      builder: (context, AsyncSnapshot<List<PrescriptionModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) {
              final data = snapshot.data![index];
              return ExpansionTile(
                title: Text("By : ${data.authorName}"),
                children: [
                  ListTile(
                    title: Text("Date"),
                    subtitle: Text("${data.timeStamp}"),
                  ),
                  ListTile(
                    title: Text("Prescription"),
                    subtitle: Text("${data.prescription}"),
                  ),
                ],
              );
            },
          );
        }
        return const LoadingWidget();
      },
    );
  }
}
