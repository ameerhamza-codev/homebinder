import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../model/user_model.dart';
import '../navigator/bottom_navbar.dart';
import '../provider/UserDataProvider.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _firstNameController=TextEditingController();
  var _lastNameController=TextEditingController();
  var _emailController=TextEditingController();
  var _passwordController=TextEditingController();
  var _confirmPasswordController=TextEditingController();


  bool checkedValue = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;




    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text("Sign Up", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w600),),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  Login()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Center(child: Text("Login",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
            ),
          ),
        ]
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80,),
                TextFormField(
                  controller: _firstNameController,
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
                    hintText: 'First Name',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,

                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _lastNameController,
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
                    hintText: 'Last Name',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,

                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _emailController,
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
                    hintText: 'Email',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,

                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,


                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,


                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: checkedValue,
                      onChanged: (newValue) {
                        setState(() {
                          checkedValue = newValue!;
                        });
                      },
                    ),
                    Text("I would like to receive your newsletter and \nother promotional information."),
                  ],
                ),
                const SizedBox(height: 20,),
                Center(
                  child: InkWell(
                    onTap: ()async{
                      if (_formKey.currentState!.validate()) {


                        if(_confirmPasswordController.text==_passwordController.text){
                          final ProgressDialog pr = ProgressDialog(context: context);
                          pr.show(max: 100, msg: 'Registering',barrierDismissible: true);
                          try {

                            final ProgressDialog pr = ProgressDialog(context: context);
                            pr.show(max: 100, msg: 'Registered');
                            var response= await Dio().post(
                                '$apiUrl/registrations',
                                data: {
                                  'email': _emailController.text.trim(),
                                  'firstname': _firstNameController.text,
                                  'lastname': _lastNameController.text,
                                  'password': _passwordController.text,
                                  'password_confirmation': _confirmPasswordController.text,

                                }
                            );
                            if(response.statusCode==201){
                              pr.close();
                              UserModel model=UserModel.fromJson(response.data);
                              print("user model ${model.authenticationToken}");
                              final provider = Provider.of<UserDataProvider>(context, listen: false);
                              provider.setUserData(model);
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  BottomNavBar()));

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

                          } on DioError catch (e) {
                            pr.close();

                            if (e.response != null) {
                              print("e.response != null");
                              print(e.response!.data);
                              print(e.response!.statusCode);
                              if(e.response!.statusCode==422){
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    content:  Text('User already registered', textAlign: TextAlign.center,),
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
                            } else {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content:  Text('Http Request Error', textAlign: TextAlign.center,),
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
                        else{
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: const Text('Password do not match', textAlign: TextAlign.center,),
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

                    },
                    child: Container(
                      height: 40,
                      width: width*0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: secondaryColor
                      ),
                      alignment: Alignment.center,
                      child: const Text("Sign Up",style: TextStyle(fontSize:16,color: colorWhite, fontWeight: FontWeight.w600),),
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
