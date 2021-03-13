import 'package:flutter/material.dart';
import 'package:tinder_example/models/profile.dart';

class PhotoHero extends StatelessWidget {
  PhotoHero({this.profile,this.index});

  final Profile profile;
  final int index;

  @override
  Widget build(BuildContext context) {
    final String photo=profile.profiles[index];
    final String tag=profile.id+photo;
    return Hero(
        tag: tag,

        child: Image.asset(
          photo,
          fit: BoxFit.cover,
        ));
  }
}
