import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/screens/find_site_location.dart';
import 'package:visionariesmobileapp/screens/login_screen.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Screen",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
          Widget>[
        Container(
          //height: MediaQuery.of(context).size.height,

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),
                child: Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Image(
                      height: 250,
                      image: AssetImage('images/logo.png'),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    height: 100,
                    width: 150,


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
                            'Today Services',
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
                    height: 100,
                    width: 150,


                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      splashColor: Theme.of(context).accentColor,

                      onPressed: (){
                          scan();
//                        var returned_barcode = scanner.scan();
//                        print(returned_barcode);
//                        print("");
//
                        FeedbackUtils.showFeedbackAlert(context, barcode).show();
//                        print(returned_barcode);
//                        print("");
//                        //AlertUtils.getErrorAlert(context, "ERROR_USER_NOT_FOUND").show();


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
                            'Inventory',
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
                    height: 100,
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
                    height: 100,
                    width: 150,


                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      splashColor: Theme.of(context).accentColor,

                      onPressed: () {
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
        )
      ]),
    );
  }




  Future scan() async{


    try{
      String barcode = await BarcodeScanner.scan();
      this.barcode = barcode;
      print(barcode);
      print(" ");

    } on PlatformException catch(e){

      if (e.code == BarcodeScanner.CameraAccessDenied){
        this.barcode = "Camera persmission not granted";
      }

      else{
        this.barcode = "Unknown error: $e";
      }
    } on FormatException{
      this.barcode = "null, User did not finish the scan and just left";
    }

    catch(e){
      this.barcode = "Unknown error: $e";
    }

//    Alert(context: context, title: "My UPC code", desc: returned_barcode);

  }



}
