

import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/models/Items.dart';

class ItemCard extends StatelessWidget {

  static final String routeName = '/items';

  final Items item;
  const ItemCard({this.item});



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: 100,

      child: Card(
        child: ListTile(
          // THIS WILL BE THE IMAGE OF THE BUILDING
          title: Text(item.item_name,
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(item.item_manufacturer),
          trailing: Text(item.item_quantity),
        ),
      ),
    );
  }


}
