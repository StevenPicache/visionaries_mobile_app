import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/components/services_card.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/models/services.dart';


import 'package:http/http.dart' as http;

class TodayServices extends StatefulWidget {
  static final String routeName = '/today';



  @override
  _TodayServicesState createState() => _TodayServicesState();
}

class _TodayServicesState extends State<TodayServices> {
  List<Services> myServices = [];



  @override
  void initState() {
    // Will execute the downloadInfo method
    //_downloadEmployeeServices();
    getCategories();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Today Services", style: TextStyle(fontSize: 25, color: Colors.black87),)),

      /* The code up here will be the API request of all
      * the jobs for this specific day
      *
      * It is also good better to consider to only get the 7 days for the job
      * */

      body: Center(

        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme
                    .of(context)
                    .primaryColorDark, Theme
                    .of(context)
                    .primaryColor
                ]
            ),
          ),

          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[


                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kLargeMargin),
                      child: Text(
                        "Services for today",
                        style: TextStyle(fontSize: 30.0, color: Theme
                            .of(context)
                            .primaryColor),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: kLargeMargin,
                  ),

                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Image(
                        height: 175,
                        image: AssetImage('images/logo.png'),
                      ),
                    ),
                  ),


                ],
              ),

              SizedBox(height: kSmallMargin, width: kSmallMargin,),


              Container(

                height: 375,
                width: 400,

                child: ListView.builder(
                  itemBuilder: (context, index) {

                    return ServicesCard(
                      service: myServices[index],
                    );
                  },
                  itemCount: myServices.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  getCategories() async {

    try {
      final response = await http.get("http://10.0.2.2:5000/workorders");
      final int counter = 0;

      if (response.statusCode == 200) {
        final result = json.decode(response.body);


        print(response.body);


        List<Services> tempServices = [];
        Map<String, dynamic> map =  result;
        int i = 0;
        int dataLength = map['workOrders'].length;

        while(i < dataLength){
          tempServices.add(
              Services(
                  work_name: map['workOrders'][i]['Title'],
                  site_address: map['workOrders'][i]['Address'],
                  site_technician: map['workOrders'][i]['Contact_Name'],
                  site_technician_contact_number: map['workOrders'][i]['Contact_Cell'],
                  date_requested: map['workOrders'][i]['Date_Requested'],
                  order_creator: map['workOrders'][i]['Requested_By'],
                  job_description: map['workOrders'][i]['Scope_of_Work'],
                  date_scheduled: map['workOrders'][i]['Sceduled_For']
                )
            );
          print(i);
          i += 1;
        };

          print("SUCCESS");

          setState(() {
            myServices = tempServices;
          });
        }
      else {
        print(response.statusCode);
      }
    }

    catch (e){
      print (e);
    }
  }





}