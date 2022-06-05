import 'package:flutter/material.dart';
import 'package:mobile/utils/device/device_utils.dart';

class ListTileItemShimmer extends StatelessWidget {
  const ListTileItemShimmer({
    Key? key,
    this.height,
  }) : super(key: key);

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: height ?? DeviceUtils.getScaledWidth(context, 0.5),
        child: const AspectRatio(
          aspectRatio: 1 / 1,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
