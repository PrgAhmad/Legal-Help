import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PersonData{
  String _personData = "personData";
  SharedPreferences? _pref;
  String _isLawyerState = "isLawyerState";

  void setIsLawyer(boolean)async{
    _pref = await SharedPreferences.getInstance();
    await _pref!.setBool(_isLawyerState, boolean);
  }

  Future<bool> getIsLawyer()async{
    _pref = await SharedPreferences.getInstance();
    bool isLawyer = await _pref!.getBool(_isLawyerState) ?? false;
    return isLawyer;
  }

  void savePersonData(data)async{
    _pref = await SharedPreferences.getInstance();
    await _pref!.setString(_personData, jsonEncode(data));
  }

  Future<Map?> getPersonData()async{
    _pref = await SharedPreferences.getInstance();
    String data = await _pref!.getString(_personData) ?? "";
    if(data.isEmpty){
      return null;
    }
    return jsonDecode(data);
  }

  void removePersonData() async{
    _pref = await SharedPreferences.getInstance();
    await _pref!.setString(_personData, "");
  }

}