
import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/screens/find_site_location.dart';
import 'package:visionariesmobileapp/screens/login_screen.dart';
import 'package:visionariesmobileapp/screens/today_service.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),


//      body: Container(
//          child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//
//               Container(
//                 height: kScreenHeight,
//
//                 decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                    begin: Alignment.topCenter,
//                    end: Alignment.bottomCenter,
//                    colors: [Theme.of(context).primaryColorDark, Theme.of(context).primaryColor]
//                  )
//
//                ),
//
//
//
//                 child: Column(
//                    children: <Widget>[
//
//
//                      // Button for today services
//                      FlatButton(
//                        color: Theme.of(context).primaryColor,
//                        splashColor: Theme.of(context).accentColor,
//
//                        child: Text('Today Services', style: TextStyle(color: Colors.black87),),
//                        onPressed: () {
//                          // THIS LINE OF CODE WILL HANDLE THE PRESS FROM THE USER
//                          // AND CHANGE SCREENS
//
//                          // Jumps to the Today Services page
//                          Navigator.pushNamed(context, TodayServices.routeName);
//                        },
//                      ),
//
//
//                      SizedBox(
//                        width: kSmallMargin,
//                        height: kSmallMargin,
//                      ),
//
//
//
//                      // Button for find site location
//                      FlatButton(
//                        color: Theme.of(context).primaryColor,
//                        splashColor: Theme.of(context).accentColor,
//
//                        child: Text('Find Site Location', style: TextStyle(color: Colors.black87),),
//                        onPressed: () {
//                          /* THIS LINE OF CODE WILL HANDLE THE PRESS FROM THE USER
//                              AND CHANGE SCREENS
//                          * */
//
//                          // Jumps to the Find Site Location page
//                          Navigator.pushNamed(context, FindSiteLocation.routeName);
//                        },
//                      ),
//
//
//                      SizedBox(
//                        width: kSmallMargin,
//                        height: kSmallMargin,
//                      ),
//
//
//
//                      // Button logout
//                      FlatButton(
//                        color: Theme.of(context).primaryColor,
//                        splashColor: Theme.of(context).accentColor,
//
//                        child: Text('Logout', style: TextStyle(color: Colors.black87),),
//                        onPressed: () {
//                          // THIS LINE OF CODE WILL HANDLE THE PRESS FROM THE USER
//                          // AND CHANGE SCREENS
//
//                          // Jumps back to Login Screen page
//                          Navigator.pushNamed(context, LoginScreen.routeName);
//                        },
//                      ),
//                    ],
//                 ),
//               )
//              ]
//          ),
//
//      ),



    );
  }
}
