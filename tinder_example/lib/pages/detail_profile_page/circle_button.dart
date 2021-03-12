import 'package:flutter/material.dart';
class CircleButton extends StatelessWidget {
  CircleButton({@required this.onPress,this.size=const Size(20,20),@required this.child});

  final Size size;
  final Function onPress;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPress();
      },

      child: Center(
        child: child,
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          minimumSize: size,
          shape: CircleBorder(),
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.5)),


    );
  }
}
