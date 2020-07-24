import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quemanagement/BottomNavBar/bottomnavigation.dart';
import 'package:quemanagement/Home/homescreen.dart';
import 'package:quemanagement/PhoneNumberAuth/Section1/phoneinput.dart';
import 'package:quemanagement/PhoneNumberAuth/Section2/phoneVerification.dart';


class AuthService {

  handelAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
            print("AuthService");
            
          return BottomNavigation();
        } else {
            print("AuthService2");
            return PhoneInput();
         
          // return PhoneInput();
        }
      },
    );
  }

  signIn(AuthCredential authCreds) {
    print("reach1");
    FirebaseAuth.instance.signInWithCredential(authCreds);
    print("reached");
    AuthService().handelAuth();
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signInWithOTP(smsCode, verId) {
    print("signinwithotp");
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
print("signinwithotp2");
    signIn(authCreds);
    print("signinwithotp3");
  }
}
