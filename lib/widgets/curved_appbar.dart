import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CurvedAppbar extends StatelessWidget {
  final String title,subtitle;
  final VoidCallback onTap;
  final bool isAdd;


  CurvedAppbar({required this.title,required this.subtitle,required this.onTap,required this.isAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Center(child: Text("Back",style: TextStyle(color: colorWhite,fontSize: 14, fontWeight: FontWeight.w500),)),
                )
            ),
            Column(
              children: [
                Text(subtitle, style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
                Text(title, style: TextStyle(color: colorWhite, fontSize: 12,),),
              ],
            ),
            isAdd?InkWell(
              onTap: onTap,
                child: const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Center(child: Text("Add",style: TextStyle(color: colorWhite,fontSize: 16, fontWeight: FontWeight.w500),)),
                )
            ):
            InkWell(
                onTap: onTap,
                child: const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Center(child: Text("Add",style: TextStyle(color: Colors.transparent,fontSize: 16, fontWeight: FontWeight.w500),)),
                )
            ),
          ],
        ),
      ),
    );
  }
}
