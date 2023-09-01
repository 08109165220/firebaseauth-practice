import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Message{

  static showMessage({required String message,bool isError=false,}){
    Get.showSnackbar(GetSnackBar(
        message: message,
        duration: Duration(seconds: 4),
        isDismissible: true,backgroundColor: isError!?Colors.red:Colors.green,
        ));
    }
}