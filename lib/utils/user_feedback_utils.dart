
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
        desc = 'Please specify quantity';
        break;

      case "ITEM_MOVE_SUCCESS":
        title = 'Success!';
        desc = 'Item was moved successfully';
        break;

      case "ERROR_INVALID_BARCODE_CHECK_INVENTORY":
        title = 'Invalid';
        desc = 'Item barcode was empty';
        break;


      default:
        title = errorCode;
        break;
    }


    return Alert(context: context, title: title, desc: desc);

  }
}