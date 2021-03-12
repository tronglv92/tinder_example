import 'package:flutter/material.dart';
class PhotoHero extends StatelessWidget {
  PhotoHero({this.photo,this.tag});
  final String photo;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Hero(tag: tag, child: Image.asset(
      photo,
      fit: BoxFit.cover,
    ));
  }
}
