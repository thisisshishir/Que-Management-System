import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:quemanagement/Home/companies.dart';
import 'package:quemanagement/Home/companymodel.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../PhoneNumberAuth/serviceprovider.dart';
class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  FirebaseService firebaseService = FirebaseService();
  _checkingSharedPref() async {
    var currenttime = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();


   
    if (prefs.getString('expirytime') != null) {
       DateTime exptime = DateTime.parse(prefs.getString('expirytime'));
      if (currenttime.isAfter(exptime)) {
        prefs.clear();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkingSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Home",
          style: TextStyle(
            fontFamily: 'Helios',
            color: Color(0xff2a2e43),
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: signOut,
                        child: Icon(LineAwesomeIcons.sign_out,color: Colors.black))
                    ],
                  ),
                  body: SingleChildScrollView(
                          child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(
                            "Welcome to PrabidhiQue",
                            style: TextStyle(
                                fontFamily: 'Helios',
                                color: Color(0xff2a2e43),
                                fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        //Invite card start
                        GestureDetector(
                          onTap: () {
                            Share.share("Check out my App https://prabidhilabs.com");
                          },
                          child: Card(
                              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                              color: Colors.redAccent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/refer.png',
                                        height: 100.0,
                                        width: 100.0,
                                      )),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                          "Invite your friends!",
                                          style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Center(
                                            child: Container(
                                                child: Text(
                                          'Encourage your friends\nto save there time by\nskipping the que!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )))
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                        //Invite Card end
                        //Sections
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.all(10.0),
                                child: Text(
                                  "Retail/Shopping",
                                  style: TextStyle(
                                      fontFamily: 'Helios',
                                      color: Color(0xff2a2e43),
                                      fontSize: 20.0),
                                )),
                            Container(
                                margin: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    // Text(
                                    //   "View All",
                                    //   style: TextStyle(
                                    //       fontFamily: 'LatoLight',
                                    //       color: Colors.red,
                                    //       fontSize: 16.0),
                                    // ),
                                    // Icon(
                                    //   LineAwesomeIcons.chevron_right,
                                    //   color: Colors.redAccent,
                                    // )
                                  ],
                                ))
                          ],
                        ),
            //Sections end
            
                        Container(
                          padding: EdgeInsets.all(5.0),
                        // height: 500.0,
                        height: MediaQuery.of(context).size.height,
                          child: FutureBuilder(
                            builder: (BuildContext context, snapshot) {
                              return StreamBuilder(
                                stream: firebaseService.listStream,
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("Error: Couldn't Connect to the Database!");
                                  }
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                      break;
                                    default:
                                      return _buildList(context, snapshot.data.documents);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  ),
                );
              }
            
              Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshots) {
                return GridView.builder(
                  itemCount: snapshots.length,
                  itemBuilder: (context, int index) {
                    return CompanyCard(
                      // forum: Forum.fromSnapshot(snapshots[index]),
                      companyModel: CompanyModel.fromSnapshot(snapshots[index]),
                      exContext: context,
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                );
              }
            
               signOut() {
                 FirebaseAuth.instance.signOut();
  }
}

class FirebaseService {
  StreamController<QuerySnapshot> listController =
      StreamController<QuerySnapshot>();

  Stream<QuerySnapshot> get listStream => listController.stream;
  StreamSink<QuerySnapshot> get listSink => listController.sink;

  Stream<QuerySnapshot> getList() {
    return Firestore.instance.collection("retails").snapshots();
  }

  FirebaseService() {
    getList().listen((value) {
      listSink.add(value);
    });
  }
  dispose() {
    listController.close();
  }
}
