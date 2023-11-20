import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_api/home_screen.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    theme: ThemeData(
      primaryColor: Colors.white,
      hintColor:Colors.white
    ),
  ));
}


  

