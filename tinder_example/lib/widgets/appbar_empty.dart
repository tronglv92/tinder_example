import 'package:flutter/material.dart';
class AppbarEmpty extends StatelessWidget {
  const AppbarEmpty({@required this.child, this.actionBtn, Key key,this.backgroundColor=Colors.white})
      : super(key: key);

  final Color backgroundColor;
  final Widget child;
  final Widget actionBtn;

  @override
  Widget build(BuildContext context) {

    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: AppBar(
            elevation: 0,

            backgroundColor: Colors.transparent,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: child,
        ),
        floatingActionButton: actionBtn,
      ),
    );
  }

}
