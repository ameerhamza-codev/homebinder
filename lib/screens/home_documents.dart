import 'package:flutter/material.dart';
import 'package:homebinder/screens/add_document.dart';
import 'package:homebinder/utils/constants.dart';

class HomeDocuments extends StatefulWidget {
  const HomeDocuments({Key? key}) : super(key: key);

  @override
  State<HomeDocuments> createState() => _HomeDocumentsState();
}

class _HomeDocumentsState extends State<HomeDocuments> {

  @override
  Widget build(BuildContext context) {

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
            children: const [
              Text("Valencia, CA", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
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
        child: ListView(
          children: [
            Padding(
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
                  Row(
                    children: [
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
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Homeowner Troubleshooting"),
                          const SizedBox(height: 3),
                          Text("Type: Manual"),
                          const SizedBox(height: 3),
                          Text("Added 8 months ago"),
                          const SizedBox(height: 3),
                          Text("3.2 Meg"),
                          const SizedBox(height: 3),
                          Text("Home Owner Manual.pdf"),
                        ],
                      )

                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
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
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Homeowner Troubleshooting"),
                          const SizedBox(height: 3),
                          Text("Type: Manual"),
                          const SizedBox(height: 3),
                          Text("Added 8 months ago"),
                          const SizedBox(height: 3),
                          Text("3.2 Meg"),
                          const SizedBox(height: 3),
                          Text("Home Owner Manual.pdf"),
                        ],
                      )

                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
