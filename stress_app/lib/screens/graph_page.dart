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
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatefulWidget {
  @override
  _BodyLayoutState createState() => _BodyLayoutState();
}

class _BodyLayoutState extends State<BodyLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
          'Graph Page'
      ),
    );
  }
}