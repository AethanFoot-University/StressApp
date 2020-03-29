import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import 'package:stress_app/screens/home/app_drawer.dart';
import 'package:stress_app/screens/home/homepage_body.dart';
import 'package:stress_app/screens/stress_level_overview.dart';
import 'package:stress_app/screens/stress_relief/music_page.dart';
import 'package:stress_app/screens/stress_relief/stress_relief_page.dart';
import 'package:stress_app/data/User.dart';
import 'package:stress_app/tools/Json.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<_BottomBarPage> _widgetOptions = [
    _BottomBarPage(HomePageBody(), Icon(OMIcons.home)),
    _BottomBarPage(StressReliefPage(), Icon(OMIcons.healing)),
    _BottomBarPage(StressLevelOverview(false), Icon(OMIcons.tableChart))
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void loadUser() {
    Json.readUser('Aethan').then
      ((value) {
      setState(() {
        User.currentUser = value;
        print(User.currentUser.name);
      });
    },
        onError: (e) {
          setState(() {
            User.currentUser = new User('Aethan', 'ajf75@bath.ac.uk', [0, 1], List());
            Json.saveUser(User.currentUser);
          });
        }
    );
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    MusicPage.player = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return User.currentUser == null ? Center(child: CircularProgressIndicator()):
    Scaffold(
      drawer: SideDrawer(context),
      backgroundColor: Color(0xff101010),
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
        icon: Icon(OMIcons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      )
    );
    
    for(int i = 0; i < parent._widgetOptions.length; i++) {
      bool selected = parent._selectedIndex == i;
      IconButton button = 
      IconButton(
        color: selected ? Colors.green : Colors.white,
        splashColor: Colors.transparent,
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

class _BottomBarPage {
  final _page;
  final _icon;

  _BottomBarPage(this._page, this._icon);
  get icon => _icon;
  get page => _page;
}