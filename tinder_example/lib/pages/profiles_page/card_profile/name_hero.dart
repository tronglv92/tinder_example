import 'package:flutter/material.dart';
import 'package:tinder_example/models/profile.dart';
class NameHero extends StatelessWidget {
  NameHero({this.profile,this.style=const TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold)});
  final Profile profile;

  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    final String tag=profile.id+profile.name;
    return Hero(tag: tag, child: Material(

      color: Colors.transparent,
      child: Text(profile.name,style:style,),
    ));
  }
}
