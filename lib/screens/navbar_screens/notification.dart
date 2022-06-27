import 'package:flutter/material.dart';
import 'package:homebinder/utils/constants.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);


  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorWhite,
      appBar: AppBar(
          backgroundColor: primaryColor,
          leading: Container(),
          centerTitle: true,
          title: Column(
            children: const [
              Text("Notifications", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
              Text('VIEW NOTIFICATIONS', style: TextStyle(color: colorWhite, fontSize: 12,),),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          actions: <Widget>[
          ]
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context,int index){
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                        flex:1,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage("assets/icons/placeholder-icon.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                    ),
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                 Text("Title", style: TextStyle(color:colorBlack, fontSize: 16, fontWeight: FontWeight.bold),),
                                 Text("Time", style: TextStyle(color:colorText, fontSize: 12, fontWeight: FontWeight.w400),)
                              ],
                            ),
                            SizedBox(height: 3,),
                            const Text("Notification description...........", style: TextStyle(color: colorBlack, fontSize: 14),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
        ),

      ),
    );
  }
}
