
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FeedbackUtils{
  static Alert showFeedbackAlert(BuildContext context, String errorCode) {
    String title;
    String desc;


    switch (errorCode) {
      case "ERROR_INVALID_QUANTITY":
        title = 'Invalid';
        desc = 'Please specify quantity';
        break;

      case "ERROR_INVALID_BOTH_TO_WAREHOUSE":
        title = 'Invalid';
        desc = 'Please specify item code and quantity';
        break;

      case "ERROR_INVALID_BARCODE_CHECK_INVENTORY":
        title = 'Invalid';
        desc = 'Item barcode was empty or not found';
        break;  

      case "ERROR_TASK_REPORT_FAILED":
        title = 'Error occured';
        desc = 'Something went wrong on the sending of the report';
        break;
        
        
      case "NOT_ENOUGH_QUANTITY_WAREHOUSE_TO_TRUCK":
        title = 'Not enough items ';
        desc = 'There are not enough items in the truck';
        break;

      case "NOT_ENOUGH_QUANTITY_TRUCK_TO_WAREHOUSE":
        title = 'Not enough items';
        desc = 'There are not enough items in the warehouse';
        break;


      case "ERROR_CODE_258":
        title = 'Error!';
        desc = 'Internal Server Error, Try logging out and logging back';
        break;

      case "NOT FOUND":
        title = 'Code not found';
        desc = 'The item code for this item was not found in the database';
        break;




      case "TASK_REPORT_SUCCESS":
        title = 'Success!';
        desc = 'The sending of the task was successful!';
        break;

      case "ITEM_MOVE_SUCCESS":
        title = 'Success!';
        desc = 'Item was moved successfully';
        break;

      default:
        title = errorCode;
        break;
    }


    return Alert(context: context, title: title, desc: desc);

  }
}