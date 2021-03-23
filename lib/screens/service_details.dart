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


  final String test1 =
      "asDKJAKLSJZXC,MNASLKDJQIOWEJASDASDQWEASDMNASLKDJQIOWEJASDASDQWEASD"
      "MNASLKDJQIOWEJASDASDQWEASD"
      "MNASLKDJQIOWEJASDASDQWEASD"
      "MNASLKDJQIOWEJASDASDQWEASD"
      "MNASLKDJQIOWEJASDASDQWEASD"
      "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),


      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height
        ),

        decoration: BoxDecoration(
//          color: Colors.grey
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme
                    .of(context)
                    .primaryColorDark,

                Colors.grey,
                Colors.grey,

//                Theme
//                    .of(context)
//                    .primaryColor
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
                              .primaryColorLight,
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
                          serviceDetails.date_scheduled,
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
                height: 50,
              ),


              // JOB DESCRIPTION
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

                          //print(get_finish_time());
//
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => FinishJob(finishService: serviceDetails,)))

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

  String get_finish_time(){

    var now = DateTime.now();
    String retVal = now.year.toString() +'-'
                  + now.month.toString() + '-'
                  + now.day.toString() +' '
                  + now.hour.toString() + ':'
                  + now.minute.toString() + ':'
                  + now.second.toString().padLeft(2,'0');

    return retVal;
  }
}
