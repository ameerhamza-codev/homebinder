import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/model/home_model.dart';
import 'package:homebinder/model/image_model.dart';
import 'package:homebinder/screens/add_document.dart';
import 'package:homebinder/screens/add_image.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

import '../provider/UserDataProvider.dart';

class HomeImages extends StatefulWidget {
  HomeModel model;

  HomeImages(this.model);

  @override
  State<HomeImages> createState() => _HomeImagesState();
}

class _HomeImagesState extends State<HomeImages> {
  Future<List<HomeImageModel>> getImages(apiToken,email)async{
    print("token $apiToken : email $email");
    List<HomeImageModel> homes=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/pictures',
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
      homes = List<HomeImageModel>.from(l.map((model)=> HomeImageModel.fromJson(model)));
      print("user model ${homes}");

    }
    else print("error ${response.statusCode} : ${response.data}");
    return homes;

  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context, listen: false);

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
            children:  [
              Text("${widget.model.city}, ${widget.model.state}", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
              Text('IMAGES', style: TextStyle(color: colorWhite, fontSize: 12,),),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  AddImage(widget.model)));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Center(child: Text("Add",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
              ),
            ),
          ]
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: colorText),
                        fillColor: colorFill,
                        filled: true,

                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)
                          ),
                          hintText: 'Filter',
                          hintStyle: TextStyle(color: colorText),
                          fillColor: colorFill,
                          filled: true,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: <String>['Filter A','Filter B', 'Filter C'].map((String value) {
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

                  )
                ],
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: FutureBuilder<List<HomeImageModel>>(
                    future: getImages(provider.userData!.authenticationToken,provider.userData!.email),
                    builder: (context,AsyncSnapshot<List<HomeImageModel>> snapshot) {
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
                            child: Text("No Images"),
                          );
                        }

                        else {

                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context,int index){
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        if(snapshot.data![index].imageUrl=="")
                                          Container(
                                          height: 150,
                                          width: 150,
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: colorFill,
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 5,
                                                right: 5,
                                                child: Icon(Icons.upload_outlined),
                                              )
                                            ],
                                          ),
                                        )
                                        else
                                          Container(
                                            height: 150,
                                            width: 150,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(snapshot.data![index].imageUrl!),
                                                        fit: BoxFit.contain
                                                      ),
                                                      borderRadius: BorderRadius.circular(15)
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 5,
                                                  right: 5,
                                                  child: Icon(Icons.upload_outlined),
                                                )
                                              ],
                                            ),
                                          ),
                                        const SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![index].name!),
                                            const SizedBox(height: 3),
                                            Text(snapshot.data![index].category!),
                                            const SizedBox(height: 3),
                                            Text(format(DateTime.parse(snapshot.data![index].createdAt!))),
                                            const SizedBox(height: 3),
                                            Text(snapshot.data![index].location!),
                                          ],
                                        )

                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                );
                              }
                          );
                        }
                      }
                    }
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
