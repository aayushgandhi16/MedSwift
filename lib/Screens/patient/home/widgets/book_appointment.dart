import 'package:flutter/material.dart';
import 'package:medswift/models/user_model.dart';

import '../../../../shared/colors.dart';

class BookAppointmentView extends StatelessWidget {
  const BookAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Med",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "swift",
                style: TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: null,
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
