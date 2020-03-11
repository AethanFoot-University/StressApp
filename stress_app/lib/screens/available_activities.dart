import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailableActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Available Activities',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Available Activities'),
        ),
        body: BodyLayout(context),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  final BuildContext parentContext;

  BodyLayout(this.parentContext);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                'Many Activities'
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(8.0),
            child: FloatingActionButton(
              splashColor: Colors.transparent,
              backgroundColor: Colors.purple,
              child: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(parentContext),
            ),
          ),
        ],
      ),
    );
  }
}