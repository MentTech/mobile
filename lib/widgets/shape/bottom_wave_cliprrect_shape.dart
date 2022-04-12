import 'package:flutter/rendering.dart';

class BottomWaveClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(
        size.width * 0.10, size.height, size.width * 0.35, size.height);
    path.quadraticBezierTo(size.width * 0.45, size.height * 0.995,
        size.width * 0.51, size.height * 0.98);
    path.quadraticBezierTo(size.width * 0.65, size.height * 0.95,
        size.width * 0.75, size.height * 0.96);
    path.quadraticBezierTo(size.width * 0.85, size.height * 0.96,
        size.width * 0.98, size.height * 0.98);
    path.quadraticBezierTo(
        size.width * 0.99, size.height * 0.985, size.width, size.height * 0.98);

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>
      this != oldClipper;
}
