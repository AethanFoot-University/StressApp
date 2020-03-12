import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyLayout(context),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 24.0),
        alignment: Alignment.bottomLeft,
        child: FloatingActionButton(
          splashColor: Colors.transparent,
          backgroundColor: Colors.purple,
          child: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Center(
              child: Text(
                  'Ballers Account'
              ),
            ),
          ),
        ],
      ),
    );
  }
}