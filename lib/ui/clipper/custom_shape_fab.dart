import 'package:flutter/material.dart';

class CustomShapeFab extends ShapeBorder{
  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.only();


  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect size, {TextDirection textDirection}) {
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
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }

}