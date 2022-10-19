import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomAppbar extends StatelessWidget {
  String title;

  CustomAppbar(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Center(child: Text("Back",style: TextStyle(color: colorWhite,fontSize: 14, fontWeight: FontWeight.w500),)),
              )
          ),
          Text(title, style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
          InkWell(

              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Center(child: Text("Back",style: TextStyle(color: Colors.transparent,fontSize: 16, fontWeight: FontWeight.w500),)),
              )
          ),
        ],
      ),
    );
  }
}
