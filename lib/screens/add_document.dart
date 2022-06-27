import 'package:flutter/material.dart';
import 'package:homebinder/utils/constants.dart';

class AddDocument extends StatefulWidget {
  const AddDocument({Key? key}) : super(key: key);


  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {

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
            Text("Valencia, CA", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
            Text('ADD DOCUMENTS', style: TextStyle(color: colorWhite, fontSize: 12,),),
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
                        hintText: 'Home',
                        hintStyle: TextStyle(color: colorText),
                        fillColor: colorFill,
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                    items: <String>['Home A','Home B', 'Home C'].map((String value) {
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
                        hintText: 'Document Name',
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
                          hintText: 'Type',
                          hintStyle: TextStyle(color: colorText),
                          fillColor: colorFill,
                          filled: true,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: <String>['Type A','Type B', 'Type C'].map((String value) {
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
                        hintText: 'Select Document',
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
                          child: const Text("Add Document",style: TextStyle(fontSize:16,color: colorWhite, fontWeight: FontWeight.w600),),
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
