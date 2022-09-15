import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class DioHelper{
  static Dio? dio;
  static InitDio(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?> getData({required String methodUrl,Map<String,dynamic>? query,String lang = 'en',String? token}) async {
    // as some times i should sent token with method url
    dio?.options.headers =
    {
      'lang' : lang,
      'Content-Type' : 'application/json',
      'Authorization' : token,
    };
    return await dio?.get(
      methodUrl,
      queryParameters: query,
    );
  }

  static Future<Response?> postData({
    required String methodUrl,Map<String,dynamic>? query,required Map<String,dynamic> formData,String lang = 'en',String? token}) async {
    dio?.options.headers =
    {
      'lang' : lang,
      'Content-Type' : 'application/json',
      'Authorization' : token,
    };
    return await dio?.post(
      methodUrl,
      queryParameters: query,
      data: formData,
    );
  }

  static Future<Response?> putData({required String methodUrl,required Map<String,dynamic> formData,lang = 'en',required String token}) async {
    dio?.options.headers =
    {
      'lang' : lang,
      'Content-Type' : 'application/json',
      'Authorization' : token,
    };
    return dio?.put(
      methodUrl,
      data: formData,
    );
  }
}