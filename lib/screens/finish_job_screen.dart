



import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visionariesmobileapp/components/jobequipments_card.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/models/JobEquipment.dart';
import 'package:visionariesmobileapp/models/services.dart';

import 'package:http/http.dart' as http;


class FinishJob extends StatefulWidget {
  static final String routeName = '/finish';

  final Services finishService;
  const FinishJob({this.finishService});




  @override
  _FinishJobState createState() => _FinishJobState();
}

class _FinishJobState extends State<FinishJob> {

  List<String> itemsUsed = [];
  List<JobEquipment> myEquipments = [];
  bool isEnable = true;

  @override
  void initState() {
    getItems();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.finishService.work_name)),
      body: Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery
                .of(context)
                .size
                .height
        ),

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

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.finishService.work_name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        color: Theme
                            .of(context)
                            .primaryColorLight,
                      ),
                    ),
                  ),


                  SizedBox(
                    width: kSmallMargin,
                  ),


                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Image(
                        height: 150,
                        image: AssetImage('images/logo.png'),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                width: kSmallMargin,
                height: kSmallMargin,
              ),

              // SITE CONTACT
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),
                child: Row(

                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Site Technician:",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Theme
                                  .of(context)
                                  .primaryColorLight,
                            ),
                          ),
                        ]
                    ),

                    const SizedBox(
                      width: 43.0,
                    ),


                    Expanded(
                      child: Text(
                        widget.finishService.site_technician,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Theme
                              .of(context)
                              .primaryColorLight,
                        ),
                      ),
                    ),


                    SizedBox(
                      width: kSmallMargin,
                      height: 50,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: kSmallMargin,
              ),


              // // JOB DESCRIPTION
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kLargeMargin),
                    child: Text(
                      "Swipe to remove items used: ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Theme
                            .of(context)
                            .primaryColorLight,
                      ),
                    ),
                  )
                ],
              ),


              SizedBox(
                width: kSmallMargin,
                height: kSmallMargin,
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),

                height: MediaQuery.of(context).size.height * .55,
                width: MediaQuery.of(context).size.width * .80,

                // --------------------------------------------
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction){
                        removeItem(index);

                      },
                      child: JobEquipmentCard(
                        jobEquipment: myEquipments[index],
                      ),
                    );
                  },
                  itemCount: myEquipments.length,
                ),
                // --------------------------------------------
              ),





              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(kLargeMargin),
                    child: RaisedButton(
                      color: Colors.black,
                      child: Text(
                        "Finish Task",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // SEND REPORT

                        //print(itemsUsed.length);
                        print(itemsUsed[0].toString());
                        //print("HELLO WORLD");
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  getItems() async {
    try {
      //
      // String myApiUrl = EMULATOR_API_URL + PORT_NUMBER;

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      print(sharedPreferences.get('userid'));
      Map data = {
        // 'userid': sharedPreferences.get('userid'),
        'workOrderId': widget.finishService.work_id
      };


      String urlAndroid = "http://10.0.2.2:5000/jobsites/2";
      final response = await http.get(urlAndroid);
      // var response = await http.post(urlAndroid,
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     }, body: jsonEncode(data));

      print(response.statusCode);

      parseData(response);
    } catch (e) {
      String urlIOS = "http://127.0.0.1:5000/jobsites/2";
      final response = await http.get(urlIOS);
      // Map data = {
      //   // 'userid': sharedPreferences.get('userid'),
      //   'workOrderId': widget.finishService.work_id
      // };
      //
      // var response = await http.post(urlIOS,
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     }, body: jsonEncode(data));

      print(response.statusCode);
      parseData(response);
    }
  }

  parseData(var response) {
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      List<JobEquipment> tempEquipments = [];
      Map<String, dynamic> map = result;
      int i = 0;
      int dataLength = map['items'].length;

      while (i < dataLength) {

        try{
          tempEquipments.add(JobEquipment(
            job_equipment_name: map['items'][i]['Item'] ??
                'No data was received from server',
            job_equipment_id: map['items'][i]['equipment_Id'].toString() ??
                'No data was received from server',));
          i += 1;
        }

         catch (e){
          print(e);
         }
      };

      try{
        setState(() {
          myEquipments = tempEquipments;
        });
      }
      catch(e){
        print(e);
      }
    }

    else {
      print(response.statusCode);
    }
  }

  void removeItem(int index) {
    setState(() {
      itemsUsed.add(myEquipments[index].job_equipment_id);
      myEquipments.removeAt(index);
    });
  }
}
