import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:quemanagement/PhoneNumberAuth/Section2/phoneVerification.dart';

import '../phoneModel.dart';
import '../serviceprovider.dart';

class PhoneInput extends StatefulWidget {
  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  final _formKey = GlobalKey<FormState>();

  BoxDecoration numberInputField = BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Color(0xffcfcfcf),
            blurRadius: 40.0,
            spreadRadius: 5.0,
            offset: Offset(5.0, 5.0)),
      ],
      borderRadius: BorderRadius.all(Radius.circular(10.0)));

  @override
  Widget build(BuildContext context) {
        final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
          showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Unknown Error Encountered!\n Enter a valid contact number"),
              actions: <Widget>[
                RaisedButton(onPressed: ()=>Navigator.pop(context),
                child: Text("Try Again!"),
                )
              ],
            );
          }
          );
          print('${authException.message}');
        };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      verificationId = verId;
      setState(() {
        codeSent = true;
      });
      print(codeSent);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneVerification()));
      //showSmsDialog(context);
 
    };
final PhoneCodeAutoRetrievalTimeout autoTimeOut =(String verId){
verificationId = verId;
};

    Future<void> _verifyPhoneNumber(phoneNo) async {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNo,
          timeout: Duration(seconds: 110),
          verificationCompleted: verified,
          verificationFailed: verificationFailed,
          codeSent: smsSent,
          codeAutoRetrievalTimeout: autoTimeOut);
    }

    return Scaffold(
        backgroundColor: Color(0xfff0f0f0),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Cross Sign on top
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(right: 15.0, top: 10.0),
                    alignment: Alignment.topRight,
                    child: Icon(
                      LineAwesomeIcons.times,
                      color: Color(0xffff6565),
                      size: 35.0,
                    ),
                  ),
                ),
                //Cross Sign ends
                //Enter Your Mobile Number Text
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 60.0, 0.0, 0.0),
                  child: Container(
                    child: Text(
                      "Enter your \nmobile \nnumber:",
                      style: TextStyle(
                          fontFamily: "Helios",
                          color: Color(0xff2a2e43),
                          fontSize: 30.0),
                    ),
                  ),
                ),
                //Enter Your Mobile Number Text Ends
                //TextFormField Start
                Center(
                  child: Container(
                    decoration: numberInputField,
                    margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
                    child: ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/nepal.png',
                            height: 25.0,
                            width: 25.0,
                          ),
                          Text(
                            "  +977",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      title: TextFormField(
                        onChanged: (e) {
                          setState(() {
                            actPhone = e;
                            phoneNumber = "+977" + e;
                          });
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        autofocus: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintText: "Your mobile number"),
                      ),
                    ),
                  ),
                ),

                //TextFormField End

                //Button Start
                GestureDetector(
                  onTap: () {
                    print(phoneNumber);

                    if (actPhone == "" || int.parse(actPhone) < 10) {
                      setState(() {
                        numberInputField = BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffcfcfcf),
                                  blurRadius: 40.0,
                                  spreadRadius: 5.0,
                                  offset: Offset(5.0, 5.0)),
                            ],
                            border: Border.all(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)));
                      });
                    } else {
                      _verifyPhoneNumber(phoneNumber);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    margin: EdgeInsets.fromLTRB(20, 40.0, 20.0, 0.0),
                    decoration: BoxDecoration(
                        // color: Color(0xff3776c5),
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    child: Center(
                      child: Text(
                        "NEXT STEP",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontFamily: 'Helios'),
                      ),
                    ),
                  ),
                ),

                //Button End

                //Terms & Conditions start
                Container(
                  margin: EdgeInsets.fromLTRB(30, 30, 30, 20),
                  child: Center(
                    child: Text(
                      "By signing up, you are agreeing to the Terms of service and Privacy Policy",
                      style: TextStyle(
                          fontFamily: 'Helios',
                          color: Color(0xff2a2e43),
                          fontSize: 12.0),
                    ),
                  ),
                )
                //Terms & Conditions End
              ],
            ),
          ),
        ));
  }
}
