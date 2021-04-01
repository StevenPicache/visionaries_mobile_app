
import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                  Theme
                      .of(context)
                      .primaryColorDark,
                  Theme
                      .of(context)
                      .primaryColor
                ])),


        child: Column(

          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.15,
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .height * 0.090,
                  ),


                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    iconSize: 50,
                    onPressed: () {
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .height * 0.05,
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

            Move_Item_Warehouse_To_Truck(),
            Move_Item_Truck_To_Warehouse(),


          ],
        ),
      ),
    );
  }


  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      this.barcode = barcode;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        this.barcode = "Camera persmission not granted";
      }
      else {
        this.barcode = "Unknown error: $e";
      }
    } on FormatException {
      this.barcode = "null, User did not finish the scan and just left";
    }

    catch (e) {
      this.barcode = "Unknown error: $e";
    }
  }


  Move_This_Item(param1_upc, param2_quantity, param4_identifier) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    //String param1_upc = "ABC123";
    // String param2_quantity = "2";
    // String param3_identifier = "add";

    String param1_upc = "ABC123";
    String param2_quantity = "10";
    String param3_userid = sharedPreferences.getString(USER_ID_KEY);
  
    print(param4_identifier);
   
    try {
      String urlAndroid = "http://10.0.2.2:5000/inventory/$param1_upc/$param2_quantity/$param3_userid/$param4_identifier";
      //String urlAndroid = "http://10.0.2.2:5000/inventory/ABC123/5/2/warehouseToTruck";

      final response = await http.get(urlAndroid);
      print(response.statusCode);
      move(response);
    }
    catch (e) {
      String urlIOS = "http://127.0.0.1:5000/inventory/$param1_upc/$param2_quantity/$param3_userid/$param4_identifier";
      final response = await http.post(urlIOS);
      print(response.statusCode);
      move(response);
    }

  }

  move(response) {
    if (response.statusCode == 200) {

      response = json.decode(response.body);

      FeedbackUtils.showFeedbackAlert(context, "ITEM_MOVE_SUCCESS").show();
    }

    else if (response.statusCode == 256) {

      response = json.decode(response.body);
      FeedbackUtils.showFeedbackAlert(context, "NOT_ENOUGH_QUANTITY_WAREHOUSE_TO_TRUCK").show();
    }

    else if (response.statusCode == 257) {

      response = json.decode(response.body);
      FeedbackUtils.showFeedbackAlert(context, "NOT_ENOUGH_QUANTITY_TRUCK_TO_WAREHOUSE").show();
    }

  }


  ElevatedButton Move_Item_Warehouse_To_Truck() {
    return ElevatedButton(
      // color: Theme.of(context).primaryColor,
      // splashColor: Theme.of(context).accentColor,
      style: ElevatedButton.styleFrom(
          primary: Colors.black
      ),
      onPressed: () {
        barcode = "ABC123";

        if (barcode == "" && quantity.text == "") {
          print("Hello world");
          FeedbackUtils.showFeedbackAlert(
              context, "ERROR_INVALID_BOTH_TO_WAREHOUSE").show();
        }

        else if (barcode != "" && quantity.text == "") {
          print("Hello world");
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_QUANTITY")
              .show();
        }

        else if (barcode == "" && quantity.text != "") {
          print("Hello world");
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_BARCODE")
              .show();
        }

        else {
          Move_This_Item(barcode, qty, "warehouseToTruck");
        }


        print(MediaQuery
            .of(context)
            .size
            .height * 0.15,);
      },
      child: Text(
        "Move Item",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }

  ElevatedButton Move_Item_Truck_To_Warehouse() {
    return ElevatedButton(
      // color: Theme.of(context).primaryColor,
      // splashColor: Theme.of(context).accentColor,
      style: ElevatedButton.styleFrom(
          primary: Colors.black
      ),
      onPressed: () {
        actionIdentifier = "2";

        if (barcode == "" && quantity.text == "") {
          FeedbackUtils.showFeedbackAlert(
              context, "ERROR_INVALID_BOTH_TO_WAREHOUSE").show();
        }

        else if (barcode != "" && quantity.text == "") {
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_QUANTITY")
              .show();
        }

        else if (barcode == "" && quantity.text != "") {
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_BARCODE")
              .show();
        }

        else {
          Move_This_Item(barcode, qty, "truckToWarehouse");
        }

        print(MediaQuery
            .of(context)
            .size
            .height * 0.15,);
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

