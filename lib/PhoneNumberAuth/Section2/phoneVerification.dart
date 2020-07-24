import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:path/path.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quemanagement/BottomNavBar/bottomnavigation.dart';
import 'package:quemanagement/Home/homescreen.dart';
import 'package:quemanagement/PhoneNumberAuth/phoneModel.dart';

import '../serviceprovider.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  StreamController<ErrorAnimationType> errorController;
  String currentText = "";
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _verifyPhoneNumber(phoneNumber);
  }
  

    

        

 
      
  @override
  Widget build(BuildContext context) {
 





    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      appBar: AppBar(
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15.0, top: 10.0),
            alignment: Alignment.topRight,
            child: Icon(
              LineAwesomeIcons.times,
              color: Color(0xffff6565),
              size: 35.0,
            ),
          ),
        ],
        backgroundColor: Color(0xfff0f0f0),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Edit phone number",
          style: TextStyle(
              color: Colors.black, fontSize: 15.0, fontFamily: 'Lato'),
        ),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Cross Sign on top

          //Cross Sign ends
          //Enter Your Verification Number Text
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
            child: Container(
              child: Text(
                "Enter \nVerification \nCode:",
                style: TextStyle(
                    fontFamily: "Helios",
                    color: Color(0xff2a2e43),
                    fontSize: 30.0),
              ),
            ),
          ),
          //Enter Your Verification Number Text Ends
          //Verification Field start
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: PinCodeTextField(
                  autoDisposeControllers: false,
                  backgroundColor: Colors.transparent,
                  length: 6,
                  obsecureText: false,
                  animationType: AnimationType.fade,
                  shape: PinCodeFieldShape.box,
                  animationDuration: Duration(milliseconds: 300),
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  autoFocus: true,
                  textInputType: TextInputType.number,

                  // backgroundColor: Colors.blue.shade50,
                  fieldWidth: 40,

                  activeFillColor: Colors.transparent,
                  enableActiveFill: true,
                  
                  inactiveColor: Colors.black,
                  selectedFillColor: Colors.transparent,
                  activeColor: Colors.black,
                  inactiveFillColor: Colors.transparent,
                  errorAnimationController: errorController,
                selectedColor: Colors.green,
              
                onSubmitted: (v){
                       try {
                      // Navigator.pop(context);
                      AuthService().signInWithOTP(v, verificationId);
                      Navigator.pop(context);
                    } catch (e) {
                      showDialog(
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                  child: Icon(
                                LineAwesomeIcons.exclamation,
                                color: Colors.red,
                                size: 50.0,
                              )),
                              Center(
                                  child: Text(
                                "ALERT!",
                                style: TextStyle(fontFamily: 'Helios'),
                              )),
                            ],
                          ),
                          content: RichText(
                            text: TextSpan(
                              text:
                                  "Incorrect SMS Code!\nPlease enter the code sent to: ",
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).textTheme.button.color),
                              children: [
                                TextSpan(
                                  text: phoneNumber,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              elevation: 0.0,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              child: Center(
                                  child: Text(
                                "Okay!",
                                style: TextStyle(
                                    fontFamily: 'Helios',
                                    fontSize: 12.0,
                                    color: Colors.blueAccent),
                              )),
                              color: Colors.transparent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                        context: context,
                      );
                    }
                
                },
                  onCompleted: (v) {
                    print("Completed" + v);
                    try {
                      // Navigator.pop(context);
                      AuthService().signInWithOTP(v, verificationId);
                    } catch (e) {
                      showDialog(
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                  child: Icon(
                                LineAwesomeIcons.exclamation,
                                color: Colors.red,
                                size: 50.0,
                              )),
                              Center(
                                  child: Text(
                                "ALERT!",
                                style: TextStyle(fontFamily: 'Helios'),
                              )),
                            ],
                          ),
                          content: RichText(
                            text: TextSpan(
                              text:
                                  "Incorrect SMS Code!\nPlease enter the code sent to: ",
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).textTheme.button.color),
                              children: [
                                TextSpan(
                                  text: phoneNumber,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              elevation: 0.0,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              child: Center(
                                  child: Text(
                                "Okay!",
                                style: TextStyle(
                                    fontFamily: 'Helios',
                                    fontSize: 12.0,
                                    color: Colors.blueAccent),
                              )),
                              color: Colors.transparent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                        context: context,
                      );
                    }
                
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => BottomNavigation()));
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                )),
          ),
          //Verification Field End
          //Sms code has been sent
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 25.0),
              child: Text("SMS has been sent to +977" + phoneNumber,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 15.0,
                  )),
            ),
          )
          //Sms code has been sent end
        ],
      ),
    );
  }
}
