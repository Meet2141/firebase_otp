import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Welcome'),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.red,
          ),
          body: Container(
            alignment: Alignment.center,
            child: Text('Welcome'),
          )),
    );
  }
}
