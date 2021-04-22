
import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/utils/alert_utils.dart';
import 'package:visionariesmobileapp/utils/user_feedback_utils.dart';

import 'package:http/http.dart' as http;

/*
*   NAME    :   MoveItems
*   PURPOSE :   loads the UI for the moving of the items with the methods to make it work
*
* */

class MoveItems extends StatefulWidget {

  static final String routeName = '/move';

  @override
  _MoveItemsState createState() => _MoveItemsState();
}

class _MoveItemsState extends State<MoveItems> {
  String barcode = "";
  String qty = "";

  final TextEditingController upcController = new TextEditingController();
  final TextEditingController quantity = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
            "Move items"
        ),
      ),

      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black
          ),
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

        height: MediaQuery.of(context).size.height,


        child: Column(
          children: [

            Flexible(
              child: Hero(
                tag: 'logo',
                child: Image(
                  height: 175,
                  image: AssetImage('images/logo.png'),
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.0125,
            ),

            Expanded(
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text(
                              "Input Item code:  ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),

                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.0125,
                            ),

                            Expanded(
                              flex: 2,
                              child: ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                ),

                                onPressed: () {
                                  upcController.clear();
                                  String retVal = scan().toString();

                                  setState(() {
                                    upcController.text = barcode;
                                  });
                                },

                                child: Text(
                                  "Scan",
                                   style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),


                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.0125,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,

                              child: new TextFormField(
                                maxLines: 1,
                                controller: upcController,

                                onChanged: (value) {
                                  barcode = value;
                                },

                                style: TextStyle(fontSize: 20, color: Colors.white),

                                decoration: new InputDecoration(
                                  hintText: "UPC code...",

                                  suffixIcon: new IconButton(
                                    highlightColor: Colors.transparent,
                                    icon: new Container(width: 20.0, child: new Icon(Icons.clear)),
                                    onPressed: () {
                                      upcController.clear();
                                    },
                                    splashColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),


                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.0125,
                        ),

                        Row(
                          children: [

                            Expanded(
                              flex: 2,
                              child: Text(
                                "Input Quantity:",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
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
                            ),
                          ],
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),



                        Row(
                          children: <Widget> [
                            Expanded(
                                flex: 2,
                                child: Container(
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    child: Move_Item_Warehouse_To_Truck()
                                )
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.025,
                            ),

                            Expanded(
                                flex: 2,
                                child: Container(
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    child: Move_Item_Truck_To_Warehouse()
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future scan() async {
    try {

      String str_barcode = await BarcodeScanner.scan();
      this.barcode = str_barcode;
      setState(() {
        upcController.text = str_barcode;
      });

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

    return barcode;
  }



  /*
  *   FUNCTION    : Move_Item_Warehouse_To_Truck
  *
  *   DESCRIPTION : Will move the item from warehouse to truck
                    Checks the parameter and send the proper error message to the user
                    If the parameters are valid, then a function call to Move_this_item
                    will be executed
  *
  *   PARAMETERS  : none
  *
  *   RETURNS     : NONE
  */

  ElevatedButton Move_Item_Warehouse_To_Truck() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.black,
      ),

      onPressed: () {
        if (barcode == "" && quantity.text == "") {
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_BOTH_TO_WAREHOUSE").show();
        }

        else if (barcode != "" && quantity.text == "") {
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_QUANTITY").show();
        }

        else if (barcode == "" && quantity.text != "") {
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_BARCODE").show();
        }

        else {
          Move_This_Item(barcode, qty, "warehouseToTruck");
        }
      },
      child: Text(
        "To Truck",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }


  /*
  *   FUNCTION    : Move_Item_Truck_To_Warehouse
  *
  *   DESCRIPTION : Will move the item from warehouse to truck
                    Checks the parameter and send the proper error message to the user
                    If the parameters are valid, then a function call to Move_this_item
                    will be executed
  *
  *   PARAMETERS  : none
  *
  *   RETURNS     : NONE
  */

  ElevatedButton Move_Item_Truck_To_Warehouse() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.black),
      onPressed: () {
        if (barcode == "" && quantity.text == "") {
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_BOTH_TO_WAREHOUSE").show();
        }

        else if (barcode != "" && quantity.text == "") {
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_QUANTITY").show();
        }

        else if (barcode == "" && quantity.text != "") {
          FeedbackUtils.showFeedbackAlert(context, "ERROR_INVALID_BARCODE_CHECK_INVENTORY").show();
        }

        else {
          Move_This_Item(barcode, qty, "truckToWarehouse");
        }
      },

      child: Text(
        "To Shop",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }


  /*
  *   FUNCTION    : Move_This_Item
  *
  *   DESCRIPTION : Functions that will have prepare the query to the API with
                    the input parameters and run it in the backgroup using async
                    and await
  *
  *   PARAMETERS  : param1_upc          -   upc code 
                    param2_quantity     -   item quantity
                    param4_identifier   -   action identifier
  *
  *   RETURNS     : NONE
  */

  Move_This_Item(param1_upc, param2_quantity, param4_identifier) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userID = sharedPreferences.getString(USER_ID_KEY);
    String authKey = sharedPreferences.getString(USER_TOKEN_KEY);

    try {
      String url = API_URL_AND_PORT_NUMBER
          +"${API_SERVICES_URL_INVENTORY}/"
              "$param1_upc/"
              "$param2_quantity/"
              "$userID/"
              "$param4_identifier";

      print(url);
      final response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: "JWT $authKey"},
      );
      print(response.statusCode);
      queryResponseCode(response);
    }

    catch (e) {
      print(e);
    }
  }


  /*
  *   FUNCTION    : Move_This_Item
  *
  *   DESCRIPTION : Functions that will have prepare the query to the API with
                    the input parameters and run it in the backgroup using async
                    and await
  *
  *   PARAMETERS  : param1_upc          -   upc code 
                    param2_quantity     -   item quantity
                    param4_identifier   -   action identifier
  *
  *   RETURNS     : NONE
  */
  queryResponseCode(response) {
    if (response.statusCode == 200) {
      response = json.decode(response.body);
      FeedbackUtils.showFeedbackAlert(context, "ITEM_MOVE_SUCCESS").show();
    }
    
    else if (response.statusCode == 256) {
      response = json.decode(response.body);
      
      FeedbackUtils.showFeedbackAlert(context, "NOT_ENOUGH_QUANTITY_TRUCK_TO_WAREHOUSE").show();
    }

    else if (response.statusCode == 257) {
      response = json.decode(response.body);
      FeedbackUtils.showFeedbackAlert(context, "NOT_ENOUGH_QUANTITY_WAREHOUSE_TO_TRUCK").show();
    }

    else if (response.statusCode == 258) {
      response = json.decode(response.body);
      FeedbackUtils.showFeedbackAlert(context, "ERROR_CODE_258").show();
    }

    else if (response.statusCode == 260) {
      response = json.decode(response.body);
      FeedbackUtils.showFeedbackAlert(context, "ERROR_CODE_260").show();
    }

    else if (response.statusCode == 500) {
      response = json.decode(response.body);
      FeedbackUtils.showFeedbackAlert(context, "ERROR_CODE_500").show();
    }

    else if (response.statusCode == 404) {
      //response = json.decode(response.body);
      FeedbackUtils.showFeedbackAlert(context, response.reasonPhrase.toString()).show();
    }

    else{
      response = json.decode(response.body);
      FeedbackUtils.showFeedbackAlert(context, "Not found").show();
    }

  }


}

