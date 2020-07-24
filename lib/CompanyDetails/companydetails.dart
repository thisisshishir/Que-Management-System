import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:quemanagement/AvailableTickets/availabletickets.dart';
import 'package:quemanagement/AvailableTickets/newticketmodel.dart';
import 'package:quemanagement/Home/companymodel.dart';
import 'package:quemanagement/Tickets/tickets.dart';

class CompanyDetails extends StatefulWidget {
  final CompanyModel companyModel;
  CompanyDetails({this.companyModel});
  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  String xyz = "shi";
  TextStyle closedTextStyle =
      TextStyle(fontFamily: 'Helios', color: Colors.red);
  TextStyle openTextStyle =
      TextStyle(fontFamily: 'LatoLight', color: Colors.black);
  ScrollController _scrollController = ScrollController();
  Color appBarBackground;
  double topPosition;
  @override
  void initState() {
    topPosition = -80;
    appBarBackground = Colors.transparent;
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  double _getOpacity() {
    double op = (topPosition + 80) / 80;
    return op > 1 || op < 0 ? 1 : op;
  }

  _onScroll() {
    if (_scrollController.offset > 50) {
      if (topPosition < 0)
        setState(() {
          topPosition = -130 + _scrollController.offset;
          if (_scrollController.offset > 130) topPosition = 0;
        });
    } else {
      if (topPosition > -80)
        setState(() {
          topPosition--;
          if (_scrollController.offset <= 0) topPosition = -80;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: CachedNetworkImage(
                    imageUrl: widget.companyModel.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    //Company Detail Section
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(top: 15.0),
                                    child: Text(
                                      widget.companyModel.name,
                                      style: TextStyle(
                                          // fontFamily: 'Zelda',
                                          fontFamily: 'Helios',
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      widget.companyModel.branch,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'LatoLight',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: widget.companyModel.icon,
                                height: 80.0,
                                width: 100.0,
                              ),
                              widget.companyModel.status?
                              Text(
                                "Open",
                                style: TextStyle(
                                    fontFamily: 'Lato', color: Colors.green),
                              ):  Text(
                                "Closed",
                                style: TextStyle(
                                    fontFamily: 'Lato', color: Colors.red),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Divider(
                          thickness: 1.5,
                        )),

                    //Company Detail Section end
                    //Working hours start
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(top: 15.0),
                                    child: Text(
                                      "Working Hours",
                                      style: TextStyle(
                                          // fontFamily: 'Zelda',
                                          fontFamily: 'Helios',
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: 320.0,
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Theme(
                                    data: theme,
                                    child: ExpansionTile(
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            widget.companyModel.workinghours[0],
                                            style: widget.companyModel
                                                            .workinghours[0] ==
                                                        "Closed" ||
                                                    widget.companyModel
                                                            .workinghours[0] ==
                                                        'closed'
                                                ? closedTextStyle
                                                : openTextStyle,
                                          ),
                                          Icon(Icons.keyboard_arrow_down)
                                        ],
                                      ),
                                      title: Text(
                                        "Sunday",
                                        style: TextStyle(fontFamily: 'Lato'),
                                      ),
                                      children: <Widget>[
                                        ListTile(
                                          trailing: Container(
                                              margin:
                                                  EdgeInsets.only(right: 22.0),
                                              child: Text(
                                                widget.companyModel
                                                    .workinghours[1],
                                                style: widget.companyModel
                                                                    .workinghours[
                                                                1] ==
                                                            "Closed" ||
                                                        widget.companyModel
                                                                    .workinghours[
                                                                1] ==
                                                            'closed'
                                                    ? closedTextStyle
                                                    : openTextStyle,
                                              )),
                                          title: Text(
                                            "Monday",
                                            style:
                                                TextStyle(fontFamily: 'Lato'),
                                          ),
                                        ),
                                        ListTile(
                                          trailing: Container(
                                              margin:
                                                  EdgeInsets.only(right: 22.0),
                                              child: Text(
                                                widget.companyModel
                                                    .workinghours[2],
                                                style: widget.companyModel
                                                                    .workinghours[
                                                                2] ==
                                                            "Closed" ||
                                                        widget.companyModel
                                                                    .workinghours[
                                                                2] ==
                                                            'closed'
                                                    ? closedTextStyle
                                                    : openTextStyle,
                                              )),
                                          title: Text(
                                            "Tuesday",
                                            style:
                                                TextStyle(fontFamily: 'Lato'),
                                          ),
                                        ),
                                        ListTile(
                                          trailing: Container(
                                              margin:
                                                  EdgeInsets.only(right: 22.0),
                                              child: Text(
                                                widget.companyModel
                                                    .workinghours[3],
                                                style: widget.companyModel
                                                                    .workinghours[
                                                                3] ==
                                                            "Closed" ||
                                                        widget.companyModel
                                                                    .workinghours[
                                                                3] ==
                                                            'closed'
                                                    ? closedTextStyle
                                                    : openTextStyle,
                                              )),
                                          title: Text(
                                            "Wednesday",
                                            style:
                                                TextStyle(fontFamily: 'Lato'),
                                          ),
                                        ),
                                        ListTile(
                                          trailing: Container(
                                              margin:
                                                  EdgeInsets.only(right: 22.0),
                                              child: Text(
                                                widget.companyModel
                                                    .workinghours[4],
                                                style: widget.companyModel
                                                                    .workinghours[
                                                                4] ==
                                                            "Closed" ||
                                                        widget.companyModel
                                                                    .workinghours[
                                                                4] ==
                                                            'closed'
                                                    ? closedTextStyle
                                                    : openTextStyle,
                                              )),
                                          title: Text(
                                            "Thursday",
                                            style:
                                                TextStyle(fontFamily: 'Lato'),
                                          ),
                                        ),
                                        ListTile(
                                          trailing: Container(
                                              margin:
                                                  EdgeInsets.only(right: 22.0),
                                              child: Text(
                                                widget.companyModel
                                                    .workinghours[5],
                                                style: widget.companyModel
                                                                    .workinghours[
                                                                5] ==
                                                            "Closed" ||
                                                        widget.companyModel
                                                                    .workinghours[
                                                                5] ==
                                                            'closed'
                                                    ? closedTextStyle
                                                    : openTextStyle,
                                              )),
                                          title: Text(
                                            "Friday",
                                            style:
                                                TextStyle(fontFamily: 'Lato'),
                                          ),
                                        ),
                                        ListTile(
                                          trailing: Container(
                                              margin:
                                                  EdgeInsets.only(right: 22.0),
                                              child: Text(
                                                widget.companyModel
                                                    .workinghours[6],
                                                style: widget.companyModel
                                                                    .workinghours[
                                                                6] ==
                                                            "Closed" ||
                                                        widget.companyModel
                                                                    .workinghours[
                                                                6] ==
                                                            'closed'
                                                    ? closedTextStyle
                                                    : openTextStyle,
                                              )),
                                          title: Text(
                                            "Satuday",
                                            style:
                                                TextStyle(fontFamily: 'Lato'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Working hours end
                    Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Divider(
                          thickness: 1.5,
                        )),
                    // SizedBox(height: 30.0,),
                    //Share feature
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Center(
                                    child: Icon(
                                  Icons.share,
                                  size: 30.0,
                                )),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                    child: Text(
                                  "Share",
                                  style: TextStyle(
                                      fontFamily: 'LatoLight', fontSize: 20.0),
                                ))
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Center(
                                    child: Icon(
                                  Icons.add_location,
                                  size: 30.0,
                                )),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                    child: Text(
                                  "Locate",
                                  style: TextStyle(
                                      fontFamily: 'LatoLight', fontSize: 20.0),
                                ))
                              ],
                            )
                          ],
                        )),
                    //Share Feature end
                    Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Divider(
                          thickness: 1.5,
                        )),
                    SizedBox(
                      height: 80.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            padding:
                const EdgeInsets.only(left: 50, top: 25.0, right: 20.0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(30.0)),
              color: Colors.white.withOpacity(_getOpacity()),
            ),
            child: DefaultTextStyle(
              style: TextStyle(),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              child: Semantics(
                child: Text(
                  widget.companyModel.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                header: true,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  branches = widget.companyModel.branch;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AvailableTickets(companyModel:widget.companyModel))); 
                },
                child: Container(
                  color: Colors.red,
                  child: ListTile(
                    leading: Icon(
                      LineAwesomeIcons.gift,
                      color: Colors.white,
                      size: 50.0,
                    ),
                    title: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Grab A Token Now!",
                        style: TextStyle(
                            fontFamily: 'Helios',
                            color: Colors.white,
                            letterSpacing: 1.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
