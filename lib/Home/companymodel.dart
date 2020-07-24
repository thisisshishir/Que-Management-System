import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel{
  final String name;
  final String branch;
  final bool status;
  final String uid;
  final String image;
  final List workinghours;
  final String icon;
    CompanyModel.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);
     CompanyModel.fromMap(Map<dynamic, dynamic> map):
          name = map['name'],
          image = map['image'],
          status = map['status'],
          uid = map['uid'],
          workinghours = map['workinghours'],
          icon = map['icon'],
        branch = map['branch'];
  CompanyModel({this.name,this.branch,this.icon,this.image,this.workinghours,this.status,this.uid});

}