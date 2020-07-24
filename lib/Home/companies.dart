import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quemanagement/CompanyDetails/companydetails.dart';
import 'package:quemanagement/Home/companymodel.dart';

class CompanyCard extends StatelessWidget {
  final CompanyModel companyModel;
  final BuildContext exContext;
  CompanyCard({this.companyModel,this.exContext});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>CompanyDetails(companyModel: companyModel,)));
      },
          child: Container(
       
        height: 150.0,
        width: 120.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                
                  child: Center(
                child: CachedNetworkImage(
                  height: 80.0,
                  width: 80.0,
                  imageUrl: companyModel.icon,
                ),
              )),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Container(
                 
                  child: Text(
                    companyModel.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: 'Helios'),
                  )),
            ),
            Center(
              child: Container(
                  // margin: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Branch:",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: 'LatoLight'),
                  )),
            ),
            Center(
              child: Container(
                 
                  child: Text(
                    companyModel.branch,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: companyModel.status ?Colors.green:Colors.red, fontFamily: 'Lato'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
