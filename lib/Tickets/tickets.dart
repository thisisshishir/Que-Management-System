import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:path/path.dart';
import 'package:quemanagement/AvailableTickets/DbTicketmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class Tickets extends StatefulWidget {
  @override
  _TicketsState createState() => _TicketsState();
}
String location ="";
String branch ="";
String time ="";
class _TicketsState extends State<Tickets> {

      _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(prefs!=null){
          location = (prefs.getString('location'));
          branch = prefs.getString('branch');
          time = prefs.getString('time');
      }
    

    });
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCounter();
  //  print(location);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color(0xfff0f0f0),
        appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Tickets",
          style: TextStyle(
            fontFamily: 'Helios',
            color: Color(0xff2a2e43),
          ),
        ),
      ),
      body:location == null? Container(
        color: Colors.white,
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: Image.asset('assets/images/notickets.png'),),
            Center(child:Text(
            "No Active Tickets!",
            style: TextStyle(
              fontFamily: 'Helios',
              color: Color(0xff2a2e43),
            ),
          ),)
          ],
        ),
      ):Center(

        child: Container(
             margin: EdgeInsets.all(10.0),
          child: FlutterTicketWidget(
              width: 350.0,
              height: 250.0,
              isCornerRounded: false,
              child: Center(
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
                                location,
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
                                branch,
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
                              SizedBox(height: 50.0,),
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
                                    time,
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
        ),
      ),
    );
  }
}