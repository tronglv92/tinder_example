import 'package:flutter/material.dart';
class CircleWhite extends StatelessWidget {
  final Widget child;
  CircleWhite({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 64,
      width: 64,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.18),
              offset: Offset(1, 1),

              blurRadius: 2,
            )
          ]
      ),
      child: child,
    );
  }
}
