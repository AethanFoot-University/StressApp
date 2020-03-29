import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:stress_app/screens/stress_relief/breathe_page.dart';
import 'package:stress_app/screens/stress_relief/music_page.dart';
import 'package:stress_app/style/theme_colours.dart';

class StressReliefPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: ThemeColours.SECONDARY_BACKGROUND_COLOR,
      ),
      child: _BodyLayout(),
    );
  }
}

class _BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
        ),
        _ReliefWidget(null,
            'General',
            'Combining multiple of these excercises is best, for example listening '
                'to soothing music while walking.'),
        _ReliefWidget(BreathePage((MediaQuery.of(context).size.height - 150) ~/ 40),
            'Breathing Help',
            'To help with stress you can do breathing excercies for 10-20 minutes '
                'once or twice aday. Trying to do these excercises the same time '
                'everyday will help build a routine.'),
        _ReliefWidget(MusicPage(isWidget: false,),
            'Soothing Music',
            'Soothing music can help you remove yourself from the world around you '
            'by giving you something to concentrate on.'),
        _ReliefWidget(null,
            'Excercise',
            'Doing regular excercise not only can help you with stress, but can '
                'help also help you with your sleep and your confidence.'),
        _ReliefWidget(null,
            'Supplements',
            'There are various supplements that you can take to help with stress,'
                'these include:\n'
                '- Lemon Balm\n'
                '- Omega-3 Fatty Acids\n'
                '- Ashwagandha\n'
                '- Green Tea\n'
                'However be causious when taking supplements as they can interact with '
                'medications or have side effects.'),
      ],
    );
  }
}

class _ReliefWidget extends StatelessWidget {
  final _child;
  final _title;
  final _text;
  bool _nextPage;

  _ReliefWidget(this._child, this._title, this._text) {
    this._nextPage = this._child != null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !_nextPage ? null : () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => _child));
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ThemeColours.PRIMARY_BACKGROUND_COLOR,
              border: Border.all(
                color: ThemeColours.PRIMARY_BACKGROUND_COLOR,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    _title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    _text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  _nextPage ? Icon(
                    OMIcons.keyboardArrowRight,
                    color: Colors.white,
                  ) : SizedBox(height: 0,),
                ],
              ),
            )
        ),
      ),
    );
  }
}
