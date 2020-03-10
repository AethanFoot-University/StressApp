import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stress_app/screens/availible_activities.dart';

import 'account_page.dart';
import 'graph_page.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: null,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: ((MediaQuery.of(context).size.height + 150) / 4) - 75,
                ),
                ListTile(
                  title: Text('Graph Breakdown'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GraphPage()));
                  },
                ),
                ListTile(
                  title: Text('Available Activities'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AvailableActivities()));
                  },
                ),
                ListTile(
                  title: Text("Account"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AccountPage()));
                  },
                ),
                Container(
                  height: ((MediaQuery.of(context).size.height + 150) / 2) - 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}