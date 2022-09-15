class ChangeCartModel{
  bool? status;
  String? message;
  ChangeCartModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}

class ChangeFavoriteModel{
  bool? status;
  String? message;
  ChangeFavoriteModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}