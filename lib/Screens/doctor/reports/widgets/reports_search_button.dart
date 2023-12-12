import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medswift/models/user_model.dart';

import '../../../../controller/doctor_reports_ctr.dart';

final _reportsCtr = Get.put(DoctorReportsCtr());

class ReportSearchButton extends StatelessWidget {
  const ReportSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _reportsCtr.readAllViewed(),
      builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasData) {
          return IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              
              showSearch(
                context: context,
                delegate: ReportsSearchBar(snapshot.data!),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}

class ReportsSearchBar extends SearchDelegate {
  final List<UserModel> users;

  ReportsSearchBar(this.users);
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
          onTap: () async {
            await _reportsCtr.setInfoBySearch(user.id).then(
              (value) {
                Navigator.pop(context);
              },
            );
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
          onTap: () async {
            await _reportsCtr.setInfoBySearch(user.id).then(
              (value) {
                Navigator.pop(context);
              },
            );
          },
          title: Text("Name : ${user.name}"),
          subtitle: Text("Email : ${user.email}"),
        );
      },
    );
  }
}
