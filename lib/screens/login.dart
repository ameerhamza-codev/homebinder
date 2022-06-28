import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/model/user_model.dart';
import 'package:homebinder/screens/register.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:homebinder/utils/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../navigator/bottom_navbar.dart';
import '../provider/UserDataProvider.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  var _emailController=TextEditingController();
  var _passwordController=TextEditingController();
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
        title: const Text("Log In", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w600),),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
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

                const SizedBox(height: 10,),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: colorText),
                    fillColor: colorFill,
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30,),
                Center(
                  child: InkWell(
                    onTap: ()async{
                      if(_formKey.currentState!.validate()){
                        final ProgressDialog pr = ProgressDialog(context: context);
                        pr.show(max: 100, msg: 'Logging In',barrierDismissible: true);
                        try {
                          var dio = Dio();
                          var response = await dio.post(
                              '$apiUrl/sessions',
                              data: {
                                'email': _emailController.text.trim(),
                                'password': _passwordController.text,

                              }
                          );
                          if(response.statusCode==201){
                            pr.close();
                            UserModel model=UserModel.fromJson(response.data);
                            print("user model ${model.authenticationToken}");
                            final provider = Provider.of<UserDataProvider>(context, listen: false);
                            provider.setUserData(model);
                            SharedPrefHelper helper=new SharedPrefHelper();
                            helper.setPrefUserData(jsonEncode(response.data));
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

                    },
                    child: Container(
                      height: 40,
                      width: width*0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: secondaryColor
                      ),
                      alignment: Alignment.center,
                      child: const Text("LOG IN",style: TextStyle(fontSize:16,color: colorWhite, fontWeight: FontWeight.w600),),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Center(
                    child:InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ForgotPassword()));
                        },
                        child: const Text("Forgot your password?", style: TextStyle( color: colorText, fontSize: 16, fontWeight: FontWeight.w600),)
                    )
                ),
                SizedBox(height: 20,),
                Center(
                    child:InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Register()));
                        },
                        child: const Text("Don't have an account? SIGN UP", style: TextStyle( color: colorText, fontSize: 16, fontWeight: FontWeight.w500),)
                    )
                ),


              ],
            ),
          ),

        ),

      ),
    );
  }
}
