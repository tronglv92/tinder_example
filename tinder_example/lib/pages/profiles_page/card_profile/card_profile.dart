import 'package:flutter/material.dart';
import 'package:tinder_example/models/profile.dart';
import 'package:tinder_example/pages/profiles_page/card_profile/indicator_tab.dart';
import 'package:tinder_example/pages/profiles_page/pick_option.dart';

import '../photo_hero.dart';

const Color colorLike = Color.fromRGBO(110, 227, 180, 1.0);
const Color colorNope = Color.fromRGBO(236, 82, 136, 1.0);

class CardProfile extends StatefulWidget {
  CardProfile(
      {@required this.profile,
      this.likeOpacity = 0,
      this.nopeOpacity = 0,
      this.superLikeOpacity = 0,
      @required this.widthCard,
      @required this.heightCard,
      this.onPressDetail,
      this.lastCard = false,
      this.pageController});

  final Profile profile;
  final double likeOpacity;
  final double nopeOpacity;
  final double superLikeOpacity;
  final double widthCard;
  final double heightCard;

  final Function onPressDetail;
  final bool lastCard;
  final PageController pageController;

  @override
  _CardProfileState createState() => _CardProfileState();
}

class _CardProfileState extends State<CardProfile> {
  int indexSelected = 0;

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
            child: (widget.lastCard == false && widget.pageController != null)
                ? Image.asset(
                    widget.profile.profiles[0],
                    fit: BoxFit.cover,
                  )
                : PageView.builder(
                    controller: widget.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        widget.profile.profiles[index],
                        fit: BoxFit.cover,
                      );
                    },
                    itemCount: widget.profile.profiles.length,
                    onPageChanged: (int page) {
                      setState(() {
                        indexSelected = page;
                      });
                    },
                  ),
          ),
          _buildLike(),
          _buildNope(),
          _buildInfo(),
          _buildSuperLike(),
          _buildIndicator()
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Positioned(
        bottom: 15,
        left: 15,
        child: GestureDetector(
          onTap: () {
            if (widget.onPressDetail != null)
              widget.onPressDetail(widget.profile);
          },
          child: Text(
            widget.profile.name,
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));
  }

  Widget _buildNope() {
    return Positioned(
        right: 15,
        top: 20,
        child: Opacity(
          opacity: widget.superLikeOpacity != 0 ? 0 : widget.nopeOpacity,
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
          opacity: widget.superLikeOpacity != 0 ? 0 : widget.likeOpacity,
          child: PickOption(
            color: colorLike,
            text: "LIKE",
          ),
        ));
  }

  Widget _buildSuperLike() {
    return Positioned(
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
        ));
  }

  Widget _buildIndicator() {
    if (widget.profile.profiles.length > 1)
      return Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: Row(children: [
            for (int i = 0; i < widget.profile.profiles.length; i++)
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
