import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/screens/add_document.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

import '../model/document_model.dart';
import '../provider/UserDataProvider.dart';

class HomeDocuments extends StatefulWidget {
  const HomeDocuments({Key? key}) : super(key: key);

  @override
  State<HomeDocuments> createState() => _HomeDocumentsState();
}

class _HomeDocumentsState extends State<HomeDocuments> {

  var _categoryController=TextEditingController();
  var _searchController=TextEditingController();

  List<HomeDocumentModel> documents=[];
  getDocuments(apiToken,email,id)async{
    setState(() {
      isItemsLoading=true;
      documents.clear();
    });
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
    setState(() {
      isItemsLoading=false;
    });
    if(response.statusCode==200){

      Iterable l = response.data;
      setState(() {
        documents = List<HomeDocumentModel>.from(l.map((model)=> HomeDocumentModel.fromJson(model)));
        documents.removeWhere((element) => element.homeId!=id);

        if(_searchController.text!=""){
          documents.removeWhere((element) => !element.name!.toLowerCase().contains(_searchController.text.toLowerCase().trim()));
        }
        if(_categoryController.text!=""){
          documents.removeWhere((element) => element.category!=_categoryController.text);
        }


      });

    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<UserDataProvider>(context, listen: false);
      getCategories(provider.userData!.authenticationToken, provider.userData!.email);
      getDocuments(provider.userData!.authenticationToken,provider.userData!.email,provider.home!.id);
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
    var response = await  dio.get('$apiUrl/documents/categories',
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
        if(categories.isNotEmpty)
          selectedCategory=categories.first;
      });

    }
    else print("error ${response.statusCode} : ${response.data}");
    return response.data;

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
              Text("${provider.home!.city}, ${provider.home!.state}", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
              Text('DOCUMENTS', style: TextStyle(color: colorWhite, fontSize: 12,),),
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
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  AddDocument()));
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
                    flex: 7,
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value)async{
                        getDocuments(provider.userData!.authenticationToken,provider.userData!.email,provider.home!.id);
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
              const SizedBox(height: 20,),
              Container(
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
                                getDocuments(provider.userData!.authenticationToken,provider.userData!.email,provider.home!.id);
                              });
                            },
                          ),
                        ),
                      )
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
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context,int index){
                        return Column(
                          children: [
                            Row(
                              children: [
                                if(documents[index].documentUrl=="")
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
                                                  image: NetworkImage(documents[index].documentUrl!),
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
                                    Text(documents[index].name!),
                                    const SizedBox(height: 3),
                                    Text(documents[index].category!),
                                    const SizedBox(height: 3),
                                    Text(format(DateTime.parse(documents[index].createdAt!))),
                                    const SizedBox(height: 3),
                                  ],
                                )

                              ],
                            ),
                            SizedBox(height: 20,),
                          ],
                        );
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
