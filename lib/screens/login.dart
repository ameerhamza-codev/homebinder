import 'package:flutter/material.dart';
import 'package:homebinder/screens/register.dart';
import 'package:homebinder/utils/constants.dart';

import '../navigator/bottom_navbar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;

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
                    const SizedBox(height: 80,),
                    TextField(
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
                    TextField(
                      obscureText: _isObscure,
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
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  BottomNavBar()));
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
                              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AuthInfo()));
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
          ],
        ),

      ),
    );
  }
}
