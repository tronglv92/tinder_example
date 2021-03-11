import 'package:flutter/material.dart';
import 'package:tinder_example/pages/detail_profile_page/detail_profile_page.dart';

import 'pages/profiles_page/profiles_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: DetailProfilePage(),
    );
  }
}

