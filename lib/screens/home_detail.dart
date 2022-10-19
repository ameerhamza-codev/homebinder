import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/model/document_model.dart';
import 'package:homebinder/screens/home_documents.dart';
import 'package:homebinder/screens/home_images.dart';
import 'package:homebinder/screens/photo_viewer.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:homebinder/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../model/home_model.dart';
import '../model/image_model.dart';
import '../provider/UserDataProvider.dart';

class Details extends StatefulWidget {
  HomeModel home;


  Details(this.home);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
      homes.removeWhere((element) => element.homeId!=widget.home.id);
      print("user model ${homes}");

    }
    else print("error ${response.statusCode} : ${response.data}");
    return homes;

  }

  Future<List<HomeDocumentModel>> getDocuments(apiToken,email)async{
    print("token $apiToken : email $email");
    List<HomeDocumentModel> homes=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/documents',
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
      homes = List<HomeDocumentModel>.from(l.map((model)=> HomeDocumentModel.fromJson(model)));
      homes.removeWhere((element) => element.homeId!=widget.home.id);
      print("user model ${homes}");

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
      backgroundColor: colorWhite,
      /*appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Center(child: Text("Back",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
              )
          ),
          title:  Text("Home Details", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
          centerTitle: true,

      ),*/
      body: SafeArea(
        child: ListView(
          children: [
            CustomAppbar("Home Details"),
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
                         Expanded(
                            flex:2,
                            child:Center(
                              child: Text("${widget.home.city}, ${widget.home.state}", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: colorWhite),),
                            ) ),
                        Expanded(
                            flex:1,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorBlack),
                                  color: colorWhite
                              ),

                              child:  Center(
                                  child:Text(widget.home.address1.toString(), style: TextStyle(color: colorText, fontSize: 16), )
                              ),
                            )
                        ),
                        Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  PhotoViewer(widget.home.communityName!,widget.home.imageUrl!)));

                                },
                                child: widget.home.imageUrl!=""?
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: colorBlack),
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                                    image:  DecorationImage(
                                      image: NetworkImage(widget.home.imageUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                    :
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: colorBlack),
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                                    image: const DecorationImage(
                                      image: AssetImage("assets/images/placeholder-image.jpeg"),
                                      fit: BoxFit.cover,
                                    ),
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
                  Container(
                    height: 200,
                    child: FutureBuilder<List<HomeDocumentModel>>(
                        future: getDocuments(provider.userData!.authenticationToken,provider.userData!.email),
                        builder: (context,AsyncSnapshot<List<HomeDocumentModel>> snapshot) {
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
                                child: Text("No Documents"),
                              );
                            }

                            else {

                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context,int index){
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  PhotoViewer(snapshot.data![index].name!,snapshot.data![index].documentUrl!)));

                                          },
                                          child: Column(
                                            children: [
                                              if(snapshot.data![index].documentUrl=="")
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
                                                )
                                              else
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(
                                                      image: NetworkImage(snapshot.data![index].documentUrl!),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              Text(snapshot.data![index].name!)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                      ],
                                    );
                                  }
                              );
                            }
                          }
                        }
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Images",style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
                      IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  HomeImages(widget.home)));
                          },
                          icon: Icon(Icons.open_in_new))
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 200,
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
                              return  Center(
                                child: Text("Something went wrong ${snapshot.error}"),
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
                                scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context,int index){
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  PhotoViewer(snapshot.data![index].name!,snapshot.data![index].imageUrl!)));

                                          },
                                          child: Column(
                                            children: [
                                              if(snapshot.data![index].imageUrl=="")
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
                                              )
                                              else
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(
                                                      image: NetworkImage(snapshot.data![index].imageUrl!),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              Text(snapshot.data![index].name!)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                      ],
                                    );
                                  }
                              );
                            }
                          }
                        }
                    ),
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
