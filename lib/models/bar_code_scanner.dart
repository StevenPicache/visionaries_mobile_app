



import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class BarCodeScanner
{


//  Services({this.work_name, this.site_address, this.site_technician,
//    this.site_technician_contact_number, this.date_requested, this.order_creator,
//    this.job_description, this.date_scheduled});



  BarCodeScanner();


  Future scan() async{
    String barcode = "";

    try{
      barcode = await BarcodeScanner.scan();
      barcode = barcode;
      print(barcode);
      print(" ");
    } on PlatformException catch(e){
      if (e.code == BarcodeScanner.CameraAccessDenied){
        barcode = "Camera persmission not granted";
      }

      else{
        barcode = "Unknown error: $e";
      }
    } on FormatException{

      barcode = "null, User did not finish the scan and just left";
    }

    catch(e){
      barcode = "Unknown error: $e";
    }

    return barcode;
  }
}