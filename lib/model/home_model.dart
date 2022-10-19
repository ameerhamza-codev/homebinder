class HomeModel {
  int? id;
  String? usn;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zip;
  String? communityName;
  String? lotNumber;
  String? sqft;
  String? landAcres;
  String? buildDate;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? name;
  String? imageUrl;

  HomeModel(
      {this.id,
        this.usn,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.zip,
        this.communityName,
        this.lotNumber,
        this.sqft,
        this.landAcres,
        this.buildDate,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.name,
        this.imageUrl});

  HomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    usn = json['usn']??"";
    address1 = json['address1']??"";
    address2 = json['address2']??"";
    city = json['city']??"";
    state = json['state']??"";
    zip = json['zip']??"";
    communityName = json['community_name']??"";
    lotNumber = json['lot_number']??"";
    sqft = json['sqft']??"";
    landAcres = json['land_acres']??"";
    buildDate = json['build_date']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    userId = json['user_id']??0;
    name = json['name']??"";
    imageUrl = json['image_url']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['usn'] = this.usn;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['community_name'] = this.communityName;
    data['lot_number'] = this.lotNumber;
    data['sqft'] = this.sqft;
    data['land_acres'] = this.landAcres;
    data['build_date'] = this.buildDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    return data;
  }
}