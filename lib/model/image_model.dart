class HomeImageModel {
  int? id;
  String? name;
  String? location;
  int? homeId;
  int? owner;
  String? publisher;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  String? category;

  HomeImageModel(
      {this.id,
        this.name,
        this.location,
        this.homeId,
        this.owner,
        this.publisher,
        this.createdAt,
        this.updatedAt,
        this.imageUrl,
        this.category});

  HomeImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??"";
    location = json['location']??"";
    homeId = json['home_id']??0;
    owner = json['owner']??0;
    publisher = json['publisher']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    imageUrl = json['image_url']??"";
    category = json['category']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['home_id'] = this.homeId;
    data['owner'] = this.owner;
    data['publisher'] = this.publisher;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    data['category'] = this.category;
    return data;
  }
}