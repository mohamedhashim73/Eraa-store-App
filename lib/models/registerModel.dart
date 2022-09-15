class RegisterModel{
  bool? status;
  String? message;
  RegisterData? data;
  // Named Constructor to parse data from api and store on this model
  RegisterModel.fromJson({required Map<String,dynamic> json}){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? RegisterData.fromJson(json: json['data']) : null ;   // as data is object
  }
}

class RegisterData{
  int? id ;
  dynamic name;
  dynamic phone;
  dynamic image;
  dynamic email;
  String? token;
  // named constructor
  RegisterData.fromJson({required Map<String,dynamic> json}){
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    token = json['token'];
  }
}