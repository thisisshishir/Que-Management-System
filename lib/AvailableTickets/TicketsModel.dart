import 'package:cloud_firestore/cloud_firestore.dart';


class TicketModel {
  final String location;
  final String branch;
  final String time;
  final bool availability;
  TicketModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data);
  TicketModel.fromMap(Map<dynamic, dynamic> map)
      : location = map['location'],
        branch = map['branch'],
        time = map['time'],
        availability = map['availability'];
  TicketModel(
      {this.location, this.branch, this.time, this.availability});
}
