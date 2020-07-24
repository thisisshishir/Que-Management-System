import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quemanagement/PhoneNumberAuth/serviceprovider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigationPage() {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthService().handelAuth()));
}
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }
  @override
void initState() {
  super.initState();
  startTime();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset('assets/images/splashimage.png',height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            ),
            
          ),
          Align(
            alignment: Alignment.bottomCenter,
              child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Powered By:",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Image.asset("assets/images/prabidhilogo.png",
                            height: 80.0,
                            width: 80.0,
                            )
                          ],
                        ),
          )
        ],
      ),
    );
  }
}