import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GraphPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your Graphs',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Your Graphs'),
        ),
        body: BodyLayout(context),
      ),
    );
  }
}

class BodyLayout extends StatefulWidget {
  final BuildContext parentContext;

  BodyLayout(this.parentContext);

  @override
  _BodyLayoutState createState() => _BodyLayoutState(parentContext);
}

class _BodyLayoutState extends State<BodyLayout> {
  final BuildContext parentContext;

  _BodyLayoutState(this.parentContext);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Ink(
                  decoration: ShapeDecoration(
                    color: Colors.purple,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(parentContext, false),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}