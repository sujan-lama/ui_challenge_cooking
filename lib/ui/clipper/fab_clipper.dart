import 'package:flutter/material.dart';

class FabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var stLineHeight = 7.0;
    path.moveTo(1.0, (size.height / 2) - stLineHeight);
    path.lineTo(1.0, (size.height / 2) + stLineHeight);
    path.lineTo((size.width / 2) - stLineHeight, size.height - 1);
    path.lineTo((size.width / 2) + stLineHeight, size.height - 1);
    path.lineTo(size.width - 1, (size.height / 2) + stLineHeight);
    path.lineTo(size.width - 1, (size.height / 2) - stLineHeight);
    path.lineTo((size.width / 2) + stLineHeight, 1.0);
    path.lineTo((size.width / 2) - stLineHeight, 1.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) =>false;

}
