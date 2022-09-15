class HomeModel
{
  bool? status;
  DataHomeModel? data;
  HomeModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    data = DataHomeModel.fromJson(json['data']);
  }
}

class DataHomeModel
{
  List<BannerModel>banners = [];
  List<ProductModel>products = [];
  DataHomeModel.fromJson(Map<String, dynamic>json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel
{
  int? id;
  dynamic image;
  BannerModel.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    image = json['image'];
  }
}
class ProductModel
{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  dynamic image;
  dynamic name;
  dynamic description;
  bool? inFavorite;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
    description = json['description'];
  }
}