import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:stress_app/data/User.dart';
import 'package:stress_app/style/theme_colours.dart';
import 'package:stress_app/tools/email_sender.dart';
import 'package:stress_app/tools/line_painter.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColours.SECONDARY_BACKGROUND_COLOR,
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatefulWidget {
  _BodyLayoutState createState() => _BodyLayoutState();
}

class _BodyLayoutState extends State<BodyLayout> {
  bool isDarkMode = true;
  bool sendInfo = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          main(context),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ThemeColours.PRIMARY_BUTTON_BACKGROUND,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    OMIcons.keyboardArrowLeft,
                    color: ThemeColours.SECONDARY_BUTTON_BACKGROUND,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget main(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        '${User.currentUser.name}\n'
                            '${User.currentUser.email}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeColours.PRIMARY_BUTTON_BACKGROUND,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: FlatButton(
                            splashColor: Colors.transparent,
                            child: Text(
                              'Sign out',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ThemeColours.SECONDARY_BUTTON_BACKGROUND,
                              ),
                            ),
                            onPressed: () {
                              EmailSender.sendEmail();
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/'));
                            }
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text(
                  'App Setting',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              CustomPaint(
                painter: LinePainter(),
              ),
              SwitchListTile(
                title: Text(
                  'Dark Mode',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                value: isDarkMode,
                onChanged: (val) {
                  setState(() {
                    isDarkMode = val;
                  });
                },
              ),
              SwitchListTile(
                title: Text(
                  'Send Stress Information to University',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                value: sendInfo,
                onChanged: (val) {
                  setState(() {
                    sendInfo = val;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}