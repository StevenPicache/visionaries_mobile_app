/*
*   THIS WILL THE SCREEN WILL GO HERE IF THE USER TRIES
*   TAPPED ON ONE OF THE LISTVIEW CARDS
*
* */

import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/models/services.dart';
import 'package:visionariesmobileapp/screens/finish_job_screen.dart';

class DetailsScreen extends StatelessWidget {
  @override
  // a references to the services object that contains all the information of the card
  final Services serviceDetails;
  const DetailsScreen({this.serviceDetails});


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),


      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height
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
                      serviceDetails.work_name,
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kLargeMargin),
                    child: Text(
                      "Job Description: ",
                      style: TextStyle(
                        fontSize: 30.0,
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


              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),

                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            serviceDetails.job_description,
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme
                                    .of(context)
                                    .primaryColorDark),
                          ),
                        ),
                      ),
                    ),
                  )
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
                          "Site Contact:",
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
                        serviceDetails.site_technician,
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
              ),


              SizedBox(
                width: kSmallMargin,
                height: kSmallMargin,
              ),



              // SITE CONTACT
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),
                  child: Row(
                    children: [
                      Text(
                        "Contact Phone:",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Theme
                              .of(context)
                              .primaryColorLight
                        ),
                      ),

                      const SizedBox(
                        width: 20.0,
                      ),

                      Expanded(
                        child: Text(
                          serviceDetails.site_technician_contact_number,
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
                ),
              ),

              SizedBox(
                width: kSmallMargin,
                height: kSmallMargin,
              ),

              // Site addresses
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),
                  child: Row(

                    children: [
                      Text(
                        "Site Address:",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Theme
                              .of(context)
                              .primaryColorLight,
                        ),
                      ),

                      const SizedBox(
                        width: 40.0,
                      ),

                      Expanded(
                        child: Text(
                          serviceDetails.site_address,
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
                ),
              ),

              SizedBox(
                width: kSmallMargin,
                height: kSmallMargin,
              ),


              // Schedule date
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),
                  child: Row(
                    children: [
                      Text(
                        "Scheduled Date:",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Theme
                              .of(context)
                              .primaryColorLight,
                        ),
                      ),


                      const SizedBox(
                        width: 15.0,
                      ),


                      Expanded(
                        child: Text(
                          // class the format schedule date function
                          // to fix the format of date scheduled
                          Format_Schedule_Date(serviceDetails.date_scheduled),

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
                ),
              ),

              SizedBox(
                width: kSmallMargin,
                height: kSmallMargin,
              ),

              
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),
                  child: Row(
                    children: [
                      Text(
                        "Technicians: ",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Theme
                              .of(context)
                              .primaryColorLight,
                        ),
                      ),

                      const SizedBox(
                        width: 43.0,
                      ),

                      Expanded(
                        child: Text(
                          serviceDetails.site_technician,
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
                ),
              ),

              SizedBox(
                width: kSmallMargin,
                height: MediaQuery.of(context).size.height * .0125,
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(kLargeMargin),
                    child: FlatButton(
                      color: Colors.black,
                      child: Text(
                        "Complete Job",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => FinishJob(finishService: serviceDetails,)));
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
  * FUNCTION : Format_Schedule_Date
  *
  * DESCRIPTION : formats the schedule date and remove the 2 " on the beginning and end
  *             and make it more presentable
  *
  * PARAMETERS : myData - string that stores the schedule data with "" in front and end.
  *
  * RETURNS : NONE
  */


  String Format_Schedule_Date(myDate){
    int strLength = myDate.length;
    String myStr = myDate.substring(1,strLength - 1);
    print(myStr);
    return myStr;
  }
}
