import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void showSuccessSnackbar(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.sp);
}

void showErrorSnackbar(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.sp);
}

String generateStructuredReferralCode() {
  const String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String numbers = '0123456789';
  Random random = Random();

  String part1 =
      List.generate(3, (index) => letters[random.nextInt(letters.length)])
          .join();
  String part2 =
      List.generate(3, (index) => numbers[random.nextInt(numbers.length)])
          .join();
  String part3 =
      List.generate(3, (index) => letters[random.nextInt(letters.length)])
          .join();

  return '$part1-$part2-$part3';
}
