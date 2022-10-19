import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../model/aws_class.dart';
import '../provider/UserDataProvider.dart';

class AddDocument extends StatefulWidget {



  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  File? file;
  var _nameController=TextEditingController();
  var _categoryController=TextEditingController();
  var _mediaController=TextEditingController();



  bool isLoading=false;
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
  final _formKey = GlobalKey<FormState>();

  Future awsRequest(AWSClass aws) async{
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
    String ext='';
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
          children: [
            Text("${provider.home!.city}, ${provider.home!.state}", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
            Text('ADD DOCUMENTS', style: TextStyle(color: colorWhite, fontSize: 12,),),
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
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'pdf', 'doc','png','jpeg'],
                          );
                          //chat.setReply(false);
                          if (result != null) {

                            file = File(result.files.single.path!);
                            ext=result.files.single.extension!;
                            print("file ext:$ext");
                            _mediaController.text=result.files.single.name;
                            print('${file!=null} && (${ext=='pdf' || ext=='doc'})');
                            print('${file!=null && (ext!='doc' && ext!='pdf')}');
                            setState(() {

                            });
                          };
                        },
                        readOnly: true,
                        controller: _mediaController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          hintText: 'Select Document',
                          hintStyle: TextStyle(color: colorText),
                          fillColor: colorFill,
                          filled: true,
                          suffixIcon: const Icon(
                              Icons.camera_alt_outlined
                          ),
                        ),
                      ),

                      const SizedBox(height: 20,),
                     /* if(file!=null)
                        (ext=='pdf' || ext=='doc')?
                        Center(
                          child: Text("Document : ${file!.path}"),
                        ):
                        Image.file(file!,height: 200,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),*/
                      /*if(file!=null && ext=='pdf')
                      ,
                      if(file!=null && ext!='pdf')*/
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
                                  var response = await  dio.post('$apiUrl//document/new',
                                    data:{
                                      'name':_nameController.text,
                                      'home_id':provider.home!.id,
                                      'category':selectedCategory,
                                      'location':provider.home!.city,
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
                                          content:  Text('Document added successfully', textAlign: TextAlign.center,),
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
                                    content:  Text('No document selected', textAlign: TextAlign.center,),
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
                            child: const Text("Add Document",style: TextStyle(fontSize:16,color: colorWhite, fontWeight: FontWeight.w600),),
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
