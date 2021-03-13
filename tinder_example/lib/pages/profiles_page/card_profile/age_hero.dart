import 'package:flutter/material.dart';
import 'package:tinder_example/models/profile.dart';
class AgeHero extends StatelessWidget {
  AgeHero({this.profile,this.style=const TextStyle(fontSize: 18, color: Colors.white)});
  final Profile profile;

  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    final String tag=profile.id+profile.age.toString();
    return Hero(tag: tag, child: Material(

      color: Colors.transparent,
      child: Text(profile.age.toString(),style:style,),
    ));
  }
}
