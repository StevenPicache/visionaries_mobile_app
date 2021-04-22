import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visionariesmobileapp/components/jobequipments_card.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/models/JobEquipment.dart';
import 'package:visionariesmobileapp/models/services.dart';
import 'package:visionariesmobileapp/screens/home_screen.dart';
import 'package:visionariesmobileapp/utils/user_feedback_utils.dart';



/*
*   NAME    :   FinishJob
*   PURPOSE :   This class will load the UI for the Finish Job page on where the logiC for finishing
*               the service and sending the report of items used back to the API will be handled
*
* */


class FinishJob extends StatefulWidget {
  static final String routeName = '/finish';

  final Services finishService;
  const FinishJob({this.finishService});


  @override
  _FinishJobState createState() => _FinishJobState();
}

class _FinishJobState extends State<FinishJob> {

  List<String> itemsUsedList = [];
  String itemUsed = "";
  List<JobEquipment> myEquipments = [];


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
                            "Site contact:",
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
                width: MediaQuery.of(context).size.width * .70,

                // --------------------------------------------
                // gives the swiping feature to remove the item
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

                        String work_id = widget.finishService.work_id;
                        finish_task(work_id, itemUsed);

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


  /*
  * FUNCTION    : getItems
  *
  * DESCRIPTION : requests the API for the items that is assigned with this Job_id and is currently on stocked
  *               and available for used.
  *
  * PARAMETERS  : NONE
  *
  * RETURNS     : NONE
  */

  getItems() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userID = sharedPreferences.getString(USER_ID_KEY);
    String authKey = sharedPreferences.getString(USER_TOKEN_KEY);
    String work_id = widget.finishService.work_id;

    try {
      String urlAndroid = ""+API_URL_AND_PORT_NUMBER+"/jobsites/$work_id";

      print(urlAndroid);
      
      final response = await http.get(
        Uri.parse(urlAndroid),
        headers: {HttpHeaders.authorizationHeader: "JWT $authKey"},
      );

      print(response.statusCode);
      parseData(response);

    } catch (e) {
      String urlIOS = ""+EMULATOR_API_URL_IOS+"/jobsites/$work_id";
      final response = await http.get(
        Uri.parse(urlIOS),
        headers: {HttpHeaders.authorizationHeader: "JWT $authKey"},
      );
      
      print(response.statusCode);
      parseData(response);
    }
  }



  /*
  * FUNCTION    : parseData
  *
  * DESCRIPTION :  decodes the JSON return data from the API and parse it
  *
  * PARAMETERS  : NONE
  *
  * RETURNS     : NONE
  */

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

      setState(() {
        myEquipments = tempEquipments;
      });
    }

    else {
      print(response.statusCode);
    }
  }


  /*
  * FUNCTION    : removeItem
  *
  * DESCRIPTION :  saving the ID of the item used and building a string that are filled with
  *                the item id of the items that are used.
  *
  * PARAMETERS  : int index   -   the index of the item on the dismissble listview. So we can refresh the page
  *                               and removed the item that was already used.
  *
  * RETURNS     : NONE
  */

  void removeItem(int index) {
    setState(() {
      itemsUsedList.add(myEquipments[index].job_equipment_id);
      itemUsed = itemUsed + myEquipments[index].job_equipment_id + ",";
      myEquipments.removeAt(index);
    });
  }



  /*
  * FUNCTION    : finish_task
  *
  * DESCRIPTION :  decodes the JSON return data from the API and parse it
  *
  * PARAMETERS  : String workID   -  stores the workID for this service.
  *               String itemIds  -  stores the itemId for the items that are
  *
  * RETURNS     : NONE
  */

  void finish_task(String workID, String itemIds) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userID = sharedPreferences.getString(USER_ID_KEY);
    String authKey = sharedPreferences.getString(USER_TOKEN_KEY);

    // this statement is when the user has item used to report back
    if(workID != null && itemIds.length != 0) {
      String itemsString = itemIds.substring(0,itemIds.length - 1);

      try {
        String urlAndroid = ""+API_URL_AND_PORT_NUMBER+""
          ""+API_SERVICES_URL_TASK_FINISHED+
          "/$userID/$workID/$itemsString";

          final response = await http.get(
            Uri.parse(urlAndroid),
             headers: {HttpHeaders.authorizationHeader: "JWT $authKey"},
          );
          Sending_Feedback_Alert(response);
        }

      // This is optional. This can be remove if the API is already hosted of a computer or hosted on the web
      catch (e) {
        print(e);
      }
    }


    else{
      try {
        String urlAndroid = ""+API_URL_AND_PORT_NUMBER+""
            ""+API_SERVICES_URL_WORKORDERS_WITHOUT_ITEMS+
            "/$userID/$workID";
            
        print(urlAndroid);

        final response = await http.get(
          Uri.parse(urlAndroid),
          headers: {HttpHeaders.authorizationHeader: "JWT $authKey"},
        );
        Sending_Feedback_Alert(response);
      }

      catch (e) {
        print(e);
      }
    }
  }


  /*
  * FUNCTION    : Sending_Feedback_Alert
  *
  * DESCRIPTION :  gives user feedback if the report was sent successfully or not
  *
  * PARAMETERS  : response - stores the response code from the API
  *
  * RETURNS     : NONE
  */

  Sending_Feedback_Alert(response){
    if(response.statusCode == 200){
      FeedbackUtils.showFeedbackAlert(context, "TASK_REPORT_SUCCESS").show();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }

    else{
      FeedbackUtils.showFeedbackAlert(context, "ERROR_TASK_REPORT_FAILED").show();
    }
  }
}
