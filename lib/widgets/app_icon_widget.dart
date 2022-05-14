import 'package:flutter/material.dart';

class AppIconWidget extends StatelessWidget {
  final String image;
  final double? dimenImage;

  const AppIconWidget({
    Key? key,
    required this.image,
    this.dimenImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //calculating container width
    double imageSize;

    if (dimenImage == null) {
      //getting screen size
      var size = MediaQuery.of(context).size;

      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        imageSize = (size.width * 0.20);
      } else {
        imageSize = (size.height * 0.20);
      }
    } else {
      imageSize = dimenImage!;
    }

    return Image.asset(
      image,
      height: imageSize,
    );
  }
}
