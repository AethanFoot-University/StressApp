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
    sc = ScrollController(initialScrollOffset: ((MediaQuery.of(this.context).size.height + 150) / 4) - 75);
    super.initState();
  }

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
              controller: sc,
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: ((MediaQuery.of(context).size.height + 150) / 4) - 75,
                ),
                ListTile(
                  title: Text('Graph Breakdown'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GraphAnalysisView()));
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
                  height: ((MediaQuery.of(context).size.height + 150) / 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}