
import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/models/services.dart';
import 'package:visionariesmobileapp/screens/service_details.dart';

class ServicesCard extends StatelessWidget {
  static final String routeName = '/services';

  final Services service;
  const ServicesCard({this.service});



  /*
  *   This file is the every card on the listView
  * */

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailsScreen(myServices: service,))),

      child: Container(
        height: 75,
        width: 50,


        child: Card(
          child: ListTile(
            // THIS WILL BE THE IMAGE OF THE BUILDING
            leading: Icon(Icons.home, size: 50,),
            title: Text(service.name),
            subtitle: Text("Heelloo"),
            trailing: Icon(Icons.timer, size: 30,),

          ),


        ),
      ),

    );
  }
}
