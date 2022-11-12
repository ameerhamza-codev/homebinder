class ProfileModel {
  String? email;
  String? lastSignInAt;
  String? lastname;
  String? firstname;
  String? role;
  String? avatarUrl;

  ProfileModel(
      {this.email,
        this.lastSignInAt,
        this.lastname,
        this.firstname,
        this.role,
        this.avatarUrl});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    email = json['email']??"";
    lastSignInAt = json['last_sign_in_at']??"";
    lastname = json['lastname']??"";
    firstname = json['firstname']??"";
    role = json['role']??"";
    avatarUrl = json['avatar_url']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['last_sign_in_at'] = this.lastSignInAt;
    data['lastname'] = this.lastname;
    data['firstname'] = this.firstname;
    data['role'] = this.role;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}