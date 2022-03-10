import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SGVButton extends StatelessWidget {
  const SGVButton({
    Key? key,
    required this.assetName,
    required this.width,
    this.ontap,
  }) : super(key: key);

  final String assetName;
  final double width;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            shape:
                MaterialStateProperty.all<CircleBorder>(const CircleBorder())),
        onPressed: ontap,
        child: SvgPicture.asset(
          assetName,
          height: width,
          width: width,
        ));
  }
}
