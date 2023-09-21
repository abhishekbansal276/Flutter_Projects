import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;

class Utils {
  static void toastMessage(String message) {
    toast.Fluttertoast.showToast(
      msg: message,
      toastLength: toast.Toast.LENGTH_SHORT,
      gravity: toast.ToastGravity.BOTTOM,
      backgroundColor: Color(0xff11998e),
      textColor: Colors.white,
      fontSize: 16.0,
      timeInSecForIosWeb: 1,
    );
  }
}