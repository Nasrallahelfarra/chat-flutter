

import 'dart:convert';

import 'package:flutter_app_chat/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
   static final String USER = "user";


   static PreferenceUtils sharedPreference = null;
   static SharedPreferences sharedPreferences;
   static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
   static SharedPreferences _prefsInstance;

   // call this method from iniState() function of mainApp().
   static Future<SharedPreferences> init() async {
     _prefsInstance = await _instance;
     return _prefsInstance;
   }

   static Future<void> setUser( User value) async {
     var prefs = await _instance;
     var json = jsonEncode(value.toJson());
     prefs.setString(USER, json);
   }
   static User getUser (){
     if(_prefsInstance.getString(USER)==null){
       return null;
     }else{
       return User.fromJson(jsonDecode(_prefsInstance.getString(USER)));

     }
   }

}