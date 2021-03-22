
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FeedbackUtils{
  static Alert showFeedbackAlert(BuildContext context, String errorCode) {
    String title;
    String desc;


    switch (errorCode) {

      case "ERROR_INVALID_EMAIL_AND_PASSWORD":
        title = 'Your UPC code is';
        desc = errorCode;
        break;

      default:
        title = errorCode;
        break;
    }


    return Alert(context: context, title: title, desc: desc);

  }
}