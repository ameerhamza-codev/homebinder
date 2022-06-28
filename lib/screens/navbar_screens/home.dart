import 'package:flutter/material.dart';
import 'package:homebinder/screens/add_home.dart';
import 'package:homebinder/screens/home_detail.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../provider/UserDataProvider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final provider = Provider.of<UserDataProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: Container(),
          centerTitle: true,
          title: Column(
            children: const [
              Text("HOME BINDER", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  AddHome()));
                },
                icon: Icon(Icons.add_circle))
          ]
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all( 10.0),
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context,int index){
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  Details()));
                  },
                  child: Container(
                    height: height*0.4,
                    width: width,
                    child: Column(
                      children: [
                        Expanded(
                            flex:2,
                            child:Center(
                              child: Text("Valencia, CA", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: colorWhite),),
                            ) ),
                        Expanded(
                            flex:1,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: colorBlack),
                                color: colorWhite
                              ),

                              child: Center(
                                child:Text("12 NE 88 Avenue, Santa Clara CA 98210", style: TextStyle(color: colorText, fontSize: 16), )
                              ),
                            )
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: colorBlack),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/placeholder-image.jpeg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),

      ),
    );
  }
}
