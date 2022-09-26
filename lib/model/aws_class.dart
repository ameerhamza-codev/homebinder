class AWSClass {
  DirectUpload? directUpload;

  AWSClass({this.directUpload});

  AWSClass.fromJson(Map<String, dynamic> json) {
    directUpload = json['direct_upload'] != null
        ? new DirectUpload.fromJson(json['direct_upload'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directUpload != null) {
      data['direct_upload'] = this.directUpload!.toJson();
    }
    return data;
  }
}

class DirectUpload {
  String? url;
  Headers? headers;

  DirectUpload({this.url, this.headers});

  DirectUpload.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    headers =
    json['headers'] != null ? new Headers.fromJson(json['headers']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.headers != null) {
      data['headers'] = this.headers!.toJson();
    }
    return data;
  }
}

class Headers {
  String? contentType;
  String? contentMD5;
  String? contentDisposition;

  Headers({this.contentType, this.contentMD5, this.contentDisposition});

  Headers.fromJson(Map<String, dynamic> json) {
    contentType = json['Content-Type'];
    contentMD5 = json['Content-MD5'];
    contentDisposition = json['Content-Disposition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Content-Type'] = this.contentType;
    data['Content-MD5'] = this.contentMD5;
    data['Content-Disposition'] = this.contentDisposition;
    return data;
  }
}

