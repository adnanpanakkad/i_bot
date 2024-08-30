import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:i_bot/widget/constent/colors.dart';

class CustomTextStyle {
  static const TextStyle buttonTextStyle = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w600, fontFamily: "Urbanist");
  static const TextStyle containerTextStyle = TextStyle(
      color: Colors.grey,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      fontFamily: "Urbanist");

  static const TextStyle highboldTxtStyle = TextStyle(
      fontSize: 29,
      fontWeight: FontWeight.w600,
      fontFamily: 'Urbanist',
      color: Colors.cyanAccent);

  static const TextStyle swipeTextStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      fontFamily: "Urbanist",
      color: Appcolors.primerycolor);

  static const TextStyle ultraBoldTextstyle = TextStyle(
      fontSize: 35, fontFamily: 'Urbanist', fontWeight: FontWeight.bold);

  static const TextStyle textFieldstyle = TextStyle(
      color: Color.fromARGB(255, 157, 157, 157),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: "Urbanist");
  String getDoctorDescription(String name, String specialization) {
    return "Dr. $name is a highly skilled and dedicated $specialization. With a deep commitment to patient care, utilizes the latest advancements in $specialization. Dedicated to helping patients achieve and improve their overall quality of life.";
  }
}
