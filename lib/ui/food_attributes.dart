import 'package:flutter/material.dart';

class FoodAttributes extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final double opacity;

  FoodAttributes(
      {this.text, this.icon, this.color = Colors.black, this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.green,
          ),
          Opacity(
            opacity: opacity,
            child: Container(
                margin: EdgeInsets.only(left: 16.0),
                padding: EdgeInsets.all(5.0),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: color,
                      fontWeight: FontWeight.w600),
                )),
          )
        ],
      ),
    );
  }
}
