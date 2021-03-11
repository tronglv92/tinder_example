import 'package:flutter/material.dart';
import 'package:tinder_example/models/profile.dart';
import 'package:tinder_example/profiles_page/card_profile/indicator_tab.dart';
import 'package:tinder_example/profiles_page/pick_option.dart';

const Color colorLike = Color.fromRGBO(110, 227, 180, 1.0);
const Color colorNope = Color.fromRGBO(236, 82, 136, 1.0);

class CardProfile extends StatefulWidget {
  CardProfile(
      {this.profile,
      this.likeOpacity = 0,
      this.nopeOpacity = 0,
      this.superLikeOpacity = 0,
      this.indexSelected = 0,
      @required this.widthCard,
      @required this.heightCard});

  final Profile profile;
  final double likeOpacity;
  final double nopeOpacity;
  final double superLikeOpacity;
  final double widthCard;
  final double heightCard;
  final int indexSelected;

  @override
  _CardProfileState createState() => _CardProfileState();
}

class _CardProfileState extends State<CardProfile> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



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
            child:Image.asset(widget.profile.profiles[widget.indexSelected],fit: BoxFit.cover,)


          ),
          Positioned(
              top: 20,
              left: 15,
              child: Opacity(
                opacity: widget.superLikeOpacity != 0 ? 0 : widget.likeOpacity,
                child: PickOption(
                  color: colorLike,
                  text: "LIKE",
                ),
              )),
          Positioned(
              right: 15,
              top: 20,
              child: Opacity(
                opacity: widget.superLikeOpacity != 0 ? 0 : widget.nopeOpacity,
                child: PickOption(
                  color: colorNope,
                  text: "NOPE",
                ),
              )),
          Positioned(
              bottom: 15,
              left: 15,
              child: Text(
                widget.profile.name,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
          Positioned(
              left: widget.widthCard / 4,
              bottom: 55,
              child: Opacity(
                opacity: widget.superLikeOpacity,
                child: PickOption(
                  widthBorder: 4,
                  fontSize: 32,
                  color: Colors.blue,
                  text: "SUPER LIKE",
                ),
              )),
          if (widget.profile.profiles.length > 1)
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Row(children: [
                  for (int i = 0; i < widget.profile.profiles.length; i++)
                    Expanded(
                      child: IndicatorTab(
                        selected: i == widget.indexSelected,
                      ),
                    )
                ]))
        ],
      ),
    );
  }
}
