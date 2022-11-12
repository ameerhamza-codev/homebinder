import 'package:flutter/material.dart';
import 'package:homebinder/screens/navbar_screens/notification.dart';
import 'package:homebinder/utils/constants.dart';

import '../screens/navbar_screens/home.dart';
import '../screens/navbar_screens/profile.dart';

class BottomNavBar extends StatefulWidget {

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavBar>{

  int _currentIndex = 0;

  List<Widget> _children=[];

  @override
  void initState() {
    super.initState();
    _children = [
      Home(),
      NotificationList(),
      Profile()
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: AppBar().preferredSize.height,
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(top:2,bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  onTabTapped(0);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/icons/home.png",height: 20,color: _currentIndex==0?colorWhite:colorBlack),
                    Text("Home", style: TextStyle(color: _currentIndex==0?colorWhite:colorBlack),)

                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  onTabTapped(1);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/icons/notification.png",height: 20,color: _currentIndex==1?colorWhite:colorBlack),
                    Text("Notifications", style: TextStyle(color: _currentIndex==1?colorWhite:colorBlack),)

                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  onTabTapped(2);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/icons/profile.png",height: 20,color: _currentIndex==2?colorWhite:colorBlack),
                    Text("Profile", style: TextStyle(color: _currentIndex==2?colorWhite:colorBlack),)

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: _children[_currentIndex],
    );
  }
}