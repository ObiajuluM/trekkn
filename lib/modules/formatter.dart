import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

final currencyFormat = NumberFormat.currency(symbol: '', decimalDigits: 0);
final compactCurrencyFormat =
    NumberFormat.compactCurrency(symbol: '', decimalDigits: 0);


Color colorFromName(String name, Brightness brightness) {
  Color color;
  // Convert name into a hash code
  final hash = name.hashCode;

  // Use the hash to pick a hue (0–360)
  final hue = hash % 360;

  // Create an HSL color (keeps saturation & lightness consistent)
  final hslColor = HSLColor.fromAHSL(1.0, hue.toDouble(), 0.5, 0.6);



  if (brightness == Brightness.light) {
    color = hslColor.toColor();
    
  } else {
color = hslColor.toColor().withValues(alpha: 0.5);
  }


  // Convert to a Flutter Color
  // if(){
  //   return hslColor.toColor();
  
    return  color;
  
}



String formatDate(DateTime date) {
  // Get weekday + month + day
  String weekday = DateFormat('EEEE').format(date); // Monday
  String month = DateFormat('MMMM').format(date); // October
  int day = date.day;
  int year = date.year;

  // Add ordinal suffix (st, nd, rd, th)
  String suffix;
  if (day >= 11 && day <= 13) {
    suffix = 'th';
  } else {
    switch (day % 10) {
      case 1:
        suffix = 'st';
        break;
      case 2:
        suffix = 'nd';
        break;
      case 3:
        suffix = 'rd';
        break;
      default:
        suffix = 'th';
    }
  }

  return "$weekday $day$suffix $month $year";
}
