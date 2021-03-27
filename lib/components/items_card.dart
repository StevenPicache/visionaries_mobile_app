

import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/models/Items.dart';

class ItemCard extends StatelessWidget {

  static final String routeName = '/services';

  final Items item;
  const ItemCard({this.item});



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,

      child: Card(
        child: ListTile(
          // THIS WILL BE THE IMAGE OF THE BUILDING
          title: Text(item.item_name,
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(item.item_location),
          trailing: Text(item.item_quantity),
        ),
      ),
    );
  }
}
