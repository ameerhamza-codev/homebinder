import 'package:flutter/material.dart';
import 'package:homebinder/utils/constants.dart';

import '../login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorWhite,
      appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: Container(),
          centerTitle: true,
          title: Column(
            children: const [
              Text("Profile", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
            ],
          ),
          actions: <Widget>[
            InkWell(
              onTap: (){
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Center(child: Text("Edit",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
              ),
            ),
          ]
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: width,
                  height: height*0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
                    color: primaryColor,
                  ),
                ),
                Positioned(
                  top:(height*0.2)-100,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorWhite),
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: AssetImage("assets/images/placeholder-image.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80,),
            Center(child: Text("Victoria Robertson",style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),)),
            const SizedBox(height: 10,),
            Center(child: Text("Home Owner",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("First Name: Victoria",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  const Divider(height: 1,)
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Last Name: Robertson",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  const Divider(height: 1,)
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: Victoria.Robertson@gmail.com",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  const Divider(height: 1,)
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone: (765) 324-7629",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  const Divider(height: 10,)
                ],
              ),
            ),
            const SizedBox(height: 30,),
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  Login()));
                },
                child: Center(child: Text("Logout",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),))
            ),


          ],
        ),

      ),
    );
  }
}
