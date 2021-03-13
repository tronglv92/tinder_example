import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'circle_gradient_button.dart';
class CircleDownButton extends StatelessWidget {
  CircleDownButton({this.onPress});
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 10,
        top: 400 - 60 / 2,
        child: CircleGradientButton(
          width: 60,
          height: 60,
          radius: 30,
          child: Icon(
            Entypo.arrow_bold_down,
            size: 30,
            color: Colors.white,
          ),
          gradient: LinearGradient(colors: <Color>[
            Color.fromRGBO(250, 56, 103, 1.0),
            Color.fromRGBO(251, 108, 81, 1.0)
          ]),
          onPressed: onPress,
        ));
  }
}
