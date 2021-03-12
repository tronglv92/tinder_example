import 'package:flutter/material.dart';
class CircleGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final double radius;
  final Function onPressed;

  const CircleGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = 50.0,
    this.height = 50.0,
    this.onPressed,
    this.radius=25
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,

      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ],borderRadius: BorderRadius.circular(radius)),

      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
