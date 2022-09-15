class CategoriesModel {
  bool? status;
  CategoriesData? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CategoriesData.fromJson(json['data']) : null;
  }
}

class CategoriesData {
  int? currentPage;
  List<CategoriesInfo>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CategoriesInfo>[];
      json['data'].forEach((v) {
        data!.add(CategoriesInfo.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class CategoriesInfo {
  int? id;
  String? name;
  String? image;

  CategoriesInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}

List<String> category =
[
  "Jackets, Jeans, Denim...",
  "Dress, T-Shirt, Treasures...","Clothing, Toys, Books...",
  "Necklaces, Chains, Earnings...",
  "Shoes, Sandals, ActiveWear"
];