import 'package:flutter/material.dart';
class PickOption extends StatelessWidget {
  final Color color;
  final String text;
  final double widthBorder;
  final double fontSize;
  PickOption({this.color,this.text,this.widthBorder=4,this.fontSize=24});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border:
        Border.all(width: widthBorder, color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize, color: color,fontWeight: FontWeight.bold),
      ),
    );
  }
}
