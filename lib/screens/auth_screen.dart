import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/screens/home_screen.dart';

import 'package:visionariesmobileapp/utils/alert_utils.dart';





class AuthenticationScreen extends StatefulWidget {
  static final String routeName = '/auth';
  final bool isLogin;

  // Constructor
  AuthenticationScreen(this.isLogin);





  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance; // Using the firebase auth


  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        // This line means that if the user is Logged in, The page will show 'Login'
        // if not, the page will show, 'Register'

        title: Text(widget.isLogin ? 'Login' : 'Register'),
      ),

      body: ProgressHUD(
        child: Builder(
          builder: (context) => Padding(
            padding: EdgeInsets.all(kLargeMargin),
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        child: Image(image: AssetImage('images/logo.png')),
                      ),
                      SizedBox(width: kSmallMargin),
                      Expanded(
                        child: ScaleAnimatedTextKit(
                          textAlign: TextAlign.center,
                          text: ['Login', 'Sign-in'],
                          textStyle: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: kLargeMargin),


                TextField(
                  // THIS LINE OF CODE IS SAVING THE INPUT DATA TO THE EMAIL STRING
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Email', icon: Icon(Icons.alternate_email)),
                ),
                TextField(
                  // THIS LINE OF CODE IS SAVING THE INPUT DATA TO THE EMAIL STRING
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true, // Hiding the input password
                  decoration: InputDecoration(
                      hintText: 'Password', icon: Icon(Icons.lock)),
                ),


                SizedBox(height: kLargeMargin),



                FlatButton(
                  color: Theme.of(context).primaryColor,
                  splashColor: Theme.of(context).accentColor,

                  // widget.isLogin = means if the user pressses enter, then Flat button will be the login operation
                  // widget.isLogin = register, register functionality will be executed
                  child: Text(
                    widget.isLogin ? 'LOGIN' : 'REGISTER',
                    style: TextStyle(color: Colors.white),
                  ),

                  // Handles the logic when the button is pressed
                  onPressed: () async {
                    final progress = ProgressHUD.of(context);
                    progress.showWithText(widget.isLogin ? 'Loggin in' : 'Registering');

                    Navigator.pushNamed(context, HomeScreen.routeName);
//                    if(widget.isLogin){
//                      await loginUser(context);
//                    }
//
//                    else{
//                      // Logic for the registration of the user
//                      await registerUser(context);
//                    }

                    progress.dismiss();
                  },
                )
              ],
            ),
          ),
        ),
      ),




    );
  }




  /*
  *   This is the refractored logic of the loginUser feature
  *
  * */
  Future <int> loginUser(BuildContext context) async {
    try
    {
      // await will automatically create a background thread
      // goes to the firebase and start fincding the user
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      print("SUCCESS LOGIN");
      // If success, jump to group screen
      Navigator.pushNamed(context, HomeScreen.routeName);
      return 1;
    }

    catch (e){
      print(e); // for debugging purposes
      print("Failed logging in");
      AlertUtils.getErrorAlert(context, e.code).show(); // sends the user an alert message
      return 0;
    }
  }


  /*
  *   This came from the extracted logic of the user register feature
  *
  *   Will basically use the firebase app and register a user
  * */
  Future <bool> registerUser(BuildContext context) async {
    try {
      await  _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print("Register Success");
      return true;
    }

    catch (e) {
      print(e);

      AlertUtils.getErrorAlert(context, e.code).show();
      return false;
    }
  }


}
