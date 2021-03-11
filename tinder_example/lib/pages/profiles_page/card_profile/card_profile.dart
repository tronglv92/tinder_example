import 'package:flutter/material.dart';
import 'package:tinder_example/models/profile.dart';
import 'package:tinder_example/pages/profiles_page/card_profile/indicator_tab.dart';
import 'package:tinder_example/pages/profiles_page/pick_option.dart';

const Color colorLike = Color.fromRGBO(110, 227, 180, 1.0);
const Color colorNope = Color.fromRGBO(236, 82, 136, 1.0);

class CardProfile extends StatelessWidget {
  CardProfile(
      {@required this.profile,
      this.likeOpacity = 0,
      this.nopeOpacity = 0,
      this.superLikeOpacity = 0,
      this.indexSelected = 0,
      @required this.widthCard,
      @required this.heightCard,
       this.onPressDetail});

  final Profile profile;
  final double likeOpacity;
  final double nopeOpacity;
  final double superLikeOpacity;
  final double widthCard;
  final double heightCard;
  final int indexSelected;
  final Function onPressDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                profile.profiles[indexSelected],
                fit: BoxFit.cover,
              )),
          _buildLike(),
          _buildNope(),
          Positioned(
              bottom: 15,
              left: 15,
              child: GestureDetector(
                onTap: () {
                  if(onPressDetail!=null)
                    onPressDetail();
                },
                child: Text(
                  profile.name,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
          _buildSuperLike(),
          _buildIndicator()
        ],
      ),
    );
  }

  Widget _buildNope() {
    return Positioned(
        right: 15,
        top: 20,
        child: Opacity(
          opacity: superLikeOpacity != 0 ? 0 : nopeOpacity,
          child: PickOption(
            color: colorNope,
            text: "NOPE",
          ),
        ));
  }

  Widget _buildLike() {
    return Positioned(
        top: 20,
        left: 15,
        child: Opacity(
          opacity: superLikeOpacity != 0 ? 0 : likeOpacity,
          child: PickOption(
            color: colorLike,
            text: "LIKE",
          ),
        ));
  }

  Widget _buildSuperLike() {
    return Positioned(
        left: widthCard / 4,
        bottom: 55,
        child: Opacity(
          opacity: superLikeOpacity,
          child: PickOption(
            widthBorder: 4,
            fontSize: 32,
            color: Colors.blue,
            text: "SUPER LIKE",
          ),
        ));
  }

  Widget _buildIndicator() {
    if (profile.profiles.length > 1)
      return Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: Row(children: [
            for (int i = 0; i < profile.profiles.length; i++)
              Expanded(
                child: IndicatorTab(
                  selected: i == indexSelected,
                ),
              )
          ]));
    else
      return Container();
  }
}
