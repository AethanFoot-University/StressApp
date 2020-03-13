import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stress_app/screens/available_activities.dart';
import 'package:stress_app/screens/graph_analysis_view.dart';
import 'account_page.dart';

class SideDrawer extends StatefulWidget {
  final BuildContext context;

  SideDrawer(this.context);

  @override
  _SideDrawerState createState() => _SideDrawerState(context);
}

class _SideDrawerState extends State<SideDrawer> {
  final BuildContext context;
  ScrollController sc;

  _SideDrawerState(this.context);

  @override
  void initState() {
    sc = ScrollController(initialScrollOffset: ((MediaQuery.of(this.context).size.height) / 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double headerHeight = MediaQuery.of(context).size.height * 3 / 19.2;

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: headerHeight,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: null,
            ),
          ),
          Expanded(
            child: ListView(
              controller: sc,
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: ((MediaQuery.of(context).size.height) / 2),
                ),
                Container(
                  height: 75,
                  child: ListTile(
                    title: Text('Graph Breakdown'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GraphAnalysisView()));
                    },
                  ),
                ),
                Container(
                  height: 75,
                  child: ListTile(
                    title: Text('Available Activities'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AvailableActivities()));
                    },
                  ),
                ),
                Container(
                  height: 75,
                  child: ListTile(
                    title: Text("Account"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AccountPage()));
                    },
                  ),
                ),
                Container(
                  height: ((MediaQuery.of(context).size.height) - (225 + headerHeight)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}