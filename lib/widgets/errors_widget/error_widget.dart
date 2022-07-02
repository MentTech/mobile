import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/utils/device/device_utils.dart';

class ErrorContentWidget extends StatelessWidget {
  const ErrorContentWidget({
    Key? key,
    required this.titleError,
    required this.contentError,
  }) : super(key: key);

  final String titleError;
  final String contentError;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      clipBehavior: Clip.none,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.large_vertical_padding,
          horizontal: Dimens.large_horizontal_padding,
        ),
        decoration: BoxDecoration(
          color: Colors.red.withAlpha(100),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(Assets.someErrorHappendedLotties,
                height: DeviceUtils.getScaledHeight(context, 0.3)),
            Text(
              titleError,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.red,
                  ),
            ),
            Text(
              contentError,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.red,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
