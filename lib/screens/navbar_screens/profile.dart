import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homebinder/model/profile_model.dart';
import 'package:homebinder/utils/constants.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../provider/UserDataProvider.dart';
import '../login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Future<ProfileModel> getProfileData(apiToken,email)async{
    ProfileModel? user;
    var dio = Dio();
    var response = await  dio.post('$apiUrl/profile',
      options: Options(
        headers: {
          'Authorization-Email':email,
          'Authorization':apiToken,
          'Content-Type':'application/x-www-form-urlencoded; charset=utf-8',
        },
      ),
    );
    print("res ${response.statusCode} ${response.data} $apiToken");
    if(response.statusCode==201){
      user=ProfileModel.fromJson(response.data);

    }
    else print("error ${response.statusCode} : ${response.data}");
    return user!;

  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context, listen: false);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorWhite,
      appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: Container(),
          centerTitle: true,
          title: Column(
            children: const [
              Text("Profile", style: TextStyle(color: colorWhite, fontSize: 24, fontWeight: FontWeight.w500),),
            ],
          ),
          actions: <Widget>[
            InkWell(
              onTap: (){
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Center(child: Text("Edit",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
              ),
            ),
          ]
      ),
      body: SafeArea(
        child: FutureBuilder<ProfileModel>(
            future: getProfileData(provider.userData!.authenticationToken,provider.userData!.email),
            builder: (context,AsyncSnapshot<ProfileModel> snapshot) {
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
                else if (snapshot.data==null) {
                  print("error ${snapshot.error}");
                  return const Center(
                    child: Text("Unable to fetch data"),
                  );
                }

                else {

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: width,
                            height: height*0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
                              color: primaryColor,
                            ),
                          ),
                          snapshot.data!.avatarUrl!=""?
                          Positioned(
                            top:(height*0.2)-100,
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: colorWhite),
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data!.avatarUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                              :
                          Positioned(
                            top:(height*0.2)-100,
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: colorWhite),
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/placeholder-image.jpeg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 80,),
                      Center(child: Text(snapshot.data!.lastname!,style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),)),
                      const SizedBox(height: 10,),
                      Center(child: Text(snapshot.data!.role!,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                      const SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name: ${snapshot.data!.lastname}",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                            const Divider(height: 1,)
                          ],
                        ),
                      ),
                      /*const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Last Name: Robertson",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                            const Divider(height: 1,)
                          ],
                        ),
                      ),*/
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email: ${snapshot.data!.email!}",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                            const Divider(height: 1,)
                          ],
                        ),
                      ),
                      /*const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Phone: (765) 324-7629",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                            const Divider(height: 10,)
                          ],
                        ),
                      ),*/
                      const SizedBox(height: 30,),
                      InkWell(
                          onTap: ()async{
                            var dio = Dio();
                            var response = await  dio.delete('$apiUrl/sessions/sign_out',
                              options: Options(
                                headers: {
                                  'Authorization-Email':provider.userData!.email,
                                  'Authorization':provider.userData!.authenticationToken,
                                  'Content-Type':'application/x-www-form-urlencoded; charset=utf-8',
                                },
                              ),
                            );
                            print("res ${response.statusCode} ${response.data}");
                            if(response.statusCode==200){
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  Login()), (Route<dynamic> route) => false);
                            }
                            else print("error ${response.statusCode} : ${response.data}");

                          },
                          child: Center(child: Text("Logout",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),))
                      ),


                    ],
                  );
                }
              }
            }
        ),

      ),
    );
  }
}
