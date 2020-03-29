import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stress_app/data/User.dart';

import 'package:stress_app/screens/available_activities.dart';
import 'package:stress_app/screens/graph_view/graph_analysis_view.dart';
import '../account_page.dart';

class SideDrawer extends StatefulWidget {
  final BuildContext context;

  SideDrawer(this.context);

  @override
  _SideDrawerState createState() => _SideDrawerState(context);
}

class _SideDrawerState extends State<SideDrawer> {
  final BuildContext context;
  ScrollController _sc;
  double headerHeight;

  _SideDrawerState(this.context);

  @override
  void initState() {
    headerHeight = MediaQuery.of(context).size.height * 3 / 19.2;
    _sc = ScrollController(initialScrollOffset: ((MediaQuery.of(context).size.height) / 2) - headerHeight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(16.0)),
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: headerHeight,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xff424242),
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff424242),
                ),
                accountName: Text(
                  User.currentUser.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  User.currentUser.email,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff424242),
                ),
                child: ListView(
                  controller: _sc,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: ((MediaQuery.of(context).size.height) / 2) - headerHeight,
                    ),
                    createTile('Graph Breakdown', GraphAnalysisView()),
                    createTile('Available Activities', AvailableActivities()),
                    createTile('Account', AccountPage()),
                    Container(
                      height: ((MediaQuery.of(context).size.height) - (225 + headerHeight)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createTile(String name, Widget page) {
    return Container(
      height: 75,
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => page)),
      ),
    );
  }
}