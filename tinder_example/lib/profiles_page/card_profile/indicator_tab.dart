import 'package:flutter/material.dart';

class IndicatorTab extends StatelessWidget {
  IndicatorTab({this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      margin: EdgeInsets.only(right: 5, top: 8, left: 5),
      decoration: BoxDecoration(
          color: selected == true ? Colors.white : Colors.black26,
          borderRadius: BorderRadius.circular(14)),
    );
  }
}
