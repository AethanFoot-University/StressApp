import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stress_app/screens/home/homepage.dart';
import 'package:stress_app/style/theme_colours.dart';
import 'package:stress_app/tools/unsplash_grabber.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
            color: ThemeColours.SECONDARY_BACKGROUND_COLOR,
          ),
          child: Center(
            child: Column(
              children: <Widget>[
               ClipRRect(
                 borderRadius: BorderRadius.circular(8.0),
                 child: Container(
                   width: MediaQuery.of(context).size.width - 32,
                   child: UnsplashGrabber.generateWidget("calm", 'assets/images/Bugsy.png'),
                 ),
               ),
                SizedBox(
                  height: 150.0,
                ),
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    child: Image.asset(
                      'assets/images/Microsoft_Logo.bmp',
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage())),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}