import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';

class ProfileShimmerLoadingEffect extends StatelessWidget {
  const ProfileShimmerLoadingEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircleProgressBar(foregroundColor: Colors.red, value: 65),
    );
  }
}
