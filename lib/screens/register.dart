import 'package:flutter/material.dart';
import 'package:homebinder/utils/constants.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
                        hintText: 'Email',
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
                        onTap: (){
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: const Text('Please check your email for the email confirmation link.', textAlign: TextAlign.center,),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
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
          ],
        ),

      ),
    );
  }
}
