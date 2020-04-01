import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import 'package:stress_app/data/User.dart';
import 'package:stress_app/screens/home/youtube_embed.dart';
import 'package:stress_app/screens/stress_level_overview.dart';
import 'package:stress_app/screens/stress_relief/music_page.dart';

import 'package:stress_app/style/theme_colours.dart';

import 'package:stress_app/tools/Json.dart';

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  bool editing = false;
  bool changed = false;
  List<Widget> children = [
    StressLevelOverview(true),
    MusicPage(isWidget: true,),
  ];
  List<int> order = [0, 1];

  @override
  void initState() {
    super.initState();
    if (User.currentUser.homeOrder != null) order = User.currentUser.homeOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColours.SECONDARY_BACKGROUND_COLOR,
      floatingActionButton: FloatingActionButton(
        mini: true,
        elevation: 0.0,
        highlightElevation: 0.0,
        disabledElevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        splashColor: Colors.transparent,
        backgroundColor: ThemeColours.PRIMARY_BUTTON_BACKGROUND,
        foregroundColor: ThemeColours.SECONDARY_BUTTON_BACKGROUND,
        child: editing ? Icon(OMIcons.save) : Icon(OMIcons.edit),
        onPressed: () {
          if (changed) {
            Json.saveUser(User.currentUser);
            changed = false;
          }
          setState(() {
            editing = !editing;
          });
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          //color: Color(0xff101010),
        ),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: children.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) return YoutubeEmbed();

            return _HomeWidget(this, children[order[index - 1]], index - 1);
          }
        ),
      ),
    );
  }
}

class _HomeWidget extends StatelessWidget {
  final _HomePageBodyState parent;
  final child;
  int pos;

  _HomeWidget(this.parent, this.child, this.pos);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        height: 250,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: child,
              ),
            ),
            parent.editing ? Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(OMIcons.keyboardArrowUp),
                  color: Colors.white,
                  onPressed: () {
                    if (pos != 0) updatePos(pos - 1);
                  },
                ),
                IconButton(
                  icon: Icon(OMIcons.keyboardArrowDown),
                  color: Colors.white,
                  onPressed: () {
                    if (pos != parent.children.length - 1) updatePos(pos + 1);
                  },
                ),
              ],
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }

  void updatePos(int newPos) {
    var temp = parent.order[newPos];
    parent.setState(() {
      parent.order[newPos] = parent.order[pos];
      parent.order[pos] = temp;
      parent.changed = true;
    });
  }
}

