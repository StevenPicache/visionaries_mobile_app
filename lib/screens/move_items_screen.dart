
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
                        fontSize: 35,
                        color: Colors.white
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      iconSize: 50,
                      onPressed: () {
                        
                        upcController.clear();
                        String retVal = scan().toString();
                       

                        setState(() {
                          upcController.text = barcode;
                        });
                      },
                    ),
                  ),
                ],
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
                          fontSize: 35,
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


  Move_This_Item(param1_upc, param2_quantity, param4_identifier) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String param3_userid = sharedPreferences.getString(USER_ID_KEY);

    try {
      String urlAndroid = EMULATOR_API_URL_ANDROID
          +"/"
          "$param1_upc/"
          "$param2_quantity/"
          "$param3_userid/"
          "$param4_identifier";

      print(urlAndroid);

      final response = await http.get(urlAndroid);
      print(response.statusCode);
      move(response);
    }

    catch (e) {
      String urlIOS = EMULATOR_API_URL_IOS
          +"/"
          "$param1_upc/"
          "$param2_quantity/"
          "$param3_userid/"
          "$param4_identifier";
      final response = await http.post(urlIOS);
      print(response.statusCode);
      move(response);
    }


    finally{
      String urlDevice = MY_COMPUTER_API_URL_IOS
          +"/"
              "$param1_upc/"
              "$param2_quantity/"
              "$param3_userid/"
              "$param4_identifier";
      final response = await http.post(urlDevice);
      print(response.statusCode);
      move(response);
    }

  }

  move(response) {
    if (response.statusCode == 200) {
      response = json.decode(response.body);
      FeedbackUtils.showFeedbackAlert(context, "ITEM_MOVE_SUCCESS").show();
    }
    if (response.statusCode == 256) {
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
          primary: Colors.black,
      ),

      onPressed: () {
        barcode = "ABC123";

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

  ElevatedButton Move_Item_Truck_To_Warehouse() {
    return ElevatedButton(
      // color: Theme.of(context).primaryColor,
      // splashColor: Theme.of(context).accentColor,
      style: ElevatedButton.styleFrom(primary: Colors.black),


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
          Move_This_Item(barcode, qty, "truckToWarehouse");
        }
      },
      child: Text(
        "To Warehouse",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }
}

