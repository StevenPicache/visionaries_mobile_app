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

    _downloadDogInfo();

  }

  _downloadDogInfo() async {
    http.Client client = http.Client();

    try {
      String apiUrl = jobsApiUrl; // giving the URL for the job details request

      // run a task on the background and request data from api
      http.Response response = await client.get(apiUrl);

      // decoding all the JSON data into body.
      var body = jsonDecode(response.body);

      List<Services> tempDogs = [];

      // Looping through all the returned JSON data
      // saving each file to an Array list of Dogs class.
      // When the initializing is done.

      // the datas are now saved can be accessed from anywhere

      for (var dogJson in body) {
        //print(dogJson['name']);

        String imageApiUrl =
            'https://api.thedogapi.com/v1/images/search?breed_id=${dogJson['id']}&include_breeds=false&limit=50';
        http.Response imageResponse = await client.get(imageApiUrl);
        var imageBody = jsonDecode(imageResponse.body);

        // THIS CODE IS TRYING TO DOWNLOAD ALL THE IMAGE THAT WE WEED
        List<String> images = [];
        for (var imageJson in imageBody) {
          images.add(imageJson['url']);
        }

        // initializing all the data members of class Dogs
        // to the
        tempDogs.add(Services(
          name: dogJson['name'],
          quote: dogJson['breed_group'],
          origin: dogJson['origin']
        ));
      }

      setState(() {
        myServices = tempDogs;
      });

    } finally {
      client.close();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Today Services")),

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
                colors: [Theme.of(context).primaryColorDark, Theme.of(context).primaryColor]
            ),
          ),

          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[


                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kLargeMargin),
                      child: Text(
                        "Services for today",
                        style: TextStyle(fontSize: 30.0, color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: kLargeMargin,
                  ),



                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSmallMargin),
                    child: Flexible(
                      child: Hero(
                        tag: 'logo',
                        child: Image(
                          height: 175,
                          image: AssetImage('images/logo.png'),
                        ),
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
}
