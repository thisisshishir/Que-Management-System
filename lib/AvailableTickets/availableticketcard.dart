import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:path/path.dart';
import 'package:quemanagement/AvailableTickets/DbTicketmodel.dart';
import 'package:quemanagement/AvailableTickets/TicketsModel.dart';
import 'package:quemanagement/AvailableTickets/availabletickets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';

class AvailableTicketCard extends StatefulWidget {
  final String userid;
  final TicketModel ticketModel;
  AvailableTicketCard({this.ticketModel, this.userid});

  @override
  _AvailableTicketCardState createState() => _AvailableTicketCardState();
}

class _AvailableTicketCardState extends State<AvailableTicketCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  BuildContext exa;
  _insertDataToDatabase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('location') != null) {
      showDialog(
          context: exa,
          builder: (_) => AssetGiffyDialog(
                buttonCancelColor: Colors.lightGreen,
                buttonCancelText: Text(
                  "Okay!",
                  style: TextStyle(color: Colors.white),
                ),
                onlyCancelButton: true,
                image: Image.asset("assets/images/sorry.gif"),
                title: Text(
                  'Sorry!',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                description: Text(
                  'Dear User,You can only get\nOne token per day!',
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
              ));
    } else {
      Firestore.instance
          .collection("AvailableTimes")
          .document(widget.userid)
          .setData({
        'branch': widget.ticketModel.branch,
        'location': widget.ticketModel.location,
        'time': widget.ticketModel.time,
        'availability': false
      });

      showDialog(
          context: exa,
          builder: (_) => AssetGiffyDialog(
                buttonCancelColor: Colors.lightGreen,
                buttonCancelText: Text(
                  "Okay!",
                  style: TextStyle(color: Colors.white),
                ),
                onlyCancelButton: true,
                image: Image.asset("assets/images/men_wearing_jacket.gif"),
                title: Text(
                  'Congratulations!',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                description: Text(
                  'Successfully received a token!\nLets go Safe!',
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
              ));
      var date = DateTime.now().add(Duration(minutes: 10));

      prefs.setString('location', widget.ticketModel.location);
      prefs.setString('branch', widget.ticketModel.branch);
      prefs.setString('time', widget.ticketModel.time);
      prefs.setString('expirytime', date.toString());
      setState(() {
        print(prefs.getString('location'));

        print("Done");
      });
    }
    print(widget.userid);
  }

  @override
  Widget build(BuildContext context) {
    exa = context;
    return GestureDetector(
      onTap: _insertDataToDatabase,
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: FlutterTicketWidget(
          width: 350.0,
          height: 155.0,
          isCornerRounded: false,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(width: 1.0, color: Colors.green),
                      ),
                      child: Center(
                        child: Text(
                          widget.ticketModel.location,
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.add_location,
                            color: Colors.pink,
                          ),
                        ),
                        Text(
                          widget.ticketModel.branch,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Que Ticket',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Time:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'Lato'),
                            ),
                            Text(
                              widget.ticketModel.time,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'LatoLight'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
