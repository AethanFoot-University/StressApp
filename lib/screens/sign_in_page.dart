import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stress_app/data/User.dart';
import 'package:stress_app/screens/home/homepage.dart';
import 'package:stress_app/tools/Json.dart';

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
            color: Color(0xff101010),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
               ClipRRect(
                 borderRadius: BorderRadius.circular(8.0),
                 child: Container(
                   width: MediaQuery.of(context).size.width - 32,
                   child: Image.asset(
                     'assets/images/Bugsy.png',
                     fit: BoxFit.contain,
                   ),
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
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FutureBuilder(
                            future: Json.readUser('Aethan'),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                User.currentUser = new User('Aethan', 'ajf75@bath.ac.uk', [0, 1], List());
                                Json.saveUser(User.currentUser);
                              } else if (snapshot.hasData) {
                                User.currentUser = snapshot.data;
                                print(User.currentUser.name);
                              } else {
                                return Center(
                                  child: Text(
                                    'Loading...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                              return MyHomePage();
                            }
                          )
                        )
                      );

//                      await Json.readUser('Aethan').then
//                        ((value) {
//                          setState(() {
//                            User.currentUser = value;
//                            print(User.currentUser.name);
//                          });
//                        },
//                        onError: (e) {
//                          setState(() {
//                            User.currentUser = new User('Aethan', 'ajf75@bath.ac.uk', [0, 1], List());
//                            Json.saveUser(User.currentUser);
//                          });
//                        }
//                      );
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => MyHomePage()));
                    }
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}