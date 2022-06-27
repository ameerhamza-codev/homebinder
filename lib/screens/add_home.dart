import 'package:flutter/material.dart';
import 'package:homebinder/utils/constants.dart';

class AddHome extends StatefulWidget {
  const AddHome({Key? key}) : super(key: key);


  @override
  State<AddHome> createState() => _AddHomeState();
}

class _AddHomeState extends State<AddHome> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool checkedValue = false;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Center(child: Text("Back",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
          )
        ),
        centerTitle: true,
        title: Column(
          children: const [
            Text("New Home", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
            Text('ADD HOME', style: TextStyle(color: colorWhite, fontSize: 12,),),
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
        child: Column(
          children: [
            // Main Container of Screen
            Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50,),

                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        hintText: 'Name',
                        hintStyle: TextStyle(color: colorText),
                        fillColor: colorFill,
                        filled: true,

                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        hintText: 'Address',
                        hintStyle: TextStyle(color: colorText),
                        fillColor: colorFill,
                        filled: true,

                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        hintText: 'Category',
                        hintStyle: TextStyle(color: colorText),
                        fillColor: colorFill,
                        filled: true,
                        suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: <String>['Category A','Category B', 'Category C'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ),
                          )
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        hintText: 'Select Image',
                        hintStyle: TextStyle(color: colorText),
                        fillColor: colorFill,
                        filled: true,
                        suffixIcon: const Icon(
                            Icons.camera_alt_outlined
                          ),
                        ),
                      ),
                    const SizedBox(height: 20,),
                    Center(
                      child: InkWell(
                        onTap: (){

                        },
                        child: Container(
                          height: 40,
                          width: width*0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: secondaryColor
                          ),
                          alignment: Alignment.center,
                          child: const Text("Add Home",style: TextStyle(fontSize:16,color: colorWhite, fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),


                  ],
                ),
              ),

            ),
          ],
        ),

      ),
    );
  }
}
