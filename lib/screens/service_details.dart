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
  final Services myServices;

  final String test1 =
      "asdasdlkasjdlkasdasdasdasasdasdasdasdasdasdasdasdasdasdasdasdajsdklajskldjklajskldj,zmxcn,mnxm,zncALSDJKLASJDKLAJ,ZXMCN,AMSDWQIUJLKASJDZX,CMNASLDKJAKLSJZXC,MNASLKDJQIOWEJASDASDQWEASD";

  const DetailsScreen({this.myServices});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),


      body: Container(
        height: 600,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColor
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
                      //test1,
                      myServices.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColorLight,
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
                        color: Theme.of(context).primaryColorLight,
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
                      padding: const EdgeInsets.all(kLargeMargin),
                      child: Text(
                        test1,
                        //"THIS IS WHERE",
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColorDark),
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
                        color: Theme.of(context).primaryColorLight,
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
                      padding: const EdgeInsets.all(kLargeMargin),
                      child: Text(
                        test1,
                        //"THIS IS WHERE",
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                  )
                ],
              ),



              SizedBox(
                width: kSmallMargin,
                height: kSmallMargin,
              ),


              SizedBox(
                width: kSmallMargin,
                height: kSmallMargin,
              ),
              // Button logout

              Row(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kLargeMargin),
                    child: Text(
                      "Requested by: ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  )
                ],
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(kLargeMargin),
                      child: Text(
                        test1,
                        //"THIS IS WHERE",
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                  )
                ],
              ),


              Row(

                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(kLargeMargin),
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Finish",
                        style: TextStyle(color: Colors.black87),
                      ),
                      onPressed: () {
                        print("HELLO WORLD");
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
}
