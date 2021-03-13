import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'circle_button.dart';

class BottomDetailProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleButton(
            onPress: () {},
            child: Center(
              child: Icon(
                Icons.close,
                size: 30,
                color: Colors.red,
              ),
            )),
        SizedBox(
          width: 10,
        ),
        CircleButton(
          onPress: () {},
          child: Center(
            child: Icon(
              Icons.star,
              size: 20,
              color: Colors.red,
            ),
          ),
          size: Size(15, 15),
        ),
        SizedBox(
          width: 10,
        ),
        CircleButton(
            onPress: () {},
            child: Center(
              child: Icon(
                MaterialCommunityIcons.heart,
                size: 30,
                color: Color.fromRGBO(110, 227, 180, 1.0),
              ),
            )),
      ],
    );
  }
}
