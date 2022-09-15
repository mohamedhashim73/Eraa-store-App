class ProfileData{
  bool? status;
  ProfileInfo? data;
  // Named Constructor
  ProfileData.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = json['data'] != null ? ProfileInfo.fromJson(json['data']) : null ;
  }
}

class ProfileInfo{
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;
  dynamic points;
  dynamic credit;
  String? token;
  // Named constructor
  ProfileInfo.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    credit = json['credit'];
    points = json['points'];
    token = json['token'];
  }
}