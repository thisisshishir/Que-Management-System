import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:quemanagement/Home/homescreen.dart';
import 'package:quemanagement/Tickets/tickets.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  final _widgetOptions = [
   Homescreen(),
 
    Tickets(),
   
    // Homescreen(),
];
void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:_widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
 
          icon: Icon(LineAwesomeIcons.home),
          title: Text('Home',style: TextStyle(fontFamily: 'Lato'),),
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(LineAwesomeIcons.list),
        //   title: Text('Directory',style: TextStyle(fontFamily: 'Lato'),),
        // ),
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.ticket,),
          title: Text('Tickets',style: TextStyle(fontFamily: 'Lato'),),
        ),
       
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xff9d9ea5),
      // selectedFontSize: 20.0,
      selectedIconTheme:IconThemeData(color: Colors.white),
      backgroundColor: Color(0xff323542),
      onTap: _onItemTapped,
    ),
      ),
    );
  }
}