import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/model/home_model.dart';
import 'package:homebinder/model/image_model.dart';
import 'package:homebinder/screens/add_document.dart';
import 'package:homebinder/screens/add_image.dart';
import 'package:homebinder/screens/photo_viewer.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

import '../provider/UserDataProvider.dart';
import '../widgets/curved_appbar.dart';

class HomeImages extends StatefulWidget {
  HomeModel model;

  HomeImages(this.model);

  @override
  State<HomeImages> createState() => _HomeImagesState();
}

class _HomeImagesState extends State<HomeImages> {
  List<HomeImageModel> homes=[];
  getImages(apiToken,email,id)async{
    setState(() {
      isItemsLoading=true;
      homes.clear();
    });
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
    setState(() {
      isItemsLoading=false;
    });
    if(response.statusCode==200){

      Iterable l = response.data;
      setState(() {
        homes = List<HomeImageModel>.from(l.map((model)=> HomeImageModel.fromJson(model)));
        homes.removeWhere((element) => element.homeId!=id);
        if(_searchController.text!=""){
          homes.removeWhere((element) => !element.name!.toLowerCase().contains(_searchController.text.toLowerCase().trim()));
        }
        if(_categoryController.text!=""){
          homes.removeWhere((element) => element.category!=_categoryController.text);
        }


      });
    }

  }

  var _categoryController=TextEditingController();
  var _searchController=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<UserDataProvider>(context, listen: false);
      getCategories(provider.userData!.authenticationToken, provider.userData!.email);
      getImages(provider.userData!.authenticationToken,provider.userData!.email,provider.home!.id);
    });
  }

  bool isLoading=false;
  bool isItemsLoading=false;
  String selectedCategory="";
  List<String> categories=[];
  getCategories(apiToken,email)async{
    setState(() {
      isLoading=true;
    });
    print("token $apiToken : email $email");
    //List<HomeModel> homes=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/pictures/categories',
      options: Options(
        headers: {
          'Authorization-Email':email,
          'Authorization':apiToken,
          'Content-Type':'application/x-www-form-urlencoded; charset=utf-8',
        },
      ),
    );
    print("res ${response.statusCode} ${response.data} $apiToken");
    setState(() {
      isLoading=false;
    });
    if(response.statusCode==200){
      print("categories ${response.data}");

      List<DropdownMenuItem<String>> dropdownItems = [];
      Map map=response.data;
      map.keys.forEach((element) {
        categories.add(element);
      });
      setState(() {
        if(categories.isNotEmpty) {
          selectedCategory=categories.first;
        }
      });

    }
    else print("error ${response.statusCode} : ${response.data}");
    return response.data;

  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context, listen: false);

    return Scaffold(
      body: Column(
        children: [
          CurvedAppbar(
            title: 'IMAGES',
            subtitle: "${provider.home!.city}, ${provider.home!.state}",
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  AddImage(widget.model)));
            },
            isAdd: true,
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value)async{
                      getImages(provider.userData!.authenticationToken,provider.userData!.email,provider.home!.id);
                    },
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


                /*Expanded(
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

                    )*/
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: isLoading?
              Center(
                child: CircularProgressIndicator(),
              ):
              TextFormField(
                readOnly: true,
                controller: _categoryController,
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
                    hintText: 'Category',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: colorFill,
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: categories.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              print("valye ${value!}");
                              _categoryController.text = value;
                              getImages(provider.userData!.authenticationToken,provider.userData!.email,provider.home!.id);
                            });
                          },
                        ),
                      ),
                    )
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          if (isItemsLoading)
            Center(
              child: CircularProgressIndicator(),
            )
          else
            Expanded(
              child: ListView.builder(
                  itemCount: homes.length,
                  itemBuilder: (BuildContext context,int index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  PhotoViewer(homes[index].name!,homes[index].imageUrl!)));

                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              if(homes[index].imageUrl=="")
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
                                                image: NetworkImage(homes[index].imageUrl!),
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
                                  Text(homes[index].name!),
                                  const SizedBox(height: 3),
                                  Text(homes[index].category!),
                                  const SizedBox(height: 3),
                                  Text(format(DateTime.parse(homes[index].createdAt!))),
                                  const SizedBox(height: 3),
                                  Text(homes[index].location!),
                                ],
                              )

                            ],
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    );
                  }
              ),
            ),


        ],
      ),
    );
  }
}
