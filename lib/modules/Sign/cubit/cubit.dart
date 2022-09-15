import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/registerModel.dart';
import 'package:untitled/modules/Sign/cubit/states.dart';
import 'package:untitled/shared/local/cacheHelper.dart';
import '../../../models/loginModel.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/dioHelper.dart';

class SignCubit extends Cubit<SignStates>{
  SignCubit() : super(InitialLoginState());
  static SignCubit get(BuildContext context)=>BlocProvider.of(context);     // to get object from cubit when call it

  RegisterModel? registerData;
  // This method for post Register data
  Future<void> PostRegister({required String name,required String phone,required String email,required String password,String? image}) async {
    emit(RegisterLoadingState());
     await DioHelper.postData(
        methodUrl: register,
        formData: {
          'name' : name,
          'phone' : phone,
          'email' : email,
          'password' : password,
          'image' : image ?? '',
        }).then((value){
          emit(RegisterSuccessState());
          registerData = RegisterModel.fromJson(json: value?.data);
          // print(value?.data);
     }).catchError((e)=>emit(RegisterErrorState()));
  }


  // this method for post login data to Database
  LoginModel? loginModel;
  Future<void> UserLogin({required String email,required String password}) async {
    emit(LoginLoadingState());
    await DioHelper.postData(
        methodUrl: 'login',
        formData:
        {
          'email' : email,
          'password' : password,
        }).then((value) async {
          loginModel = LoginModel.fromJson(json: value?.data);
          if(loginModel!.status == true)
            {
              CacheHelper.SaveData(key: 'token', value: loginModel?.data?.token);
              CacheHelper.SaveData(key: 'userImage', value: loginModel?.data?.image);
              await CacheHelper.SaveData(key: 'tokenStatus', value: true);
              userImage = CacheHelper.GetData(key: 'userImage');
            }
          emit(LoginSuccessState());
    }).catchError((e)=>emit(LoginErrorState()));
  }

  // related to Icon for password
  bool passwordShown = false;
  void ChangePasswordVisiblity(){
    passwordShown = !passwordShown;
    emit(ChangePasswordShownState());
  }
}