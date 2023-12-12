import 'package:flutter/material.dart';
import 'package:medswift/shared/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Med",
                  style: TextStyle(
                    color: secondary,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "swift",
                  style: TextStyle(
                    color: secondary,
                    fontSize: 36,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const CircularProgressIndicator(color: secondary),
        ],
      ),
    );
  }
}
