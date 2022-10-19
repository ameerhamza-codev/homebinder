import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/model/home_model.dart';
import 'package:homebinder/screens/add_home.dart';
import 'package:homebinder/screens/home_detail.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../provider/UserDataProvider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<HomeModel>> getHomes(apiToken,email)async{
    print("token $apiToken : email $email");
    List<HomeModel> homes=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/homes',
      options: Options(
        headers: {
          'Authorization-Email':email,
          'Authorization':apiToken,
          'Content-Type':'application/x-www-form-urlencoded; charset=utf-8',
        },
      ),
    );
    print("res ${response.statusCode} ${response.data} $apiToken");
    if(response.statusCode==200){

      Iterable l = response.data;
      homes = List<HomeModel>.from(l.map((model)=> HomeModel.fromJson(model)));
      //print("user model ${homes}");

    }
    else print("error ${response.statusCode} : ${response.data}");
    return homes;

  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final provider = Provider.of<UserDataProvider>(context, listen: false);



    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: Container(),
          centerTitle: true,
          title: Column(
            children: const [
              Text("HOME BINDER", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  AddHome()));
                },
                icon: Icon(Icons.add_circle))
          ]
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all( 10.0),
          child: FutureBuilder<List<HomeModel>>(
              future: getHomes(provider.userData!.authenticationToken,provider.userData!.email),
              builder: (context,AsyncSnapshot<List<HomeModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else {
                  if (snapshot.hasError) {
                    print("error ${snapshot.error}");
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  else if (snapshot.data!.length==0) {
                    print("error ${snapshot.error}");
                    return const Center(
                      child: Text("No Houses"),
                    );
                  }

                  else {

                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context,int index){
                          return InkWell(
                            onTap: (){
                              provider.setHomeModel(snapshot.data![index]);
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  Details(snapshot.data![index])));
                            },
                            child: Container(
                              height: height*0.4,
                              width: width,
                              child: Column(
                                children: [
                                  Expanded(
                                      flex:2,
                                      child:Center(
                                        child: Text("${snapshot.data![index].city!}, ${snapshot.data![index].state!}", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: colorWhite),),
                                      ) ),
                                  Expanded(
                                      flex:1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: colorBlack),
                                            color: colorWhite
                                        ),

                                        child: Center(
                                            child:Text(snapshot.data![index].address1!, style: TextStyle(color: colorText, fontSize: 16), )
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 7,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15.0),
                                        child: snapshot.data![index].imageUrl==""?
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: colorBlack),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/placeholder-image.jpeg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                        :
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: colorBlack),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                                            image: DecorationImage(
                                              image: NetworkImage(snapshot.data![index].imageUrl!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  }
                }
              }
          ),
        ),

      ),
    );
  }
}
