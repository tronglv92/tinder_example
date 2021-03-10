import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:interpolate/interpolate.dart';
import 'package:tinder_example/models/profile.dart';
import 'package:tinder_example/profiles_page/circle_white.dart';
import 'package:tinder_example/profiles_page/pick_option.dart';
import 'package:tinder_example/widgets/appbar_empty.dart';
import 'dart:math' as math;

import 'card_profile.dart';

const Color backgroundColor = Color.fromRGBO(251, 250, 255, 1.0);
const double HEIGHT_HEADER = 80;
const double HEIGHT_FOOTER = 80;
const double SIZE_SMALLER = 15;

class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage>
    with TickerProviderStateMixin {
  List<Profile> profiles = [
    Profile(
      id: "1",
      name: "Caroline",
      age: 24,
      profile: "assets/profiles/1.jpeg",
    ),
    Profile(
      id: "2",
      name: "Jack",
      age: 30,
      profile: "assets/profiles/2.jpeg",
    ),
    Profile(
      id: "3",
      name: "Caroline",
      age: 21,
      profile: "assets/profiles/3.jpeg",
    ),
    Profile(
      id: "4",
      name: "Caroline",
      age: 40,
      profile: "assets/profiles/4.jpg",
    ),
  ];

  double translationX = 0;
  double translationY = HEIGHT_HEADER;

  Interpolate ipRotation;
  Interpolate ipLikeOpacity;
  Interpolate ipNopeOpacity;

  //Card remain
  Interpolate ipHeightCardRemain;
  Interpolate ipWidthCardRemain;
  Interpolate ipTopCardRemain;

  AnimationController _controllerSpringX;
  SpringSimulation _springSimulationX;
  Animation<double> _animationSpringX;

  AnimationController _controllerSpringY;
  SpringSimulation _springSimulationY;
  Animation<double> _animationSpringY;

  double translationThreshold = 0;
  double snapPoint = 0;

  double rotatedWidth = 0;



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initAnimation();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerSpringX?.dispose();
    _controllerSpringY?.dispose();
  }

  void initAnimation() {
    final Size size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    translationThreshold = size.width / 2;
    rotatedWidth = size.width/2 * math.sin(toRadians(90 - 15)) +
        size.height/2 * math.sin(toRadians(15));
    final double heightOfCard =
        size.height - HEIGHT_HEADER - HEIGHT_FOOTER - statusBarHeight;
    ipRotation = Interpolate(
      inputRange: [-size.width / 2, size.width / 2],
      outputRange: [toRadians(15), toRadians(-15)],
      extrapolate: Extrapolate.clamp,
    );
    ipLikeOpacity = Interpolate(
      inputRange: [0, size.width / 4],
      outputRange: [0, 1],
      extrapolate: Extrapolate.clamp,
    );
    ipNopeOpacity = Interpolate(
      inputRange: [-size.width / 4, 0],
      outputRange: [1, 0],
      extrapolate: Extrapolate.clamp,
    );
    //REMAIN CARD
    ipHeightCardRemain = Interpolate(
      inputRange: [-translationThreshold, 0, translationThreshold],
      outputRange: [heightOfCard, heightOfCard - SIZE_SMALLER, heightOfCard],
      extrapolate: Extrapolate.clamp,
    );
    ipWidthCardRemain = Interpolate(
      inputRange: [-translationThreshold, 0, translationThreshold],
      outputRange: [size.width, size.width - SIZE_SMALLER, size.width],
      extrapolate: Extrapolate.clamp,
    );
    ipTopCardRemain = Interpolate(
      inputRange: [-translationThreshold,0, translationThreshold],
      outputRange: [HEIGHT_HEADER,HEIGHT_HEADER + SIZE_SMALLER, HEIGHT_HEADER],
      extrapolate: Extrapolate.clamp,
    );
    _controllerSpringX =
        AnimationController(vsync: this, lowerBound: -500, upperBound: 500)
          ..addListener(() {
            this.setState(() {
              translationX = _animationSpringX?.value;
            });
          })
          ..addStatusListener((AnimationStatus status) {
          
            if (status == AnimationStatus.completed) {

              swipeCard();
            }
          });
    _controllerSpringY =
        AnimationController(vsync: this, lowerBound: -500, upperBound: 500)
          ..addListener(() {
            this.setState(() {
              translationY = _animationSpringY?.value;
            });
          });
  }

  void swipeCard() {
    if (snapPoint == -rotatedWidth || snapPoint == rotatedWidth) {
      _controllerSpringY?.stop();
      _controllerSpringX?.stop();
      setState(() {
        translationX = 0;
        translationY = HEIGHT_HEADER;
        profiles.removeLast();
      });
    }
  }

  void runAnimateSpringX() {
    _animationSpringX =
        _controllerSpringX.drive(Tween(begin: translationX, end: snapPoint));
    const springDescription = SpringDescription(
      damping: 20,
      mass: 1,
      stiffness: 100,
    );
    _springSimulationX = SpringSimulation(springDescription, 0, 1, 100);
    _controllerSpringX?.animateWith(_springSimulationX);
  }

  void runAnimateSpringY() {
    _animationSpringY = _controllerSpringY
        .drive(Tween(begin: translationY, end: HEIGHT_HEADER));
    const springDescription = SpringDescription(
      damping: 20,
      mass: 1,
      stiffness: 100,
    );
    _springSimulationY = SpringSimulation(springDescription, 0, 1, 100);
    _controllerSpringY?.animateWith(_springSimulationY);
  }

  double toRadians(int degree) {
    return (math.pi * degree) / 180;
  }

  Widget _buildListCard() {
    List<Profile> profilesRemain = [];
    Profile lastProfile;

    if (profiles.length > 0) {
      if (profiles.length <= 1) {
        profilesRemain = [];
        lastProfile = profiles[profiles.length - 1];
      } else {
        profilesRemain = profiles.getRange(0, profiles.length - 1).toList();
        lastProfile = profiles[profiles.length - 1];
      }
    }

    final Size size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    double rotateZ = ipRotation != null ? ipRotation.eval(translationX) : 0;
    double likeOpacity =
        ipLikeOpacity != null ? ipLikeOpacity.eval(translationX) : 0;
    double nopeOpacity =
        ipNopeOpacity != null ? ipNopeOpacity.eval(translationX) : 0;

    double heightOfCard =
        size.height - HEIGHT_HEADER - HEIGHT_FOOTER - statusBarHeight;
    double heightCardRemain = ipHeightCardRemain != null
        ? ipHeightCardRemain.eval(translationX)
        : heightOfCard - SIZE_SMALLER;
    double widthCardRemain = ipWidthCardRemain != null
        ? ipWidthCardRemain.eval(translationX)
        : size.width - SIZE_SMALLER;
    double topCardRemain = ipTopCardRemain != null
        ? ipTopCardRemain.eval(translationX)
        : HEIGHT_HEADER + SIZE_SMALLER;

    return Positioned.fill(
      child: Stack(
        fit: StackFit.expand,
        children: [
          for (int i = 0; i < profilesRemain.length; i++)
            Positioned(
                top: topCardRemain,
                height: heightCardRemain,
                width: widthCardRemain,
                child: CardProfile(profile: profilesRemain[i])),
          //Last Card
          lastProfile != null
              ? Positioned(
                  top: translationY,
                  left: translationX,
                  height: heightOfCard,
                  width: size.width,
                  child: GestureDetector(
                      onPanDown: (DragDownDetails dragDown) {
                        _controllerSpringY?.stop();
                        _controllerSpringX?.stop();
                      },
                      onPanStart: (DragStartDetails dragStart) {},
                      onPanUpdate: (DragUpdateDetails dragDetail) {

                        print("DragUpdateDetails of "+lastProfile.id.toString());
                        setState(() {
                          translationX = translationX + dragDetail.delta.dx;
                          translationY = translationY + dragDetail.delta.dy;
                        });
                      },
                      onPanEnd: (DragEndDetails dragEnd) {
                        if (translationX < -translationThreshold) {
                          snapPoint = -rotatedWidth;
                        } else {
                          if (translationX > translationThreshold) {
                            snapPoint = rotatedWidth;
                          } else {
                            snapPoint = 0;
                          }
                        }

                        runAnimateSpringX();
                        runAnimateSpringY();
                      },
                      child: Transform.rotate(
                          angle: rotateZ,
                          child: CardProfile(
                            profile: lastProfile,
                            likeOpacity: likeOpacity,
                            nopeOpacity: nopeOpacity,
                          ))),
                )
              : Container()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppbarEmpty(
      backgroundColor: backgroundColor,
      child: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(child: Container()),
              _buildFooter()
            ],
          ),
          _buildListCard()
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: HEIGHT_HEADER,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.person_outline,
            size: 32,
            color: Colors.grey,
          ),
          Icon(
            Icons.chat_bubble_outline,
            size: 32,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      height: HEIGHT_FOOTER,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleWhite(
            child: Icon(
              Icons.close,
              size: 32,
              color: Color.fromRGBO(236, 82, 136, 1.0),
            ),
          ),
          CircleWhite(
            child: Icon(
              MaterialCommunityIcons.heart_outline,
              size: 32,
              color: Color.fromRGBO(110, 227, 180, 1.0),
            ),
          )
        ],
      ),
    );
  }
}
