import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedpref;
  static CacheInit() async{
    sharedpref = await SharedPreferences.getInstance();
  }
  // this method for saving any data with any dataType , bool for return to make sure that operation done
  static Future<bool?> SaveData({required String key,required dynamic value}) async{
    if( value is int )
    {
      return await sharedpref?.setInt(key, value);
    }
    else if( value is String )
    {
      return await sharedpref?.setString(key, value);
    }
    else if( value is bool )
    {
      return await sharedpref?.setBool(key, value);
    }
    else
    {
      return await sharedpref?.setDouble(key, value);
    }
  }

  // this method for getting data from shared-pref for any dataType
  static dynamic GetData({String? key}){
    return sharedpref?.get(key!);
  }

  static Future<bool?>? DeleteItem({required String key}) async {
    return await sharedpref?.remove(key);
  }

}