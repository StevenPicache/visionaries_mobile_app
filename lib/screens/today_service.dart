import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/components/services_card.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/models/services.dart';

import 'package:http/http.dart' as http;
import 'package:visionariesmobileapp/utils/alert_utils.dart';

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
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Today Services",
        style: TextStyle(fontSize: 25, color: Colors.black87),
      )),

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
                colors: [
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).primaryColor
                ]),
          ),
          child: Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Services for today",
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.left,
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


                SizedBox(
                  height: kSmallMargin,
                  width: kSmallMargin,
                ),



                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .65,
                    width: MediaQuery.of(context).size.width * .95,

                    // creating height dynamically
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ServicesCard(
                          service: myServices[index],
                        );
                      },
                      itemCount: myServices.length,

                    ),
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }

  getCategories() async {
    try {
      //String urlAndroid = "http://10.0.2.2:5000/workorders";
      String urlAndroid = ""+EMULATOR_API_URL_ANDROID+""
          ""+PORT_NUMBER+
          ""+API_SERVICES_URL_WORKORDERS+"";

      final response = await http.get(urlAndroid);
      parseData(response);

    } catch (e) {
      //String urlIOS = "http://127.0.0.1:5000/workorders";
      String urlIOS = ""+EMULATOR_API_URL_IOS+""
          ""+PORT_NUMBER+
          ""+API_SERVICES_URL_WORKORDERS+"";

      final response = await http.get(urlIOS);
      parseData(response);
    }

    finally{
      print(e);
    }
  }


  parseData(var response){
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      List<Services> tempServices = [];
      Map<String, dynamic> map = result;
      int i = 0;
      int dataLength = map['workOrders'].length;

      while (i < dataLength) {

        try{
          tempServices.add(Services(
            work_name: map['workOrders'][i]['Title'] ??
                'No data was received from server',
            site_address: map['workOrders'][i]['Address'] ??
                'No data was received from server',
            site_technician: map['workOrders'][i]['Contact_Name'] ??
                'No data was received from server',
            site_technician_contact_number: map['workOrders'][i]['Contact_Cell'] ??
                'No data was received from server',
            date_requested: map['workOrders'][i]['Date_Requested'] ??
                'No data was received from server',
            order_creator: map['workOrders'][i]['Requested_By'] ??
                'No data was received from server',
            job_description: map['workOrders'][i]['Scope_of_Work'] ??
                'No data was received ',
            date_scheduled: map['workOrders'][i]['Sceduled_For'] ??
                'No data was received from server',
            work_id: map['workOrders'][i]['Job_ID'].toString() ??
                'No data was received from server',));
          i += 1;
        }

        catch (e){
          print(e);
        }

      };

      setState(() {
        myServices = tempServices;
      });
    } else {
      print(response.statusCode);
    }
  }
}
