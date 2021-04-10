import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/helpers/bar_code_scanner.dart';
import 'package:visionariesmobileapp/screens/check_inventory_screen.dart';
import 'package:visionariesmobileapp/screens/find_site_location.dart';
import 'package:visionariesmobileapp/screens/login_screen.dart';
import 'package:visionariesmobileapp/screens/move_items_screen.dart';
import 'package:visionariesmobileapp/screens/today_service.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:visionariesmobileapp/utils/user_feedback_utils.dart';




class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String barcode = "";

  @override
  void initState() {
    // Will execute the downloadInfo method
    isLoggedIn();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        decoration: BoxDecoration(

            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Theme.of(context).primaryColorDark,
              Theme.of(context).primaryColor
            ])),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // LOGO OF THE HOME SCREEN
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Image(
                  height: MediaQuery.of(context).size.height * .30,
                  image: AssetImage('images/logo.png'),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  height: MediaQuery.of(context).size.height * .15,
                  width: 320,


                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    splashColor: Theme.of(context).accentColor,

                    onPressed: () {
                      Navigator.pushNamed(context, TodayServices.routeName);
                    },


                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[

                        Icon(
                          Icons.hardware,
                          color: Colors.black,
                          size: 50,
                        ),

                        SizedBox(
                          height: kSmallMargin,
                        ),

                        Text(
                          'Work Orders',
                          style: TextStyle(color: Colors.black87 , fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: kLargeMargin,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  height: MediaQuery.of(context).size.height * .15,
                  width: 150,


                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    splashColor: Theme.of(context).accentColor,

                    onPressed: () {
                      Navigator.pushNamed(context, FindSiteLocation.routeName);
                    },


                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[

                        Icon(
                          Icons.add_location,
                          color: Colors.black,
                          size: 50,
                        ),

                        SizedBox(
                          height: kSmallMargin,
                        ),


                        Text(
                          'Find Site',
                          style: TextStyle(color: Colors.black87 , fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: kLargeMargin,
                ),

                Container(
                  height: MediaQuery.of(context).size.height * .15,
                  width: 150,


                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    splashColor: Theme.of(context).accentColor,

                    onPressed: (){
                      Navigator.pushNamed(context, CheckInventory.routeName);
                    },


                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[

                        Icon(
                          Icons.home_repair_service_sharp,
                          color: Colors.black,
                          size: 50,
                        ),

                        SizedBox(
                          height: kSmallMargin,
                        ),

                        Text(
                          'Check Inventory',
                          style: TextStyle(color: Colors.black87 , fontSize: 15),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),




            SizedBox(
              width: kLargeMargin,
              height: kLargeMargin,
            ),


            // MOVE ITEMS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  height: MediaQuery.of(context).size.height * .15,
                  width: 150,

                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    splashColor: Theme.of(context).accentColor,

                    onPressed: () {
                      Navigator.pushNamed(context, MoveItems.routeName);
                    },


                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Icon(
                          Icons.local_shipping_outlined,
                          color: Colors.black,
                          size: 50,
                        ),

                        SizedBox(
                          height: kSmallMargin,
                        ),


                        Text(
                          'Move Items',
                          style: TextStyle(color: Colors.black87 , fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: kLargeMargin,
                ),


                Container(
                  height: MediaQuery.of(context).size.height * .15,
                  width: 150,


                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    splashColor: Theme.of(context).accentColor,

                    onPressed: () {
                      logout();
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },


                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Icon(
                          Icons.logout,
                          color: Colors.black,
                          size: 50,
                        ),

                        SizedBox(
                          height: kSmallMargin,
                        ),

                        Text(
                          'Logout',
                          
                          style: TextStyle(color: Colors.black87 , fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  logout() async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     sharedPreferences.clear();
  }

  isLoggedIn() async {
    
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      print(sharedPreferences.getString(USER_ID_KEY));

      if(sharedPreferences.getString(USER_ID_KEY) == null){
          Navigator.pushNamed(context, LoginScreen.routeName);
      }
    }

    catch (e){
      print("Error happened on isLoggedIn");
    }
  }
}
