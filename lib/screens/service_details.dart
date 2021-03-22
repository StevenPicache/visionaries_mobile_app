/*
*   THIS WILL THE SCREEN WILL GO HERE IF THE USER TRIES
*   TAPPED ON ONE OF THE LISTVIEW CARDS
*
* */

import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/models/services.dart';

class DetailsScreen extends StatelessWidget {
  @override
  // a references to the services object that contains all the information of the card
  final Services myServices;


  final String test1 =
      "asDKJAKLSJZXC,MNASLKDJQIOWEJASDASDQWEASDMNASLKDJQIOWEJASDASDQWEASD"
      "MNASLKDJQIOWEJASDASDQWEASD"
      "MNASLKDJQIOWEJASDASDQWEASD"
      "MNASLKDJQIOWEJASDASDQWEASD"
      "MNASLKDJQIOWEJASDASDQWEASD"
      "";

  const DetailsScreen({this.myServices});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),


      body: Container(
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
                      myServices.work_name,
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
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kLargeMargin),
                    child: Text(
                      "Job Description: ",
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


              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),

                      child: Container(

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white60,
                          ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(40))

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            //"THIS IS WHERE JOB DESCRIPTION FROM API WILL BE STORED",
                            myServices.job_description,
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

              Row(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kLargeMargin),
                    child: Text(
                      "Site Address: ",
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


              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),

                      child: Container(

                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white60,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(40))

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            //"THIS IS WHERE JOB DESCRIPTION FROM API WILL BE STORED",
                            myServices.site_address,
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

              Row(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kLargeMargin),
                    child: Text(
                      "Site Contact:",
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


              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),

                      child: Container(

                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white60,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(40))

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            myServices.site_technician,
                            //"THIS IS WHERE SITE DESCRIPTION FROM API WILL BE STORED",
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


              Row(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kLargeMargin),
                    child: Text(
                      "Date Requested:",
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


              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),

                      child: Container(

                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white60,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(40))

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            myServices.date_requested,
                            //"THIS IS WHERE SITE DESCRIPTION FROM API WILL BE STORED",
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
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kLargeMargin),
                    child: Text(
                      "Scheduled For:",
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


              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),

                      child: Container(

                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white60,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(40))

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            myServices.date_scheduled,
                            //"THIS IS WHERE SITE DESCRIPTION FROM API WILL BE STORED",
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
              // Button logout

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(kLargeMargin),
                    child: FlatButton(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      child: Text(
                        "Finish",
                        style: TextStyle(color: Colors.black87),
                      ),
                      onPressed: () {

                          print(get_finish_time());

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
