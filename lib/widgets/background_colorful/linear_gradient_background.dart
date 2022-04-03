import 'package:flutter/material.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/utils/device/device_utils.dart';

class LinearGradientBackground extends StatelessWidget {
  const LinearGradientBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, 1),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          AppColors.darkBlue[200]!,
          AppColors.darkTextTheme,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
    );
  }
}
