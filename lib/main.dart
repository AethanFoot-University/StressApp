import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stress_app/screens/signin_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SignIn(),
    );
  }
}


