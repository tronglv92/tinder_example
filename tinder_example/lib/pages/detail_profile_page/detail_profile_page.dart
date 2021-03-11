import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tinder_example/widgets/appbar_empty.dart';

class DetailProfilePage extends StatefulWidget {
  @override
  _DetailProfilePageState createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  @override
  Widget build(BuildContext context) {
    return AppbarEmpty(
        child: Column(
      children: [
        Container(
          height: 400,
          color: Colors.red,
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
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
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 1, color: Colors.grey.withOpacity(0.6))),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Center(
                  child: Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: CircleBorder(),
                    elevation: 5,
                    shadowColor: Colors.black.withOpacity(0.5)),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Center(
                  child: Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(15, 15),
                    primary: Colors.white,
                    shape: CircleBorder(),
                    elevation: 5,
                    shadowColor: Colors.black.withOpacity(0.5)),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Center(
                  child: Icon(
                    MaterialCommunityIcons.heart,
                    size: 30,
                    color: Color.fromRGBO(110, 227, 180, 1.0),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: CircleBorder(),
                    elevation: 5,
                    shadowColor: Colors.black.withOpacity(0.5)),
              )
            ],
          ),
        )
      ],
    ));
  }
}
