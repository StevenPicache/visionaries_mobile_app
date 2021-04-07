



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/models/Items.dart';
import 'package:visionariesmobileapp/components/items_card.dart';
import 'package:http/http.dart' as http;
import 'package:visionariesmobileapp/utils/user_feedback_utils.dart';


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
          title: Text("Tasks")
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
                  print("Helloo Raised button");
                },
                child: Text(
                    "Search",
                ),
              ),
            ],
          ),





            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * .55,
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
            ),
          ],
        ),
      ),
    );
  }


  getInventoryDetails(response){
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
          item_location: map['inventory'][i]['item_location'] ??
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

  Determine_What_Action(String itemName) async {
    try {
      if(itemName == ""){

        try{
          String urlDevice = ""+MY_COMPUTER_API_URL_IOS+""
              ""+API_SERVICES_URL_INVENTORY+"";

          final response = await http.get(urlDevice);
          getInventoryDetails(response);
          print(response.statusCode);
        }

        catch(e){
          String urlAndroid = ""+EMULATOR_API_URL_IOS+""
            ""+API_SERVICES_URL_INVENTORY+"";

          final response = await http.get(urlAndroid);
          getInventoryDetails(response);
        }

        finally{
          String urlAndroid = ""+EMULATOR_API_URL_ANDROID+""
              ""+API_SERVICES_URL_INVENTORY+"";

          final response = await http.get(urlAndroid);
          getInventoryDetails(response);
        }

      }

      else{


         try{
           String urlDevice = ""+MY_COMPUTER_API_URL_IOS+""
              ""+API_SERVICES_URL_ITEM_SEARCH+
              "/$itemName";

            final response = await http.get(urlDevice); 
            getInventoryDetails(response);
            itemToSearch="";
            itemController.clear();;
        }

        catch(e){
                  
          String urlAndroid = ""+EMULATOR_API_URL_ANDROID+""
              ""+API_SERVICES_URL_ITEM_SEARCH+
              "/$itemName";

            final response = await http.get(urlAndroid); 
            getInventoryDetails(response);
            itemToSearch="";
            itemController.clear();
        }

        finally{
           String urlIOS = ""+EMULATOR_API_URL_IOS+""
              ""+API_SERVICES_URL_ITEM_SEARCH+
              "/$itemName";

            final response = await http.get(urlIOS); 
            getInventoryDetails(response);
            itemToSearch="";
            itemController.clear();
        }




      }
    } catch (e) {
      print(e);
    }
  }


}
