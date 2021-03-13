import 'package:flutter/material.dart';
import 'package:tinder_example/models/profile.dart';
import 'package:tinder_example/pages/profiles_page/card_profile/age_hero.dart';
import 'package:tinder_example/pages/profiles_page/card_profile/name_hero.dart';

class InfoDetailProfile extends StatelessWidget {
  InfoDetailProfile({@required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              NameHero(profile: profile,style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 2),
                child:AgeHero(profile: profile, style: TextStyle(fontSize: 18, color: Colors.grey))
                ,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 15,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Confirm",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.grey,
                size: 15,
              ),
              SizedBox(
                width: 4,
              ),
              Text("Distance 9 km",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
