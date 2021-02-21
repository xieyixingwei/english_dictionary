import 'package:flutter/material.dart';
import 'Body.dart';
import 'Header.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 120,
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children:[
              HomeHeader(),
              SizedBox(height: 10,),
              HomeBody(),
            ],
          ),
        ),
      ),
    );
  }
}
