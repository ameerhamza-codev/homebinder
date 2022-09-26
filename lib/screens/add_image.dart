import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homebinder/model/aws_class.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../model/home_model.dart';
import '../provider/UserDataProvider.dart';

class AddImage extends StatefulWidget {
  HomeModel model;

  AddImage(this.model);


  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? file;
  var _nameController=TextEditingController();
  var _categoryController=TextEditingController();
  late int selectedIndex;  //where I want to store the selected index
  late String initialDropDownVal;
  List<Map<int,DropdownMenuItem<String>>> dropdownItems = [];

  String selectedCategory="";
  List<String> categories=[];
  bool isLoading=false;

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
        if(categories.isNotEmpty)
          selectedCategory=categories.first;
      });

    }
    else print("error ${response.statusCode} : ${response.data}");
    return response.data;

  }
  final _formKey = GlobalKey<FormState>();

  Future awsRequest(AWSClass aws) async{
    Uint8List image = file!.readAsBytesSync();
    var response = await http.put(
      Uri.parse(aws.directUpload!.url.toString()),
      body: file!.readAsBytesSync(),
      //data:Stream.fromIterable(image.map((e) => [e])),
      headers: {

    'Content-Type':aws.directUpload!.headers!.contentType.toString(),
    'Content-MD5':aws.directUpload!.headers!.contentMD5.toString(),
    'Content-Disposition': aws.directUpload!.headers!.contentDisposition.toString(),
    },

    );
    if(response.statusCode==200){

      print("success ${response.body}");

    }
    else{
      print("error ${response.body}");
      print("error ${response.statusCode}");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<UserDataProvider>(context, listen: false);
      getCategories(provider.userData!.authenticationToken, provider.userData!.email);
    });
  }


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
            Text('ADD IMAGE', style: TextStyle(color: colorWhite, fontSize: 12,),),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: <Widget>[
        ]
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                      const SizedBox(height: 50,),

                      TextFormField(
                        controller: _nameController,
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
                          hintText: 'Name',

                          hintStyle: TextStyle(color: colorText),
                          fillColor: colorFill,
                          filled: true,

                        ),
                      ),
                      const SizedBox(height: 10,),
                      if(isLoading)
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      else
                        TextFormField(
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
                          hintStyle: TextStyle(color: colorText),
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
                                      _categoryController.text = value!;
                                    });
                                  },
                                ),
                              ),
                            )
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        onTap: ()async{
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                          );
                          //chat.setReply(false);
                          if (result != null) {
                            file = File(result.files.single.path!);
                            setState(() {

                            });
                          };
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          hintText: 'Select Image',
                          hintStyle: TextStyle(color: colorText),
                          fillColor: colorFill,
                          filled: true,
                          suffixIcon: const Icon(
                              Icons.camera_alt_outlined
                            ),
                          ),
                        ),
                      const SizedBox(height: 20,),
                      if(file!=null)
                        Image.file(file!,height: 200,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                      const SizedBox(height: 20,),
                      Center(
                        child: InkWell(
                          onTap: ()async{
                            if (_formKey.currentState!.validate()){
                              if(file!=null){
                                final ProgressDialog pr = ProgressDialog(context: context);
                                pr.show(max: 100, msg: 'Please Wait',barrierDismissible: true);

                                try{
                                  final provider = Provider.of<UserDataProvider>(context, listen: false);
                                  List<int> imageBytes = await file!.readAsBytesSync();
                                  String checksum = base64Encode(md5.convert(imageBytes).bytes);

                                  var dio = Dio();
                                  var response = await  dio.post('$apiUrl//picture/new',
                                    data:{
                                      'name':_nameController.text,
                                      'home_id':widget.model.id,
                                      'category':selectedCategory,
                                      'location':widget.model.city,
                                      "file":{
                                        "filename":"${_nameController.text}.jpg",
                                        "byte_size":file!.lengthSync(),
                                        "checksum":checksum,
                                        "content_type":"image/jpeg"
                                      }
                                    },
                                    options: Options(
                                      headers: {
                                        'Authorization-Email':provider.userData!.email,
                                        'Authorization':provider.userData!.authenticationToken,
                                        'Content-Type':'application/x-www-form-urlencoded; charset=utf-8',
                                      },
                                    ),
                                  );
                                  if(response.statusCode==200){
                                    AWSClass model=AWSClass.fromJson(response.data);
                                    /* Iterable l = response.data;
                                  homes = List<HomeModel>.from(l.map((model)=> HomeModel.fromJson(model)));*/
                                    print("success ${response.data}");
                                    print("data ${model.directUpload!.url}");

                                    awsRequest(model).then((value){
                                      pr.close();
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          content:  Text('Image added successfully', textAlign: TextAlign.center,),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).onError((error, stackTrace){
                                      pr.close();
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          content:  Text('AWS Request Error', textAlign: TextAlign.center,),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    });



                                  }
                                  else{
                                    pr.close();
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        content:  Text('Http Error ${response.statusCode}', textAlign: TextAlign.center,),
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
                                on DioError catch (e) {
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
                                  }
                                  else {
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
                              else{
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    content:  Text('No image selected', textAlign: TextAlign.center,),
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

                          },
                          child: Container(
                            height: 40,
                            width: width*0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: secondaryColor
                            ),
                            alignment: Alignment.center,
                            child: const Text("Upload Image",style: TextStyle(fontSize:16,color: colorWhite, fontWeight: FontWeight.w600),),
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

      ),
    );
  }
}
