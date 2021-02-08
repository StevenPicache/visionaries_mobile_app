


import 'package:flutter/material.dart';


class FindSiteLocation extends StatefulWidget {
  static final String routeName = '/find';


  @override
  _FindSiteLocationState createState() => _FindSiteLocationState();
}

class _FindSiteLocationState extends State<FindSiteLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Find Site Location") ),

      body: Container(
        child: Center(child: Text('Find Site Location'),),
      )


    );

  }
}
