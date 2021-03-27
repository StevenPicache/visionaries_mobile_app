



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/constants.dart';


import 'package:visionariesmobileapp/models/Items.dart';
import 'package:visionariesmobileapp/components/items_card.dart';

import 'package:http/http.dart' as http;


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

        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery.of(context).size.width,

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

              style: TextStyle(fontSize: 15),
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

                // constraints: BoxConstraints(
                //     minHeight: 100,
                // ),
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


  getInventoryDetails(String upcCode) async {
    try {

      String urlAndroid = "http://10.0.2.2:5000/workorders";
      String urlIOS = "http://127.0.0.1:5000/workorders";

      final response = await http.get(urlIOS);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        List<Items> tempInventoryItems = [];
        Map<String, dynamic> map = result;
        int i = 0;
        int dataLength = map['workOrders'].length;

        while (i < dataLength) {
          // tempInventoryItems.add(Items(
          //     work_name: map['workOrders'][i]['Title'] ??
          //         'No data was received from server',
          //     site_address: map['workOrders'][i]['Address'] ??
          //         'No data was received from server',
          //     site_technician: map['workOrders'][i]['Contact_Name'] ??
          //         'No data was received from server',
          //     site_technician_contact_number: map['workOrders'][i]
          //     ['Contact_Cell'] ??
          //         'No data was received from server',
          //     date_requested: map['workOrders'][i]['Date_Requested'] ??
          //         'No data was received from server',
          //     order_creator: map['workOrders'][i]['Requested_By'] ??
          //         'No data was received from server',
          //     job_description: map['workOrders'][i]['Scope_of_Work'] ??
          //         'No data was received ',
          //     date_scheduled: map['workOrders'][i]['Sceduled_For'] ??
          //         'No data was received from server'));
          // i += 1;
        };

      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }


}
