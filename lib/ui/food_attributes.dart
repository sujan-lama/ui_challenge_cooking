import 'package:flutter/material.dart';

class FoodAttributes extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Animation<double> opacity;

  FoodAttributes({this.text, this.icon, this.color, this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.green,
          ),
          (opacity != null)
              ? FadeTransition(
                  opacity: opacity,
                  child: Container(
                    margin: const EdgeInsets.only(left: 14.0),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: color,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(left: 14.0),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: color,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                )
        ],
      ),
    );
  }
}
