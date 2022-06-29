import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../navigator/bottom_navbar.dart';
import '../provider/UserDataProvider.dart';

class AddHome extends StatefulWidget {
  const AddHome({Key? key}) : super(key: key);


  @override
  State<AddHome> createState() => _AddHomeState();
}

class _AddHomeState extends State<AddHome> {

  var _addressController=TextEditingController();
  var _nameController=TextEditingController();
  var _cityController=TextEditingController();
  var _stateController=TextEditingController();
  var _zipController=TextEditingController();
  var _lotController=TextEditingController();
  var _sqrftController=TextEditingController();
  var _acreController=TextEditingController();
  var _dateController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 50,),

                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
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
                TextFormField(
                  controller: _addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
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
                TextFormField(
                  controller: _cityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'City',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _stateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'State',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _zipController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'Zip Code',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _lotController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'LOT Number',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _sqrftController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'Area (Sqrft)',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _acreController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'Area (Acres)',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _dateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: ()async{
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1980, 8),
                        lastDate: DateTime(2101));
                    if (picked != null) {
                    setState(() {
                    _dateController.text = f.format(picked);
                    });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'Build Date',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: InkWell(
                    onTap: ()async{
                      if(_formKey.currentState!.validate()){
                        final provider = Provider.of<UserDataProvider>(context, listen: false);
                        final ProgressDialog pr = ProgressDialog(context: context);
                        pr.show(max: 100, msg: 'Adding House',barrierDismissible: true);
                        try {
                          var dio = Dio();
                          var response = await dio.post(
                              options: Options(
                                 //contentType: Headers.textPlainContentType,
                                  responseType: ResponseType.plain,
                                  //headers: {"Accept":"application/html"}
                              ),
                              '$apiUrl/home/new',
                              data: {
                                'token': provider.userData!.authenticationToken,
                                'address1': _addressController.text,
                                'address2': "",
                                'city': _cityController.text,
                                'state': _stateController.text,
                                'zip': _zipController.text,
                                'community_name': _nameController.text,
                                'lot_number': _lotController.text,
                                'sqft': _sqrftController.text,
                                'land_acres': _acreController.text,
                                'build_date': _dateController.text,

                              }
                          );
                          print("res ${response}");
                          if(response.statusCode==201){
                            pr.close();
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content:  Text('House Successfully Added', textAlign: TextAlign.center,),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pop(context, 'OK');
                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                          builder: (context) =>  BottomNavBar()));
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                          else{
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content:  Text('Http Error : ${response.statusCode}', textAlign: TextAlign.center,),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }

                        }
                        on DioError catch (e) {
                          pr.close();

                          if (e.response != null) {
                            print("e.response != null");
                            print(e.response!.data);
                            print(e.response!.statusCode);
                            if(e.response!.statusCode==401){
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content:  Text('User not found', textAlign: TextAlign.center,),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            else{
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content:  Text('Http Error : ${e.response!.statusCode}', textAlign: TextAlign.center,),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                          else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content:  Text('Http Request Error ${e.response}', textAlign: TextAlign.center,),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      }

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

      ),
    );
  }
}
