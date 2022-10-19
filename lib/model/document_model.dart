class HomeDocumentModel {
  int? id;
  String? name;
  String? category;
  int? publisher;
  int? homeId;
  String? createdAt;
  String? updatedAt;
  String? documentUrl;
  int? owner;

  HomeDocumentModel(
      {this.id,
        this.name,
        this.category,
        this.publisher,
        this.homeId,
        this.createdAt,
        this.updatedAt,
        this.documentUrl,
        this.owner});

  HomeDocumentModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??"";
    category = json['category']??"N/A";
    publisher = json['publisher']??0;
    homeId = json['home_id']??0;
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    documentUrl = json['document_url']??"";
    owner = json['owner']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['publisher'] = this.publisher;
    data['home_id'] = this.homeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['document_url'] = this.documentUrl;
    data['owner'] = this.owner;
    return data;
  }
}