

import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/models/Items.dart';
import 'package:visionariesmobileapp/models/JobEquipment.dart';

class JobEquipmentCard extends StatelessWidget {

  static final String routeName = '/items';

  final JobEquipment jobEquipment;
  const JobEquipmentCard({this.jobEquipment});



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: 100,


      child: Card(
        child: ListTile(
          // activeColor: Colors.pink[300],
          // dense: true,
          title: Text(
            jobEquipment.job_equipment_name,
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          trailing: Text(jobEquipment.job_equipment_id, style: TextStyle(fontSize: 20),),
        ),
      ),
    );
  }
}
