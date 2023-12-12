import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medswift/controller/authentication_ctr.dart';
import 'package:medswift/controller/speech_to_text_ctr.dart';
import 'package:medswift/models/prescription_model.dart';
import 'package:medswift/services/firebase/authentication.dart';
import 'package:medswift/shared/colors.dart';
import 'package:medswift/shared/route.dart';
import 'package:medswift/shared/snack_bar_widget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:medswift/services/firebase/database.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/user_model.dart';

final _speechToTextCtr = Get.put(SpeechToTextCtr());
final _authCtr = Get.put(AuthCtr());

class PrescriptionView extends StatefulWidget {
  const PrescriptionView({super.key});

  @override
  State<PrescriptionView> createState() => _PrescriptionViewState();
}

class _PrescriptionViewState extends State<PrescriptionView> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  final _text = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) => setState(() {
            _text.text = result.recognizedWords;
          }),
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Speech to text"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final users = await Database().readAllUserData();
                    showSearch(
                      context: context,
                      delegate: UsersSearchBar(users),
                    );
                  },
                  child: const Text("Select patient"),
                ),
              ),
              GetBuilder(
                init: _speechToTextCtr,
                builder: (_) {
                  if (_speechToTextCtr.patient == null) {
                    return Container();
                  }
                  return ExpansionTile(
                    title: const Text("Patient details"),
                    children: [
                      ListTile(
                        title: const Text("Name :"),
                        subtitle: Text(_speechToTextCtr.patient!.name),
                      ),
                      ListTile(
                        title: const Text("Email :"),
                        subtitle: Text(_speechToTextCtr.patient!.email),
                      ),
                      ListTile(
                        title: const Text("Blood group :"),
                        subtitle: Text(_speechToTextCtr.patient!.bloodGroup),
                      ),
                    ],
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Prescription : ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextFormField(
                controller: _text,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_speechToTextCtr.patient == null) {
                      showSnackBar("Please select a patient", context);
                      return;
                    }
                    var id = const Uuid().v4();
                    var timeStamp = DateTime.now().toIso8601String();
                    var authorId = FirebaseAuth.instance.currentUser!.uid;
                    var patientId = _speechToTextCtr.patient!.id;
                    final author = await Database().readUserData(authorId);
                    final patient = await Database().readUserData(patientId);

                    await Database()
                        .createPrescription(
                      PrescriptionModel(
                        id: id,
                        authorId: authorId,
                        authorName: author!.name,
                        patientName: patient!.name,
                        patientId: patientId,
                        prescription: _text.text,
                        timeStamp: timeStamp,
                      ),
                    )
                        .then((value) {
                      Navigator.pop(context);
                      showSnackBar("Prescription added successfully", context);
                    });
                  },
                  child: const Text("Confirm"),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        backgroundColor: secondary,
        child: const Icon(Icons.mic),
      ),
    );
  }
}

class UsersSearchBar extends SearchDelegate {
  final List<UserModel> users;

  UsersSearchBar(this.users);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserModel> matchQuery = [];
    for (var user in users) {
      var compare = (user.name + user.id + user.email).toLowerCase();
      if (compare.contains(query.toLowerCase())) {
        matchQuery.add(user);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (_, index) {
        var user = matchQuery[index];
        return ListTile(
          onTap: () {
            _speechToTextCtr.setpatient(user);
            Navigator.pop(context);
          },
          title: Text("Name : ${user.name}"),
          subtitle: Text("Email : ${user.email}"),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<UserModel> matchQuery = [];
    for (var user in users) {
      var compare = (user.name + user.id + user.email).toLowerCase();
      if (compare.contains(query.toLowerCase())) {
        matchQuery.add(user);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (_, index) {
        var user = matchQuery[index];
        return ListTile(
          onTap: () {
            _speechToTextCtr.setpatient(user);
            Navigator.pop(context);
          },
          title: Text("Name : ${user.name}"),
          subtitle: Text("Email : ${user.email}"),
        );
      },
    );
  }
}
