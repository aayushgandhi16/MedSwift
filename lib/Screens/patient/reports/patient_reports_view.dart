import 'package:flutter/material.dart';
import 'package:medswift/models/report_model.dart';
import 'package:medswift/services/firebase/authentication.dart';
import 'package:medswift/services/firebase/database.dart';
import 'package:medswift/shared/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientReportsView extends StatelessWidget {
  const PatientReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Database().readListOfReports(Authentication().id()),
      builder: (context, AsyncSnapshot<List<ReportModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) {
              final report = snapshot.data![index];
              return ListTile(
                onTap: () async {
                  await launchUrl(
                    Uri.parse(report.url),
                    mode: LaunchMode.externalApplication,
                  );
                },
                leading: const Icon(Icons.file_copy),
                title: Text(report.title),
              );
            },
          );
        }
        return const LoadingWidget();
      },
    );
  }
}
