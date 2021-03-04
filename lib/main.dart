import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:visionariesmobileapp/screens/auth_screen.dart';
import 'package:visionariesmobileapp/screens/find_site_location.dart';
import 'package:visionariesmobileapp/screens/home_screen.dart';
import 'package:visionariesmobileapp/screens/login_screen.dart';
import 'package:visionariesmobileapp/screens/today_service.dart';

void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      /*Initialize the app to start at the login screen first before getting inside the application*/
      //initialRoute: LoginScreen.routeName,

      // FOR DEBUGGING PURPOSES. I MADE TO TO START WITH THE HOME SCREEN INSTEAD OF LOGIN SCREEN
      //initialRoute: LoginScreen.routeName,
      initialRoute: HomeScreen.routeName,

      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{

          /*
          * This are the initialization of the screen that we will need for the development
          * */

          // LoginScreen page
          LoginScreen.routeName: (context) => LoginScreen(),

          // Authentication Screen page
          AuthenticationScreen.routeName: (context) => AuthenticationScreen(settings.arguments),

          // Screens on home screen
          //** All screens that is create must be declared here or else it wont work
          HomeScreen.routeName: (context) => HomeScreen(),
          TodayServices.routeName: (context) => TodayServices(),
          FindSiteLocation.routeName: (context) => FindSiteLocation(),

        };

        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },

      theme: ThemeData(
          primaryColor: Colors.white,
          primaryColorDark: Colors.black87,
          primaryColorLight: Colors.white,

          primaryTextTheme: TextTheme(bodyText1: TextStyle(color : Colors.black)),
          accentColor: Colors.lightGreenAccent),


    );

  }
}
