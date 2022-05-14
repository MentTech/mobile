import 'package:flutter/material.dart';

class TextShowingError extends StatelessWidget {
  const TextShowingError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Error",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
