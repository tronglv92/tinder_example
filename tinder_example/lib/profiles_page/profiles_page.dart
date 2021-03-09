import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tinder_example/models/profile.dart';
import 'package:tinder_example/profiles_page/circle_white.dart';
import 'package:tinder_example/profiles_page/pick_option.dart';
import 'package:tinder_example/widgets/appbar_empty.dart';

import 'card_profile.dart';

const Color backgroundColor = Color.fromRGBO(251, 250, 255, 1.0);
const double HEIGHT_HEADER=80;
const double HEIGHT_FOOTER=80;

class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  double translationX;
  double translationY;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
              Expanded(
                  child: Container()),
              _buildFooter()
            ],
          ),

          _buildListCard()
        ],
      ),
    );
  }

  Widget _buildListCard(){
    List<Profile>profilesRemain= [];
    Profile lastProfile;
    if(profiles.length>0)
    {
      if(profiles.length<=1 )
      {
        profilesRemain=[];
        lastProfile=profiles[profiles.length-1];
      }
      else
      {
        profilesRemain=profiles.getRange(0, profiles.length-2).toList();
        lastProfile=profiles[profiles.length-1];
      }
    }

    final Size size=MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double heightOfCard=size.height-HEIGHT_HEADER-HEIGHT_FOOTER-statusBarHeight;
    return Positioned.fill(
      child: Stack(
        fit: StackFit.expand,
        children: [
          for(int i=profilesRemain.length-1;i>=0;i--)
            Positioned(
                top: HEIGHT_HEADER,
                height: heightOfCard,
                width:size.width,
                child: CardProfile(profile:profilesRemain[i] )),
          //Last Card
          lastProfile!=null?Positioned(
            top: HEIGHT_HEADER,
            height: heightOfCard,
            width:size.width,

            child: GestureDetector(
                onPanStart: (DragStartDetails startDrag){

                },
                onPanUpdate: (DragUpdateDetails detailDrag){

                },
                onPanEnd: (DragEndDetails endDrag){

                },
                child: CardProfile(profile: lastProfile,)),
          ):Container()
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
