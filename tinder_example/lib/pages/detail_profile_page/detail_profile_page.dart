import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:tinder_example/models/profile.dart';
import 'package:tinder_example/pages/detail_profile_page/info_detail_profile.dart';
import 'package:tinder_example/pages/detail_profile_page/circle_button.dart';
import 'package:tinder_example/pages/detail_profile_page/circle_down_button.dart';
import 'package:tinder_example/pages/detail_profile_page/circle_gradient_button.dart';
import 'package:tinder_example/pages/profiles_page/card_profile/indicator_tab.dart';
import 'package:tinder_example/pages/profiles_page/card_profile/photo_hero.dart';
import 'package:tinder_example/widgets/appbar_empty.dart';

import 'bottom_detail_profile.dart';

class DetailProfilePage extends StatefulWidget {
  DetailProfilePage({@required this.profile,@required this.index});
  final Profile profile;
  final int index;
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
    _pageController=PageController(initialPage: widget.index,viewportFraction: 0.999);
    indexSelectedPage=widget.index;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController?.dispose();
  }

  void onPageChanged(int page)
  {
    this.setState(() {
      indexSelectedPage=page;
    });
  }

  void onPressBack(){

    Navigator.pop(context,indexSelectedPage);
  }
  @override
  Widget build(BuildContext context) {
    return AppbarEmpty(
        child: Stack(
      children: [
        Column(
          children: [
            _buildPhotos(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: InfoDetailProfile(profile: widget.profile,),
            ),
            Container(
                height: 80,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.grey.withOpacity(0.6))),
                    color: Colors.white),
                child: BottomDetailProfile()),
          ],
        ),
        CircleDownButton(onPress:onPressBack ,),
        _buildIndicator()

      ],
    ));
  }

  Widget _buildPhotos()
  {
    return  Container(
      height: 400,

      child: PageView.builder(
        // physics: ClampingScrollPhysics(),
        controller: _pageController,
        // preloadPagesCount:  widget.profile.profiles.length,
        itemBuilder: (BuildContext context, int index) {

          return PhotoHero(profile: widget.profile,index: index,);
        },
        itemCount: widget.profile.profiles.length,
        onPageChanged: onPageChanged,
      ),
    );
  }


  Widget _buildIndicator() {
    if (widget.profile.profiles.length > 1)
      return Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: Hero(
            tag: widget.profile.id+"indicator",
            child: Row(children: [
              for (int i = 0; i < widget.profile.profiles.length; i++)
                Expanded(
                  child: IndicatorTab(
                    selected: i == indexSelectedPage,
                  ),
                )
            ]),
          ));
    else
      return Container();
  }



}
