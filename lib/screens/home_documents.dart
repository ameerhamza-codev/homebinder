import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/screens/add_document.dart';
import 'package:homebinder/screens/pdf_viewer.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

import '../model/document_model.dart';
import '../provider/UserDataProvider.dart';
import '../widgets/curved_appbar.dart';

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

      body: Column(
        children: [
          CurvedAppbar(
            title: 'DOCUMENTS',
            subtitle: "${provider.home!.city}, ${provider.home!.state}",
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  AddDocument()));
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
                              getDocuments(provider.userData!.authenticationToken,provider.userData!.email,provider.home!.id);
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
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context,int index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  PdfViewClass(documents[index].name!,documents[index].documentUrl!)));
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [

                              Container(
                                height: 150,
                                width: 150,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage('assets/icons/pdf.png'),
                                              fit: BoxFit.contain
                                          ),
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 15,
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
