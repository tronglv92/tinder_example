import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:interpolate/interpolate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:tinder_example/models/profile.dart';
import 'package:tinder_example/pages/detail_profile_page/info_detail_profile.dart';
import 'package:tinder_example/pages/detail_profile_page/bottom_detail_profile.dart';
import 'package:tinder_example/pages/detail_profile_page/circle_down_button.dart';
import 'package:tinder_example/pages/detail_profile_page/detail_profile_page.dart';

import 'package:tinder_example/widgets/appbar_empty.dart';
import 'dart:math' as math;

import 'card_profile/card_profile.dart';
import 'circle_white.dart';

const Color backgroundColor = Color.fromRGBO(251, 250, 255, 1.0);
const double HEIGHT_HEADER = 80;
const double HEIGHT_FOOTER = 80;
const double SIZE_SMALLER = 10;
const int DURATION_SWIPE = 300;

const double UPPER_BOUND = 500;
const double LOWER_BOUND = -500;

class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage>
    with TickerProviderStateMixin {
  List<Profile> profilesUser = profiles;

  double translationX = 0;
  double translationY = HEIGHT_HEADER;

  Interpolate ipRotation;
  Interpolate ipRotationY;
  Interpolate ipLikeOpacity;
  Interpolate ipNopeOpacity;
  Interpolate ipSuperLikeOpacity;

  //Card remain
  Interpolate ipHeightCardRemain;
  Interpolate ipWidthCardRemain;
  Interpolate ipTopCardRemain;
  Interpolate ipLeftCardRemain;

  // Animation PullBack
  AnimationController _controllerSpringX;
  Animation<double> _animationSpringX;
  AnimationController _controllerSpringY;
  Animation<double> _animationSpringY;

  //end

  // Animation Swipe
  AnimationController _controllerSwipeX;
  Animation<double> _curveSwipeX;
  Animation<double> _animationSwipeX;
  AnimationController _controllerSwipeY;
  Animation<double> _curveSwipeY;
  Animation<double> _animationSwipeY;

  //end
  double translationThreshold = 0;
  double translationYThreshold = HEIGHT_HEADER;
  double snapPointX = 0;
  double snapPointY = HEIGHT_HEADER;
  double rotatedWidth = 0;
  double rotatedHeight = 0;

  int indexProfileSelected = 0;
  PreloadPageController _pageController;

  bool _modeDetailPage = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _pageController = PreloadPageController(initialPage: 0);
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
    _controllerSwipeX?.dispose();
    _controllerSwipeY?.dispose();
    _pageController?.dispose();
  }

  void initAnimation() {
    final Size size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double heightOfCard =
        size.height - HEIGHT_HEADER - HEIGHT_FOOTER - statusBarHeight;

    translationThreshold = size.width / 2;
    translationYThreshold = size.height / 4;
    rotatedWidth = size.width * math.sin(toRadians(90 - 15)) +
        size.height * math.sin(toRadians(15));
    rotatedHeight = size.height * math.sin(toRadians(90 - 7)) +
        size.width * math.sin(toRadians(7));

    ipRotation = Interpolate(
      inputRange: [-size.width / 2, size.width / 2],
      outputRange: [toRadians(15), toRadians(-15)],
      extrapolate: Extrapolate.clamp,
    );
    ipRotationY = Interpolate(
      inputRange: [
        -size.height / 2 + HEIGHT_HEADER,
        size.height / 2 + HEIGHT_HEADER
      ],
      outputRange: [toRadians(-7), toRadians(7)],
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
    ipSuperLikeOpacity = Interpolate(
      inputRange: [
        -size.height / 4,
        0,
        HEIGHT_HEADER,
      ],
      outputRange: [1, 0, 0],
      extrapolate: Extrapolate.clamp,
    );
    //REMAIN CARD

    // List<double> inputRange = directionHorizontal == true
    //     ? [-size.width / 4, 0, size.width / 4]
    //     : [
    //   -80,
    //   0,
    //   80
    // ];
    List<double> inputRange = [-size.width / 4, 0, size.width / 4];
    ipHeightCardRemain = Interpolate(
      inputRange: inputRange,
      outputRange: [
        heightOfCard,
        heightOfCard - 2 * SIZE_SMALLER,
        heightOfCard
      ],
      extrapolate: Extrapolate.clamp,
    );

    ipWidthCardRemain = Interpolate(
      inputRange: inputRange,
      outputRange: [size.width, size.width - 2 * SIZE_SMALLER, size.width],
      extrapolate: Extrapolate.clamp,
    );
    ipTopCardRemain = Interpolate(
      inputRange: inputRange,
      outputRange: [HEIGHT_HEADER, HEIGHT_HEADER + SIZE_SMALLER, HEIGHT_HEADER],
      extrapolate: Extrapolate.clamp,
    );
    ipLeftCardRemain = Interpolate(
      inputRange: inputRange,
      outputRange: [0, SIZE_SMALLER, 0],
      extrapolate: Extrapolate.clamp,
    );
    // Controller pull back
    _controllerSpringX = AnimationController(
        vsync: this, lowerBound: LOWER_BOUND, upperBound: UPPER_BOUND)
      ..addListener(() {
        this.setState(() {
          translationX = _animationSpringX?.value;
        });
      });
    _controllerSpringY = AnimationController(
        vsync: this, lowerBound: LOWER_BOUND, upperBound: UPPER_BOUND)
      ..addListener(() {
        this.setState(() {
          translationY = _animationSpringY?.value;
        });
      });

    //Controller Swipe

    _controllerSwipeX = AnimationController(
        vsync: this, duration: Duration(milliseconds: DURATION_SWIPE))
      ..addListener(() {
        this.setState(() {
          translationX =
              _animationSwipeX != null ? _animationSwipeX.value : translationX;
        });
      })
      ..addStatusListener((status) {
        print("AnimationStatus.completed erere");
        if (status == AnimationStatus.completed) {
          swipeCard();
        }
      });
    _curveSwipeX =
        CurvedAnimation(parent: _controllerSwipeX, curve: Curves.ease);

    _controllerSwipeY = AnimationController(
        vsync: this, duration: Duration(milliseconds: DURATION_SWIPE))
      ..addListener(() {
        this.setState(() {
          translationY =
              _animationSwipeY != null ? _animationSwipeY.value : translationY;
        });
      });
    _curveSwipeY =
        CurvedAnimation(parent: _controllerSwipeY, curve: Curves.ease);
    // _animationSwipeY = Tween(begin: -200.0, end: 0.0).animate(curveSwipeY);
  }

  void swipeCard() {
    if (snapPointX == -rotatedWidth ||
        snapPointX == rotatedWidth ||
        snapPointY == -rotatedHeight) {
      print("AnimationStatus.completed erere 2");
      _controllerSwipeY?.stop();
      _controllerSwipeX?.stop();
      setState(() {
        translationX = 0;
        indexProfileSelected = 0;
        translationY = HEIGHT_HEADER;
        profilesUser.removeLast();
      });
      _pageController?.jumpToPage(0);
    }
  }

  void runAnimatedSwipe() {
    _animationSwipeX =
        Tween(begin: translationX, end: snapPointX).animate(_curveSwipeX);
    _animationSwipeY =
        Tween(begin: translationY, end: snapPointY).animate(_curveSwipeY);

    _controllerSwipeX?.reset();
    _controllerSwipeY?.reset();

    _controllerSwipeX?.forward();
    _controllerSwipeY?.forward();
  }

  void runAnimatedPullBack() {
    const springDescription = SpringDescription(
      damping: 20,
      mass: 1,
      stiffness: 100,
    );
    final _springSimulation = SpringSimulation(springDescription, 0, 1, 100);

    _animationSpringX =
        _controllerSpringX.drive(Tween(begin: translationX, end: snapPointX));
    _animationSpringY =
        _controllerSpringY.drive(Tween(begin: translationY, end: snapPointY));

    _controllerSpringX?.animateWith(_springSimulation);

    _controllerSpringY?.animateWith(_springSimulation);
  }

  double toRadians(int degree) {
    return (math.pi * degree) / 180;
  }

  Widget _onGesture({Widget child, Profile lastProfile}) {
    final Size size = MediaQuery.of(context).size;
    if (lastProfile != null && _modeDetailPage==false) {
      return GestureDetector(
          onPanDown: (DragDownDetails dragDown) {
            _controllerSpringY?.stop();
            _controllerSpringX?.stop();
            _controllerSwipeX?.stop();
            _controllerSwipeY?.stop();


          },
          onPanStart: (DragStartDetails dragStart) {},
          onPanUpdate: (DragUpdateDetails dragDetail) {
            setState(() {
              translationX = translationX + dragDetail.delta.dx;
              translationY = translationY + dragDetail.delta.dy;
            });
          },
          onPanEnd: (DragEndDetails dragEnd) {
            if (translationY < -translationYThreshold) {
              snapPointY = -rotatedHeight;
              runAnimatedSwipe();
            } else {
              snapPointY = HEIGHT_HEADER;
              if (translationX < -translationThreshold) {
                snapPointX = -rotatedWidth;
                runAnimatedSwipe();
              } else {
                if (translationX > translationThreshold) {
                  snapPointX = rotatedWidth;
                  runAnimatedSwipe();
                } else {
                  snapPointX = 0;

                  runAnimatedPullBack();
                }
              }
            }

          },
          onTapUp: (TapUpDetails detail) {

            if (detail.localPosition.dx < size.width / 2) {
              if (indexProfileSelected > 0) {
                // setState(() {
                //   indexProfileSelected--;
                // });
                indexProfileSelected--;
                _pageController.jumpToPage(indexProfileSelected);
              }
            }
            // RIGHT TAP
            else {
              if (indexProfileSelected < lastProfile.profiles.length - 1) {
                indexProfileSelected++;
                _pageController.jumpToPage(indexProfileSelected);
              }
            }
          },
          child: child);
    } else {
      return child;
    }
  }

  void onPressDetail(Profile profile) async{
     int result= await Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 400),
            reverseDuration: Duration(milliseconds:300),
            child: DetailProfilePage(profile: profile,index: indexProfileSelected,)));
     if(result!=null)
       {
         setState(() {
           indexProfileSelected=result;
           _pageController.jumpToPage(result);
         });
       }

  }



  Widget _buildListCard() {
    List<Profile> profilesRemain = [];
    Profile lastProfile;

    if (profilesUser.length > 0) {
      if (profilesUser.length <= 1) {
        profilesRemain = [];
        lastProfile = profilesUser[profilesUser.length - 1];
      } else {
        profilesRemain =
            profilesUser.getRange(0, profilesUser.length - 1).toList();
        lastProfile = profilesUser[profilesUser.length - 1];
      }
    }
    final Size size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    double heightOfCard =
        size.height - HEIGHT_HEADER - HEIGHT_FOOTER - statusBarHeight;
    // double heightCardRemain=
    double rotateX = ipRotation != null ? ipRotation.eval(translationX) : 0;
    double rotateY = ipRotationY != null ? ipRotationY.eval(translationY) : 0;

    double rotateZ = rotateX + rotateY;
    double likeOpacity =
    ipLikeOpacity != null ? ipLikeOpacity.eval(translationX) : 0;
    double nopeOpacity =
    ipNopeOpacity != null ? ipNopeOpacity.eval(translationX) : 0;
    double superLikeOpacity =
    ipSuperLikeOpacity != null ? ipSuperLikeOpacity.eval(translationY) : 0;

    double valueTranslation = math.sqrt(translationX * translationX +
        (translationY - HEIGHT_HEADER) * (translationY - HEIGHT_HEADER));


    double heightCardRemain = ipHeightCardRemain != null
        ? ipHeightCardRemain.eval(valueTranslation)
        : heightOfCard - SIZE_SMALLER;
    double widthCardRemain = ipWidthCardRemain != null
        ? ipWidthCardRemain.eval(valueTranslation)
        : size.width - SIZE_SMALLER;
    double topCardRemain = ipTopCardRemain != null
        ? ipTopCardRemain.eval(valueTranslation)
        : HEIGHT_HEADER + SIZE_SMALLER;
    double leftCardRemain =
    ipLeftCardRemain != null ? ipLeftCardRemain.eval(valueTranslation) : 15;

    return Positioned.fill(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // remain card
          for (int i = 0; i < profilesRemain.length; i++)
            Positioned(
                top: topCardRemain,
                height: heightCardRemain,
                width: widthCardRemain,
                left: leftCardRemain,
                child: CardProfile(
                  profile: profilesRemain[i],
                  widthCard: widthCardRemain,
                  heightCard: heightCardRemain,
                )),
          //Last Card
          lastProfile != null
              ? Positioned(
            top: translationY,
            left: translationX,
            height: heightOfCard,
            width: size.width,
            child: _onGesture(
                lastProfile: lastProfile,
                child: Transform.rotate(
                    angle: rotateZ,
                    child: CardProfile(
                      profile: lastProfile,
                      likeOpacity: likeOpacity,
                      nopeOpacity: nopeOpacity,
                      superLikeOpacity: superLikeOpacity,
                      widthCard: size.width,
                      heightCard: heightOfCard,
                      onPressDetail: onPressDetail,
                      pageController: _pageController,
                      lastCard: true,
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
          _buildHeader(),
          Column(
            children: [Expanded(child: Container()), _buildFooter()],
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
      child: BottomDetailProfile(),
    );
  }
}
