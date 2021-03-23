



import 'package:flutter/material.dart';
import 'package:visionariesmobileapp/constants.dart';
import 'package:visionariesmobileapp/models/services.dart';


class FinishJob extends StatelessWidget {


  static final String routeName = '/finish';


  final Services finishService;
  const FinishJob({this.finishService});


  @override

  Widget build(BuildContext context) {
    String work_done = '';
    String equipment_used = '';

    final TextEditingController workDone = new TextEditingController();
    final TextEditingController equipmentUsed = new TextEditingController();


    return Scaffold(

      appBar: AppBar(title: Text(finishService.work_name)),

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
                      finishService.work_name,
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
                      "Site Technician:",
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
                  finishService.site_technician,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Theme
                        .of(context)
                        .primaryColorLight,
                  ),
                ),
              ),


              SizedBox(
                width: kSmallMargin,
                height: 50,
              ),



            ],
          ),
        ),

              // JOB DESCRIPTION
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kLargeMargin),
                    child: Text(
                      "Work Done: ",
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

                          child: TextField(
                            controller: workDone,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) {
                              work_done = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Works performed',
                            ),

                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: kSmallMargin,
              ),


              // JOB DESCRIPTION
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kLargeMargin),
                    child: Text(
                      "Equipments Used: ",
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

                          child: TextField(
                            controller: equipmentUsed,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) {
                              equipment_used = value;
                            },
                            decoration: InputDecoration(
                                hintText: 'Equipment used'
                            ),

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
                    child: RaisedButton(
                      color: Colors.black,
                      child: Text(
                        "Finish Task",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {

                        // SEND REPORT
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
