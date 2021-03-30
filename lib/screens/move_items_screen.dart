
import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/utils/alert_utils.dart';
import 'package:visionariesmobileapp/utils/user_feedback_utils.dart';

import 'package:http/http.dart' as http;


class MoveItems extends StatefulWidget {

  static final String routeName = '/move';


  @override
  _MoveItemsState createState() => _MoveItemsState();
}

class _MoveItemsState extends State<MoveItems> {
  bool _isLoading = false;
  String barcode = "";
  String qty = "";
  String actionIdentifier = "";
  final TextEditingController quantity = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Move items"
        ),
      ),

      body: Container(

        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).primaryColor
                ])),


        child: Column(

          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text(
                    "Scan Item:  ",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.090,
                  ),


                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    iconSize: 50,
                    onPressed: (){
                      scan();
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text(
                    "Input Quantity:",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.05,
                  ),

                  //quantitySection(),

                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),


                    child: TextField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      controller: quantity,
                      // THIS LINE OF CODE IS SAVING THE INPUT DATA TO THE EMAIL STRING
                      onChanged: (value) {
                        qty = value;
                      },
                      keyboardType: TextInputType.emailAddress,

                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 25,
            ),

            moveItemFromStore(),
            moveItemBackToWarehouse(),


          ],
        ),
      ),
    );
  }



  Future scan() async{
    try{
      String barcode = await BarcodeScanner.scan();
      this.barcode = barcode;

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
  }


  Move_This_Item() async {
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'upc': barcode,
      'quantity': qty,
      'action' : actionIdentifier
    };
    var jsonResponse = null;


    try {
      // CREATE THIS VARIABLE ON THE CLASS SO IT CAN BE CHANGE EASILY
      String myApiUrl = EMULATOR_API_URL + PORT_NUMBER;

      var response = await http.post(myApiUrl + API_SERVICES_URL_AUTH,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }, body: jsonEncode(data));

      print(response.statusCode);

      if (response.statusCode == 200) {

        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });

          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_QUANTITY").show();
        }
      }

      else if (response.statusCode == 401) {
        if (response.reasonPhrase == 'UNAUTHORIZED') {
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

    catch (e) {
      print(e);
    }
  }


  ElevatedButton moveItemFromStore() {
    return ElevatedButton(
      // color: Theme.of(context).primaryColor,
      // splashColor: Theme.of(context).accentColor,
      style: ElevatedButton.styleFrom(
        primary: Colors.black
      ),
      onPressed: () {

        actionIdentifier = "1";

        if (barcode == "" && quantity.text == ""){
          print("Hello world");
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_BOTH_TO_WAREHOUSE").show();
        }

        else if (barcode != "" && quantity.text == ""){
          print("Hello world");
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_QUANTITY").show();
        }

        else if (barcode == "" && quantity.text != ""){
          print("Hello world");
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_BARCODE").show();
        }

        else{
          Move_This_Item();
        }



        print(MediaQuery.of(context).size.height * 0.15,);
      },
      child: Text(
        "Move Item",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }

  ElevatedButton moveItemBackToWarehouse() {
    return ElevatedButton(
      // color: Theme.of(context).primaryColor,
      // splashColor: Theme.of(context).accentColor,
      style: ElevatedButton.styleFrom(
          primary: Colors.black
      ),
      onPressed: () {

        actionIdentifier = "2";

        if (barcode == "" && quantity.text == ""){
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_BOTH_TO_WAREHOUSE").show();
        }

        else if (barcode != "" && quantity.text == ""){
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_QUANTITY").show();
        }

        else if (barcode == "" && quantity.text != ""){
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_BARCODE").show();
        }

        else{
          Move_This_Item();
        }

        print(MediaQuery.of(context).size.height * 0.15,);
      },
      child: Text(
        "Move Item back to warehouse",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }

}
