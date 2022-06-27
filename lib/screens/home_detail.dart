import 'package:flutter/material.dart';
import 'package:homebinder/screens/home_documents.dart';
import 'package:homebinder/screens/home_images.dart';
import 'package:homebinder/utils/constants.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);


  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorWhite,
      appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Center(child: Text("Back",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
              )
          ),
          title:  Text("Home Details", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
          centerTitle: true,
          actions: <Widget>[
          ]
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: height*0.3,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: width,
                    height: height*0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30),
                    child: Column(
                      children: [
                        const Expanded(
                            flex:2,
                            child:Center(
                              child: Text("Valencia, CA", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: colorWhite),),
                            ) ),
                        Expanded(
                            flex:1,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorBlack),
                                  color: colorWhite
                              ),

                              child: const Center(
                                  child:Text("12 NE 88 Avenue, Santa Clara CA 98210", style: TextStyle(color: colorText, fontSize: 16), )
                              ),
                            )
                        ),
                        Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: colorBlack),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/placeholder-image.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Documents",style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
                      IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  HomeDocuments()));
                          },
                          icon: Icon(Icons.open_in_new))
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage("assets/icons/placeholder-icon.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text("House Plans")
                        ],
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage("assets/icons/placeholder-icon.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text("House Plans")
                        ],
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage("assets/icons/placeholder-icon.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text("House Plans")
                        ],
                      )

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Images",style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
                      IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  HomeImages()));
                          },
                          icon: Icon(Icons.open_in_new))
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage("assets/icons/placeholder-icon.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text("Front Yard")
                        ],
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage("assets/icons/placeholder-icon.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text("Front Yard")
                        ],
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage("assets/icons/placeholder-icon.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text("Front Yard")
                        ],
                      )

                    ],
                  ),
                  const SizedBox(height: 10,),

                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
