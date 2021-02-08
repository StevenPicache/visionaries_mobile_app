import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/screens/auth_screen.dart';



class LoginScreen extends StatefulWidget {
  static final String routeName = '/';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.black,
        title: Text("Visionaries Employee App"),
      ),


      body: Container(

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
                    height: 250,
                    image: AssetImage('images/logo.png'),
                  ),
                ),
              ),




              Container(
                height: 100,
                alignment: Alignment.center,


                child: Row(

                  children: <Widget>[

                    // Just to create a space between
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
                      height: 100,

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
                              fontSize: 60.0,
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



              // LOGIN BUTTON
              FlatButton(
                color: Theme.of(context).primaryColor,
                splashColor: Theme.of(context).accentColor,

                child: Text('Register', style: TextStyle(color: Theme.of(context).primaryColorDark),),
                onPressed: () {
                  // THIS LINE OF CODE WILL HANDLE THE PRESS FROM THE USER
                  // AND CHANGE SCREENS
                  Navigator.pushNamed(context, AuthenticationScreen.routeName, arguments: false);
                },
              ),





            ],
          ),
        ),
      ),
    );
  }
}
