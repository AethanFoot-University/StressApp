import 'package:flutter/material.dart';
import 'package:stress_app/screens/stress_relief/breathe_page.dart';
import 'package:stress_app/screens/stress_relief/music_page.dart';

class StressReliefPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color(0xff101010),
      ),
      child: BodyLayout(),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
        ),
        ReliefWidget(null, false,
            'General',
            'Combining multiple of these excercises is best, for example listening '
                'to soothing music while walking.'),
        ReliefWidget(BreathePage((MediaQuery.of(context).size.height - 150) ~/ 40), true,
            'Breathing Help',
            'To help with stress you can do breathing excercies for 10-20 minutes '
                'once or twice aday. Trying to do these excercises the same time '
                'everyday will help build a routine.'),
        ReliefWidget(MusicPage(false), true,
            'Soothing Music',
            'Soothing music can help you remove yourself from the world around you '
            'by giving you something to concentrate on.'),
        ReliefWidget(null, false,
            'Excercise',
            'Doing regular excercise not only can help you with stress, but can '
                'help also help you with your sleep and your confidence.'),
        ReliefWidget(null, false,
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

class ReliefWidget extends StatelessWidget {
  final child;
  final title;
  final text;
  final nextPage;

  ReliefWidget(this.child, this.nextPage, this.title, this.text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => child));
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xff424242),
              border: Border.all(
                color: Color(0xff424242),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  nextPage ? Icon(
                    Icons.arrow_right,
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
