import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medswift/controller/doctor_reports_ctr.dart';
import 'package:medswift/screens/doctor/reports/widgets/reports_search_button.dart';
import 'package:medswift/shared/snack_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

final _reportsCtr = Get.put(DoctorReportsCtr());

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: GetBuilder(
            init: _reportsCtr,
            builder: (__) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter Patient ID :",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    controller: _reportsCtr.id,
                    decoration: const InputDecoration(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await _reportsCtr.setInfo();
                        },
                        child: const Text("Get information"),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ReportSearchButton(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.qr_code),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_reportsCtr.patient == null) {
                          showSnackBar("Add a user", context);
                          return;
                        }

                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return const UploadReportModalSheet();
                          },
                        );
                      },
                      child: const Text("Add report"),
                    ),
                  ),
                  const PatientData(),
                ],
              );
            }),
      ),
    );
  }
}

class PatientData extends StatelessWidget {
  const PatientData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _reportsCtr,
      builder: (_) {
        if (_reportsCtr.patient != null) {
          return Column(
            children: [
              ExpansionTile(
                title: const Text("Patient details"),
                children: [
                  ListTile(
                    title: const Text("Name :"),
                    subtitle: Text(_reportsCtr.patient!.name),
                  ),
                  ListTile(
                    title: const Text("Email :"),
                    subtitle: Text(_reportsCtr.patient!.email),
                  ),
                  ListTile(
                    title: const Text("Blood Group :"),
                    subtitle: Text(_reportsCtr.patient!.bloodGroup),
                  ),
                  ListTile(
                    title: const Text("Address :"),
                    subtitle: Text(_reportsCtr.patient!.address),
                  ),
                  ListTile(
                    title: const Text("Insurances :"),
                    subtitle: Text(_reportsCtr.patient!.insurances ?? ""),
                  ),
                  ListTile(
                    title: const Text("Diseases :"),
                    subtitle: Text(_reportsCtr.patient!.diseases ?? ""),
                  ),
                  ListTile(
                    title: const Text("Current Medication :"),
                    subtitle: Text(
                      _reportsCtr.patient!.currentMedications ?? "",
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text("Reports"),
                children: _reportsCtr.reports!.map(
                  (report) {
                    return ListTile(
                      onTap: () async {
                        await launchUrl(
                          Uri.parse(report.url),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      title: Text(report.title),
                      subtitle: Text("Doctor : ${report.authorName}"),
                      leading: const Icon(Icons.file_copy),
                    );
                  },
                ).toList(),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class UploadReportModalSheet extends StatelessWidget {
  const UploadReportModalSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _reportsCtr,
      builder: (__) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_reportsCtr.patient == null) {
                      showSnackBar("Add a patient", context);
                      return;
                    }
                    await _reportsCtr.selectFiles();
                  },
                  label: const Text("Select files"),
                  icon: const Icon(Icons.file_copy),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_reportsCtr.patient == null) {
                      showSnackBar("Add a user", context);
                      return;
                    }
                    if (_reportsCtr.selectedFiles.isEmpty) {
                      showSnackBar("Add files to upload", context);
                      return;
                    }
                    await _reportsCtr.uploadFiles();
                  },
                  label: const Text("Upload files"),
                  icon: const Icon(Icons.upload_file),
                ),
              ),
              const Text(
                "Selected file :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Builder(
                builder: (_) {
                  if (_reportsCtr.selectedFiles.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _reportsCtr.selectedFiles.length,
                      itemBuilder: (_, index) {
                        final file = _reportsCtr.selectedFiles[index];
                        return ListTile(
                          leading: const Icon(Icons.file_copy),
                          title: Text(file.title),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
