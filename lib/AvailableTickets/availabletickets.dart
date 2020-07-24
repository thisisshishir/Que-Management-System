import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:quemanagement/AvailableTickets/DbTicketmodel.dart';
import 'package:quemanagement/AvailableTickets/TicketsModel.dart';
import 'package:quemanagement/AvailableTickets/availableticketcard.dart';
import 'package:quemanagement/Home/companymodel.dart';
import 'package:sqflite/sqflite.dart';

import 'newticketmodel.dart';



class AvailableTickets extends StatefulWidget {
  final CompanyModel companyModel;
  AvailableTickets({this.companyModel});
  @override
  _AvailableTicketsState createState() => _AvailableTicketsState();
}

class _AvailableTicketsState extends State<AvailableTickets> {

FirebaseService firebaseService = FirebaseService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    // branches = widget.companyModel.branch;
    print("this"+branches);


  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Available Tickets",
          style: TextStyle(
            fontFamily: 'Helios',
            color: Color(0xff2a2e43),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(5.0),
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
      )),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshots) {
    return ListView.builder(
      itemCount: snapshots.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, int index) {
        return AvailableTicketCard(
          // forum: Forum.fromSnapshot(snapshots[index]),
          // companyModel: CompanyModel.fromSnapshot(snapshots[index]),
          ticketModel: TicketModel.fromSnapshot(snapshots[index],),
          userid:snapshots[index].documentID
        );
      },
    );
  }
}

class FirebaseService {
  StreamController<QuerySnapshot> listController =
      StreamController<QuerySnapshot>();

  Stream<QuerySnapshot> get listStream => listController.stream;
  StreamSink<QuerySnapshot> get listSink => listController.sink;

  Stream<QuerySnapshot> getList() {

    return Firestore.instance.collection("AvailableTimes").where("availability",isEqualTo: true).where("branch",isEqualTo:branches).snapshots();
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
