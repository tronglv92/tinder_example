import 'package:flutter/material.dart';
import 'package:tinder_example/test/test_dragger.dart';

import 'profiles_page/profiles_page.dart';

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
      home: ProfilesPage(),
    );
  }
}
