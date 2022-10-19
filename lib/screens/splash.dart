import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../navigator/bottom_navbar.dart';
import '../provider/UserDataProvider.dart';
import '../utils/shared_pref.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3 ;


  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    return Timer(duration, navigationPage);
  }

  void navigationPage() async{
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const Login()));
   /* SharedPrefHelper helper=new SharedPrefHelper();
    String userData=await helper.getPrefUserData();
    if(userData=="no user"){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const Login()));
    }
    else{
      UserModel model=UserModel.fromJson(jsonDecode(userData));
      print("user model ${model.authenticationToken}");
      final provider = Provider.of<UserDataProvider>(context, listen: false);
      provider.setUserData(model);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) =>  BottomNavBar()));
    }*/
    
  }

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        child:Image.asset('assets/images/splash.png',height: height,width: width,fit: BoxFit.cover,),

      ),
    );
  }
}

