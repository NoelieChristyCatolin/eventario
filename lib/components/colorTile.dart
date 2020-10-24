import 'package:flutter/material.dart';

class ColorTile extends StatelessWidget {
  final MaterialColor color;
  final Function onTap;

  ColorTile({this.color, this.onTap});


  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: InkWell(
        child: Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
