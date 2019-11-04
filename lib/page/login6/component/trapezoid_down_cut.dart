import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TrapezoidDownCut extends StatelessWidget {
  TrapezoidDownCut({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiagonalClipper(),
      child: child,
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height * 0.7);
    path.quadraticBezierTo(
        0.0, size.height * 0.7 + 14, 15, size.height * 0.7 + 20);

    path.lineTo(size.width - 50, size.height - 15);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 50);

    path.lineTo(size.width, size.height * 0.1);
    path.quadraticBezierTo(size.width, 0.0, size.width * 0.9, 0.0);

    path.lineTo(size.width * 0.1, 0.0);
    path.quadraticBezierTo(0.0, 0.0, 0.0, size.height * 0.1);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
