import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your Account',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Your Account'),
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
                  'Ballers Account'
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