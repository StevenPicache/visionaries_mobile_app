
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visionariesmobileapp/utils/alert_utils.dart';


class MoveItems extends StatefulWidget {

  static final String routeName = '/move';


  @override
  _MoveItemsState createState() => _MoveItemsState();
}

class _MoveItemsState extends State<MoveItems> {

  String barcode = "";
  String qty = "";
  final TextEditingController quantity = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Move items"
        ),
      ),

      body: Container(

        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).primaryColor
                ])),


        child: Column(

          children: [


            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text(
                    "Scan Item:  ",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.090,
                  ),


                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    iconSize: 50,
                    onPressed: (){
                      scan();
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text(
                    "Input Quantity:",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.05,
                  ),

                  //quantitySection(),

                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),


                    child: TextField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      controller: quantity,
                      // THIS LINE OF CODE IS SAVING THE INPUT DATA TO THE EMAIL STRING
                      onChanged: (value) {
                        qty = value;
                      },
                      keyboardType: TextInputType.emailAddress,

                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 25,
            ),

            moveItem(),
          ],
        ),
      ),
    );
  }



  Future scan() async{
    try{
      String barcode = await BarcodeScanner.scan();
      this.barcode = barcode;
      print(barcode);
      print(" ");

    } on PlatformException catch(e){

      if (e.code == BarcodeScanner.CameraAccessDenied){
        this.barcode = "Camera persmission not granted";
      }

      else{
        this.barcode = "Unknown error: $e";
      }
    } on FormatException{
      this.barcode = "null, User did not finish the scan and just left";
    }

    catch(e){
      this.barcode = "Unknown error: $e";
    }
  }

  ElevatedButton moveItem() {
    return ElevatedButton(
      // color: Theme.of(context).primaryColor,
      // splashColor: Theme.of(context).accentColor,
      style: ElevatedButton.styleFrom(
        primary: Colors.black
      ),
      onPressed: () {

        if (quantity.text == ""){
          print("Hello world");
          AlertUtils.getErrorAlert(context, "ERROR_INVALID_QUANTITY").show();
        }

        print(MediaQuery.of(context).size.height * 0.15,);
      },
      child: Text(
        "Move Item",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }

}
