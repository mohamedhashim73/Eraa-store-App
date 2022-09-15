class LoginModel{
  bool? status;
  String? message;
  LoginData? data;
  // Named Constructor to parse data from api and store on this model
  LoginModel.fromJson({required Map<String,dynamic> json}){
    status = json['status'];
    message = json['message'] ;
    data = json['data'] != null ? LoginData.fromJson(json: json['data']) : null ;   // as data is object
  }
}

class LoginData{
  int? id ;
  dynamic name;
  dynamic phone;
  dynamic image;
  String? email;
  String? token;
  dynamic points;
  dynamic credit;
  // named constructor
  LoginData.fromJson({required Map<String,dynamic> json}){
    id = json['id'];
    credit = json['credit'];
    points = json['points'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}