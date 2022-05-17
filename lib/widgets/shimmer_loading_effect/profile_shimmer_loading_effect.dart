import 'package:flutter/material.dart';
import 'package:mobile/utils/device/device_utils.dart';

class ProfileShimmerLoadingEffect extends StatelessWidget {
  const ProfileShimmerLoadingEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: DeviceUtils.getScaledWidth(context, 0.5),
        child: const AspectRatio(
          aspectRatio: 1 / 1,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
