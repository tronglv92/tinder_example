import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tinder_example/models/profile.dart';
import 'package:tinder_example/pages/detail_profile_page/circle_button.dart';
import 'package:tinder_example/pages/detail_profile_page/circle_gradient_button.dart';
import 'package:tinder_example/pages/profiles_page/card_profile/indicator_tab.dart';
import 'package:tinder_example/pages/profiles_page/photo_hero.dart';
import 'package:tinder_example/widgets/appbar_empty.dart';

class DetailProfilePage extends StatefulWidget {
  DetailProfilePage({@required this.profile});
  final Profile profile;
  @override
  _DetailProfilePageState createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  PageController _pageController;
  int indexSelectedPage=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController=PageController(initialPage: 0);
  }

  void onPageChanged(int page)
  {
    this.setState(() {
      indexSelectedPage=page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppbarEmpty(
        child: Stack(
      children: [
        Column(
          children: [
            _buildListProfiles(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _buildBody(),
            ),
            _buildBottom(),
          ],
        ),
        _btnCircleDown(),
        _buildIndicator()

      ],
    ));
  }

  Widget _buildListProfiles()
  {
    return  Container(
      height: 400,
      color: Colors.black,
      child: PageView.builder(
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          String tag= widget.profile.profiles[index]+widget.profile.id;
          return PhotoHero(photo:  widget.profile.profiles[index],tag:tag ,);
          return Image.asset(
            widget.profile.profiles[index],
            fit: BoxFit.cover,
          );
        },
        itemCount: widget.profile.profiles.length,
        onPageChanged: onPageChanged,
      ),
    );
  }

  Widget _btnCircleDown() {
    return Positioned(
        right: 10,
        top: 400 - 60 / 2,
        child: CircleGradientButton(
          width: 60,
          height: 60,
          radius: 30,
          child: Icon(
            Entypo.arrow_bold_down,
            size: 30,
            color: Colors.white,
          ),
          gradient: LinearGradient(colors: <Color>[
            Color.fromRGBO(250, 56, 103, 1.0),
            Color.fromRGBO(251, 108, 81, 1.0)
          ]),
          onPressed: (){
            Navigator.of(context).pop();
          },
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
                  selected: i == indexSelectedPage,
                ),
              )
          ]));
    else
      return Container();
  }
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Chinh",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 2),
                child: Text(
                  "34",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
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

  Widget _buildBottom() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(width: 1, color: Colors.grey.withOpacity(0.6))),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleButton(
              onPress: () {},
              child: Center(
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.red,
                ),
              )),
          SizedBox(
            width: 10,
          ),
          CircleButton(
            onPress: () {},
            child: Center(
              child: Icon(
                Icons.star,
                size: 20,
                color: Colors.red,
              ),
            ),
            size: Size(15, 15),
          ),
          SizedBox(
            width: 10,
          ),
          CircleButton(
              onPress: () {},
              child: Center(
                child: Icon(
                  MaterialCommunityIcons.heart,
                  size: 30,
                  color: Color.fromRGBO(110, 227, 180, 1.0),
                ),
              )),
        ],
      ),
    );
  }
}
