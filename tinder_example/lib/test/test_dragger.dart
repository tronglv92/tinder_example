import 'package:flutter/material.dart';
import 'package:tinder_example/models/profile.dart';

class TestDragger extends StatefulWidget {
  @override
  _TestDraggerState createState() => _TestDraggerState();
}

class _TestDraggerState extends State<TestDragger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Draggable(child: Container(height: 100,width: 300,color: Colors.blue,), feedback: Container(height: 100,width: 300,color: Colors.blue,)),
            Expanded(child: Container()),
            Container(
              height: 100,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() => AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(Icons.chat, color: Colors.grey),
          SizedBox(width: 16),
        ],
        leading: Icon(Icons.person, color: Colors.grey),
        title: Icon(Icons.fire_hydrant, color: Colors.deepOrange),
      );

}
