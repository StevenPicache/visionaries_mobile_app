import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/helpers/auth_screen.dart';

// Loads the UI for the Login page
/*
*   NAME    :   LoginScreen
*   PURPOSE :   loads the UI for the login screen
*
* */
class LoginScreen extends StatefulWidget {
  static final String routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {

    // Creates the UI for the login screen
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).primaryColorDark, Theme.of(context).primaryColor]
            ),
        ),

        child: Padding(
          padding: EdgeInsets.all(kSmallMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              // LOGO OF THE HOME SCREEN
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Image(
                    height: MediaQuery.of(context).size.height * 0.4,
                    image: AssetImage('images/logo.png'),
                  ),
                ),
              ),

              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,

                child: Row(
                  children: <Widget>[

                    SizedBox(
                      width: kSmallMargin,
                      height: kSmallMargin,
                    ),


                    Text(
                      "The",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),


                    SizedBox(
                      width: kSmallMargin,
                      height: kSmallMargin,
                    ),

                    // Visionaries part
                    Container(
                    height: MediaQuery.of(context).size.height * .10,

                    child: RotateAnimatedTextKit(
                        repeatForever: true,
                        onTap: () {
                          print("Tap Event");
                        },
                        text: [
                          "Visionaries",
                          "Visionaries",
                          "Visionaries",
                        ],
                        textStyle: TextStyle(
                            fontSize: 50.0,
                            fontFamily: "Horizon",
                            color: Colors.white,

                        ),
                        textAlign: TextAlign.left),
                      ),
                  ],
                ),
              ),


              SizedBox(
                width: kSmallMargin,
                height: kLargeMargin,
              ),


              // LOGIN BUTTON
              FlatButton(
                color: Theme.of(context).primaryColor,
                splashColor: Theme.of(context).accentColor,

                child: Text('Login', style: TextStyle(color: Theme.of(context).primaryColorDark),),
                onPressed: () {
                  // THIS LINE OF CODE WILL HANDLE THE PRESS FROM THE USER
                  // AND CHANGE SCREENS
                  Navigator.pushNamed(context, AuthenticationScreen.routeName, arguments: true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
