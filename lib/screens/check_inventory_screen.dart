import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/models/Items.dart';
import 'package:visionariesmobileapp/components/items_card.dart';
import 'package:http/http.dart' as http;
import 'package:visionariesmobileapp/utils/user_feedback_utils.dart';

/*
*   NAME    :   CheckInventory
*   PURPOSE :   This class will load the UI for the shop inventory page
*
* */


class CheckInventory extends StatefulWidget {

  static final String routeName = '/check';

  @override
  _CheckInventoryState createState() => _CheckInventoryState();
}

class _CheckInventoryState extends State<CheckInventory> {

  String itemToSearch = "";
  List<Items> item = [];


  final TextEditingController itemController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Shop inventory")
      ),

      body: SingleChildScrollView(
        child: Container(

          height: MediaQuery.of(context).size.height,

          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme
                      .of(context)
                      .primaryColorDark,

                  Colors.grey,
                  Colors.grey,

                ]),
          ),

          child: Column(
            children: <Widget>[

              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),

              Text(
                "Enter the item name",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white
                ),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: new TextFormField(

                maxLines: 1,
                controller: itemController,

                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter username.';
                  }
                 },

                 onChanged: (value) {
                  itemToSearch = value;
                },

                style: TextStyle(fontSize: 15, color: Colors.white),
                decoration: new InputDecoration(
                    hintText: "Camera, Key Fobs",
                    suffixIcon: new IconButton(
                      highlightColor: Colors.transparent,
                      icon: new Container(width: 36.0, child: new Icon(Icons.clear)),
                      onPressed: () {
                        itemController.clear();
                      },
                      splashColor: Colors.transparent,
                    ),
                  ),
                ), // This trailing comma makes auto-formatting nicer for build methods.
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                RaisedButton(

                  color: Theme.of(context).primaryColor,
                  splashColor: Theme.of(context).accentColor,

                  onPressed: () {
                    Determine_What_Action(itemToSearch);
                  },
                  child: Text(
                      "Search",
                  ),
                ),
              ],
            ),


              Container(
                height: MediaQuery.of(context).size.height * .60,
                width: MediaQuery.of(context).size.width * .95,

                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),


                // creating height dynamically
                child: ListView.builder(
                  itemBuilder: (context, index) {
                      return ItemCard(
                        item: item[index],
                      );
                   },
                   itemCount: item.length,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  /*
  * FUNCTION    : parseInventoryDetails
  *
  * DESCRIPTION :  parse the JSON return from the API and properly store the data from the URL to the item class
  *
  * PARAMETERS  : response    - stores the returned JSON data from the API
  *
  * RETURNS     : NONE
  */
  parseInventoryDetails(response){
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      List<Items> tempInventoryItems = [];
      Map<String, dynamic> map = result;
      int i = 0;
      int dataLength = map['inventory'].length;

      while (i < dataLength) {
        tempInventoryItems.add(Items(
          item_name: map['inventory'][i]['item_name'] ??
            'No data was received from server',
          item_quantity: map['inventory'][i]['item_quantity'].toString() ??
            'No data was received from server',
          item_manufacturer: map['inventory'][i]['Manufacturer'] ??
            'No data was received from server'));
        i += 1;
      };

      setState(() {
        item = tempInventoryItems;
      });
    } 
        
    else {
      print(response.statusCode);
    }
  }


  /*
  * FUNCTION    : Determine_What_Action
  *
  * DESCRIPTION : requests the API for the items that are in the shop
  *
  * PARAMETERS  : String itemName - stores the input in the input textfield and use that as a parameter for them item search
  *
  * RETURNS     : NONE
  */

  Determine_What_Action(String itemName) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userID = sharedPreferences.getString(USER_ID_KEY);
    String authKey = sharedPreferences.getString(USER_TOKEN_KEY);
    
    try {
      if(itemName == ""){

        try{
          String urlDevice = ""+API_URL_AND_PORT_NUMBER+""
              ""+API_SERVICES_URL_INVENTORY+"";

          final response = await http.get(
            Uri.parse(urlDevice),
            headers: {HttpHeaders.authorizationHeader: "JWT $authKey"},
          );
          print(response.statusCode);
          parseInventoryDetails(response);
        }

        catch(e){
          print(e);
        }
      }

      else{
         try{
           String url = ""+API_URL_AND_PORT_NUMBER+""
               ""+API_SERVICES_URL_ITEM_SEARCH+
               "/$itemName";

           final response = await http.get(
             Uri.parse(url),
             headers: {HttpHeaders.authorizationHeader: "JWT $authKey"},
           );

           parseInventoryDetails(response);
           itemToSearch="";
           itemController.clear();

        }

        catch(e){
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
