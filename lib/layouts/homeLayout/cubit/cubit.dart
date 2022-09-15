import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layouts/homeLayout/cubit/states.dart';
import 'package:untitled/main.dart';
import 'package:untitled/models/categoriesModel.dart';
import 'package:untitled/models/changeCart&FavoriteStatusModel.dart';
import 'package:untitled/models/getCartModel.dart';
import 'package:untitled/models/loginModel.dart';
import 'package:untitled/models/profileDataModel.dart';
import 'package:untitled/modules/cart_screen/cart_screen.dart';
import 'package:untitled/modules/category_screen/category_screen.dart';
import 'package:untitled/modules/favorite_screen/favorite_screen.dart';
import 'package:untitled/modules/home_screen/home_screen.dart';
import 'package:untitled/modules/profile_screen/profile_screen.dart';
import 'package:untitled/shared/components/constants.dart';
import '../../../models/getFavoriteModel.dart';
import '../../../models/homeModel.dart';
import '../../../shared/network/dioHelper.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates>{
  HomeLayoutCubit() : super(InitialHomeLayoutState());
  static HomeLayoutCubit get(BuildContext context)=>BlocProvider.of(context);

  int initialIndex = 0;
  List<Widget> BottomNavScreens = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void ChangeBottomNavIndex(int index){
    initialIndex = index;
    emit(ChangeBottomNavIndexState());
  }

  Map<int,bool> inFavorites = {}; // i need to store the id for product and its in_favorite status => during getting data for Home page
  Map<int,bool> inCart = {};   // i need to store the id for product and its in_cart status => during getting data for Home page
  HomeModel? homeModel;

  // method for get Home Layout Data for Home Layout Screen
  Future<void> getHomeData() async {
    emit(LoadingHomeLayoutState());
    await DioHelper.getData
      (
        methodUrl: home,
        token: token,
      ).then((value) {
        homeModel = HomeModel.fromJson(value?.data);
        print("homeModel status is ${homeModel!.status}");
        // to store in_favorite on a Map
        homeModel!.data!.products.forEach((element) {
          inFavorites.addAll({element.id! : element.inFavorite!});
        });
        // to store in_cart on a Map
        homeModel!.data!.products.forEach((element) {
          inCart.addAll({element.id! : element.inCart!});
        });
        print("InCart are ${inCart.toString()}");
        print("InFavorite are ${inFavorites.toString()}");
      emit(GettingHomeDataSuccessfullyState());
    }).catchError((e)=>emit(HomeDataErrorState()));
  }

  CartModel? cartModel;
  Future<void> getCart() async {
    emit(CartLoadingState());
    await DioHelper.getData(
        methodUrl: "carts",
        token: token,
    ).then((items){
      cartModel = CartModel.fromJson(items!.data);
      if( cartModel!.status! )
      {
        print("total price for Cart Products is ${cartModel!.data!.total}");
      }
      emit(GetCartSuccessfullyState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorDuringGettingCartState());}
    );
  }

  ChangeCartModel? changeCartModel;
  Future<void> changeCartStatus({required int productId}) async{
    inCart[productId] = !inCart[productId]!;  // to change the status for Products that saved on this map
    emit(LoadingChangeCartState());
    await DioHelper.postData(
      methodUrl: cart,
      formData: {
        'product_id' : productId,
      },
      token: token,
    ).then((value){
      changeCartModel = ChangeCartModel.fromJson(value!.data);
      if( changeCartModel!.status == true )
      {
        getCart();
        emit(ChangeCartStateSuccessfully());
      }
    }).catchError((onError){print(onError);emit(ErrorDuringChangeCartState());});
  }

  FavoriteModel? favoriteModel;
  Future<void> getFavorites() async {
    emit(FavoriteLoadingState());
    await DioHelper.getData(
      methodUrl: 'favorites',
      token: token,
    ).then((value){
      print(value?.data);
      favoriteModel = FavoriteModel.fromJson(value!.data);
      print("Status for get Favorites is ${favoriteModel!.status}");
      print("Data that are in Favorites is ${favoriteModel!.data?.data}");
      if( favoriteModel!.status! )
      {
        print("total price for Favorite Products is ${favoriteModel!.data?.total}");
        emit(GetFavoriteSuccessfullyState());
      }
    }).catchError((e){
      print(e.toString());
      emit(ErrorDuringGettingFavoriteState());}
    );
  }

  ChangeFavoriteModel? changeFavoriteModel;
  Future<void> changeFavoriteStatus({required int productId}) async{
    inFavorites[productId] = !inFavorites[productId]!;  // to change the status for Products that saved on this map
    emit(LoadingChangeFavoriteState());
    await DioHelper.postData(
      methodUrl: "favorites",
      formData: {
        'product_id' : productId,
      },
      token: token,
    ).then((value){
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value!.data);
      if( changeFavoriteModel!.status == true )
      {
        getFavorites();
        emit(ChangeFavoriteStatus());
      }
    }).catchError((onError){print(onError);emit(ErrorDuringChangeCartState());});
  }

  CategoriesModel? categoriesModel;
  Future<void> getCategories() async {
    await DioHelper.getData(
        methodUrl: categories,
      token: token,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value?.data);
    }).catchError((e)=>print(e));
  }

  ProfileData? UserData;
  Future<void> getProfileData() async {
    await DioHelper.getData(
        methodUrl: profile,
        token : token,
    ).then((items){
      UserData = ProfileData.fromJson(items!.data);
      if( UserData!.status! )
        {
          emit(GetProfileDataSuccessfullyState());
          print("Account name is ${UserData!.data!.name}");
          print("Account email is ${UserData!.data!.email}");
        }
    }).catchError((e){emit(ErrorDuringGettingProfileDataState());print(e.toString());});
  }
  
  Future<void> updateProfile({String? name,String? email,String? password,String? phone}) async{
    emit(LoadingUpdateProfileState());
    await DioHelper.putData(
        methodUrl: "update-profile",
        formData: {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone,
          'image' : 'https://student.valuxapps.com/storage/assets/defaults/user.jpg',
        },
        token: token.toString(),
    ).then((value){
      UserData = ProfileData.fromJson(value!.data);
      // print("Updated successfully ${value.data}");
      emit(UpdateProfileSuccessfullyState());
    }).catchError((onError){emit(ErrorDuringUpdateProfile());});
  }
}