import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String userData = "userData";
SharedPreferences? pref;

void saveUserData(data)async{
  pref = await SharedPreferences.getInstance();
  pref!.setString(userData, jsonEncode(data));
}

Future<Map?> getUserData()async{
  pref = await SharedPreferences.getInstance();
  String data = pref!.getString(userData)!;
  if(data.isEmpty){
    return null;
  }
  return jsonDecode(data);
}

void removeUserData()async{
  pref = await SharedPreferences.getInstance();
  pref!.setString(userData, "");
}
