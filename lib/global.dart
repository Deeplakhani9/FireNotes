import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Global {
  static String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  static String time = DateFormat('KK:mm a').format(DateTime.now());

  static List<Color> cardsColor = [
    Colors.purple.shade200,
  ];

  static TextStyle main = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  static TextStyle maincontent = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );
  static TextStyle ddtaTitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );
}
