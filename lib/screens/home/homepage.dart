import 'package:flutter/material.dart';

import 'package:stress_app/screens/home/app_drawer.dart';
import 'package:stress_app/screens/home/homepage_body.dart';
import 'package:stress_app/screens/stress_level_overview.dart';
import 'package:stress_app/screens/stress_relief/stress_relief_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<BottomBarPage> _widgetOptions = [
    BottomBarPage(HomePageBody(), Icon(Icons.home)),
    BottomBarPage(StressReliefPage(), Icon(Icons.healing)),
    BottomBarPage(StressLevelOverview(false), Icon(Icons.table_chart))
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
        child: _widgetOptions.elementAt(_selectedIndex).page,
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
          children: _generateButtons(context),
        ),
      ),
    );
  }
  
  List<IconButton> _generateButtons(BuildContext context) {
    List<IconButton> buttons = new List();
    buttons.add(
      IconButton(
        color: Colors.white,
        icon: Icon(Icons.menu), 
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      )
    );
    
    for(int i = 0; i < parent._widgetOptions.length; i++) {
      bool selected = parent._selectedIndex == i;
      IconButton button = 
      IconButton(
        color: selected ? Colors.grey : Colors.white,
        splashColor: Colors.transparent,
        iconSize: selected ? 30 : 24,
        icon: parent._widgetOptions.elementAt(i).icon,
        onPressed: () {
          parent._onItemTapped(i);
        },
      );
      buttons.add(button);
    }
    
    return buttons;
  }
}

class BottomBarPage {
  final _page;
  final _icon;

  BottomBarPage(this._page, this._icon);
  get icon => _icon;
  get page => _page;
}