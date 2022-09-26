class UserModel {
  UserModel({
    required this.email,
    required this.authenticationToken,
  });
  late final String email;
  late final String authenticationToken;



  UserModel.fromJson(Map<String, dynamic> json){
    email = json['email']??"";
    authenticationToken = json['authentication_token'];
  }


}