import 'package:flutter/material.dart';

import 'package:stress_app/screens/app_drawer.dart';
import 'package:stress_app/screens/homepage_body.dart';
import 'package:stress_app/screens/stress_level_overview.dart';
import 'package:stress_app/screens/stress_relief_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePageBody(),
    StressReliefPage(),
    StressLevelOverview(Color(0xff101010))
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(context),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomBar(this),
    );
  }
}

class BottomBar extends StatelessWidget {
  final _MyHomePageState parent;

  BottomBar(this.parent);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Ink(
        color: Color(0xff000000),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            IconButton(
              color: parent._selectedIndex == 0 ? Colors.grey : Colors.white,
              splashColor: Colors.transparent,
              iconSize: parent._selectedIndex == 0 ? 30 : 24,
              icon: Icon(Icons.home),
              onPressed: () {
                parent._onItemTapped(0);
              },
            ),
            IconButton(
              color: parent._selectedIndex == 1 ? Colors.grey : Colors.white,
              splashColor: Colors.transparent,
              iconSize: parent._selectedIndex == 1 ? 30 : 24,
              icon: Icon(Icons.healing),
              onPressed: () {
                parent._onItemTapped(1);
              },
            ),
            IconButton(
              color: parent._selectedIndex == 2 ? Colors.grey : Colors.white,
              splashColor: Colors.transparent,
              iconSize: parent._selectedIndex == 2 ? 30 : 24,
              icon: Icon(Icons.table_chart),
              onPressed: () {
                parent._onItemTapped(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}