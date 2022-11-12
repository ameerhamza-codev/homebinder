class HomeFeatureModel {
  int? id;
  String? name;
  String? brand;
  String? model;
  String? color;
  String? serialNumber;
  String? sku;
  String? warrantyStartDate;
  String? warrantyEndDate;
  String? warrantyType;
  String? manufacturerPhone;
  String? manufacturerWebsite;
  String? manufacturerSupport;
  String? manufacturerEmail;
  int? homeId;
  String? createdAt;
  String? updatedAt;
  String? category;
  int? owner;
  String? imageUrl;

  HomeFeatureModel(
      {this.id,
        this.name,
        this.brand,
        this.model,
        this.color,
        this.serialNumber,
        this.sku,
        this.warrantyStartDate,
        this.warrantyEndDate,
        this.warrantyType,
        this.manufacturerPhone,
        this.manufacturerWebsite,
        this.manufacturerSupport,
        this.manufacturerEmail,
        this.homeId,
        this.createdAt,
        this.updatedAt,
        this.category,
        this.owner,
        this.imageUrl});

  HomeFeatureModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??'';
    brand = json['brand']??'';
    model = json['model']??'';
    color = json['color']??'';
    serialNumber = json['serial_number']??'';
    sku = json['sku']??'';
    warrantyStartDate = json['warranty_start_date']??'';
    warrantyEndDate = json['warranty_end_date']??'';
    warrantyType = json['warranty_type']??'';
    manufacturerPhone = json['manufacturer_phone']??'';
    manufacturerWebsite = json['manufacturer_website']??'';
    manufacturerSupport = json['manufacturer_support']??'';
    manufacturerEmail = json['manufacturer_email']??'';
    homeId = json['home_id']??0;
    createdAt = json['created_at']??'';
    updatedAt = json['updated_at']??'';
    category = json['category']??'N/A';
    owner = json['owner']??0;
    imageUrl = json['image_url']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['color'] = this.color;
    data['serial_number'] = this.serialNumber;
    data['sku'] = this.sku;
    data['warranty_start_date'] = this.warrantyStartDate;
    data['warranty_end_date'] = this.warrantyEndDate;
    data['warranty_type'] = this.warrantyType;
    data['manufacturer_phone'] = this.manufacturerPhone;
    data['manufacturer_website'] = this.manufacturerWebsite;
    data['manufacturer_support'] = this.manufacturerSupport;
    data['manufacturer_email'] = this.manufacturerEmail;
    data['home_id'] = this.homeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category'] = this.category;
    data['owner'] = this.owner;
    data['image_url'] = this.imageUrl;
    return data;
  }
}