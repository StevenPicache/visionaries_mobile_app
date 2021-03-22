
import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/screens/home_screen.dart';

import 'package:visionariesmobileapp/utils/alert_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthenticationScreen extends StatefulWidget {
  static final String routeName = '/auth';
  final bool isLogin;

  // Constructor
  AuthenticationScreen(this.isLogin);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {


  bool _isLoading = false;


  //final FirebaseAuth _auth = FirebaseAuth.instance; // Using the firebase auth
  User user;
  String username = '';
  String password = '';


  String API_LOG_IN_URL = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        // This line means that if the user is Logged in, The page will show 'Login'
        // if not, the page will show, 'Register'

        title: Text(widget.isLogin ? 'Login' : 'Register'),
      ),


      body: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Theme.of(context).primaryColorDark, Theme.of(context).primaryColor]
          ),
        ),

        child: ProgressHUD(
          child: Builder(
            builder: (context) => Padding(
              padding: EdgeInsets.all(kLargeMargin),
              child: Column(
                children: <Widget>[

                  loginHeader(),

                  SizedBox(height: kLargeMargin),

                  emailSection(),

                  passwordSection(),

                  SizedBox(height: kLargeMargin),

                  loginButton(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Flexible loginHeader(){
    return Flexible(
      child: Row(
        children: [
          Expanded(
            child: Image(image: AssetImage('images/logo.png')),
          ),
          SizedBox(width: kSmallMargin),
          Expanded(
            child: ScaleAnimatedTextKit(
              repeatForever: true,
              textAlign: TextAlign.center,
              text: ['Login', 'Sign-in'],
              textStyle: TextStyle(fontSize: 25, color: Theme.of(context).primaryColorLight),
            ),
          )
        ],
      ),
    );
  }


  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();



  TextField emailSection(){
    return TextField(
      controller: emailController,
      // THIS LINE OF CODE IS SAVING THE INPUT DATA TO THE EMAIL STRING
      onChanged: (value) {
        username = value;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Email', icon: Icon(Icons.alternate_email)),
    );
  }

  TextField passwordSection(){
    return TextField(
      controller: passwordController,
      // THIS LINE OF CODE IS SAVING THE INPUT DATA TO THE EMAIL STRING
      onChanged: (value) {
        password = value;
      },
      obscureText: true, // Hiding the input password
      decoration: InputDecoration(
          hintText: 'Password', icon: Icon(Icons.lock)),
    );
  }




  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': username,
      'password': password
    };
    var jsonResponse = null;


    try{
      // CREATE THIS VARIABLE ON THE CLASS SO IT CAN BE CHANGE EASILY
      String myApiUrl = EMULATOR_API_URL + PORT_NUMBER;

      var response = await http.post(myApiUrl + API_SERVICES_URL_AUTH ,headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, body: jsonEncode(data));

      print(response.statusCode);


      if(response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if(jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });

          sharedPreferences.setString("token", jsonResponse['access_token']);
          print(jsonResponse['access_token']);
          print(sharedPreferences.getString("token"));

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
                  (Route<dynamic> route) => false);
        }
      }

      else if (response.statusCode == 401){
        if(response.reasonPhrase == 'UNAUTHORIZED'){
            AlertUtils.getErrorAlert(context, "ERROR_USER_NOT_FOUND").show();
        }

      }


      else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
    }

    catch(e){
      print(e);
    }
  }


  FlatButton loginButton(){
    return FlatButton(
      color: Theme.of(context).primaryColorDark,
      splashColor: Theme.of(context).accentColor,

      // widget.isLogin = means if the user pressses enter, then Flat button will be the login operation
      // widget.isLogin = register, register functionality will be executed
      child: Text(
        widget.isLogin ? 'LOGIN' : 'REGISTER',
        style: TextStyle(color: Colors.white),
      ),


      // Handles the logic when the button is pressed
      onPressed: (){

        if (emailController.text == "" && passwordController.text == ""){
            print("Hello world");
            AlertUtils.getErrorAlert(context, "ERROR_INVALID_EMAIL_AND_PASSWORD").show();
        }

        else if(emailController.text == "" && passwordController.text != ""){
            AlertUtils.getErrorAlert(context, "ERROR_INVALID_EMAIL").show();
        }


        else if(emailController.text != "" && passwordController.text == ""){
          AlertUtils.getErrorAlert(context, "ERROR_INVALID_PASSWORD").show();
        }

        else{
          setState(() {
          _isLoading = true;
        });

        signIn(emailController.text, passwordController.text);
        }
      },
    );
  }
}
