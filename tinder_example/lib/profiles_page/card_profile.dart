import 'package:flutter/material.dart';
import 'package:tinder_example/models/profile.dart';
import 'package:tinder_example/profiles_page/pick_option.dart';
const Color colorLike = Color.fromRGBO(110, 227, 180, 1.0);
const Color colorNope = Color.fromRGBO(236, 82, 136, 1.0);
class CardProfile extends StatelessWidget {
  CardProfile({this.profile});
  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(

        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(

                profile.profile,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 15,
                left: 15,
                child: PickOption(
                  color: colorLike,
                  text: "LIKE",
                )),
            Positioned(
                right: 15,
                top: 15,
                child: PickOption(
                  color: colorNope,
                  text: "NOPE",
                )),
            Positioned(
                bottom: 15,
                left: 15,
                child: Text(
                  profile.name,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
