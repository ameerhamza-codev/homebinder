class HomeModel {
  final int? id;
  final String? usn;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? zip;
  final String? communityName;
  final String? lotNumber;
  final String? sqft;
  final String? landAcres;
  final String? buildDate;

  HomeModel({
    this.id,
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
  });

  HomeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        usn = json['usn'] ?? "",
        address1 = json['address1'] as String?,
        address2 = json['address2'] as String?,
        city = json['city'] as String?,
        state = json['state'] as String?,
        zip = json['zip'] as String?,
        communityName = json['community_name'] as String?,
        lotNumber = json['lot_number'] as String?,
        sqft = json['sqft'] as String?,
        landAcres = json['land_acres'] as String?,
        buildDate = json['build_date'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'usn' : usn,
    'address1' : address1,
    'address2' : address2,
    'city' : city,
    'state' : state,
    'zip' : zip,
    'community_name' : communityName,
    'lot_number' : lotNumber,
    'sqft' : sqft,
    'land_acres' : landAcres,
    'build_date' : buildDate
  };
}