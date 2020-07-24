import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:quemanagement/PhoneNumberAuth/Section1/phoneinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'AvailableTickets/DbTicketmodel.dart';
import 'SplashScreen/splashscreen.dart';

void main() async {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: new SplashScreen(),

    );
  }
}
