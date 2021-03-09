import 'package:flutter/material.dart';
class PickOption extends StatelessWidget {
  final Color color;
  final String text;
  PickOption({this.color,this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border:
        Border.all(width: 4, color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 24, color: color,fontWeight: FontWeight.bold),
      ),
    );
  }
}
