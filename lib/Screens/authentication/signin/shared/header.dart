import 'package:flutter/material.dart';

import '../../../../shared/colors.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondary,
      height: 200,
      child: Center(
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Med",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "swift",
                style: TextStyle(
                  fontSize: 36,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
