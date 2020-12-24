import 'dart:convert';
import 'package:Tahfizul/services/MoulimDataBaseModel.dart';
import 'package:Tahfizul/services/ThalibheDataBaseModel.dart';
import 'package:Tahfizul/services/WalidainDataBaseModel.dart';
import 'package:Tahfizul/util/global.dart';


class AuthProvider {

  WalidainDataBaseModel _walidainLogedIn;
  MoulimDataBaseModel _moulimDataBaseModel;
  ThalibheDataBaseModel _thalibLoginModel;
  //Delete Sp 
  Future deleteUserType ({String key = 'userType'}){
     return Global.prefs.setString(key, null);
  }
  Future deletewalidainData ({String key = 'walidain'}){
    return Global.prefs.setString(key, null);
  }
  Future deletemoulimData ({String key = 'moulim'}){
    return Global.prefs.setString(key, null);
  }
  Future deletethalibheData ({String key = 'thalibhe'}){
    return Global.prefs.setString(key, null);
  }
  //Set data
  Future setuserType({String key = 'userType',String value}){
   return Global.prefs.setString(key, value);
  }
  Future setWalidainData ({String key = 'walidain' , WalidainDataBaseModel user}){
    if (user!=null) {
      this._walidainLogedIn = user;
      String userJson = json.encode(_walidainLogedIn.toJson());
      
      setuserType(value: 'walidain');
      return Global.prefs.setString(key, userJson);
    }
    return Global.prefs.setString(key, null);
  }
  Future setMoulimData ({String key = 'moulim' , MoulimDataBaseModel user}){
    if (user!=null) {
      this._moulimDataBaseModel = user;
      String userJson = json.encode(_moulimDataBaseModel.toJson());
      setuserType(value: 'moulim');
      return Global.prefs.setString(key, userJson);
    }
    return Global.prefs.setString(key, null);
  }
   Future setThalibheData ({String key = 'thalibhe' , ThalibheDataBaseModel user}){
    if (user!=null) {
      this._thalibLoginModel = user;
      String userJson = json.encode(_thalibLoginModel.toJson());
       setuserType(value: 'thalibhe');
      return Global.prefs.setString(key, userJson);
    }
    return Global.prefs.setString(key, null);
  }
  //Get Data
  String getUserType({String key = 'userType'}){
    print(Global.prefs.getString(key));
    if (Global.prefs.getString(key) != null) {
      return Global.prefs.getString(key);
    }
    return null;
  }
  WalidainDataBaseModel getWalidainData ({String key = 'walidain'}){
    String userJson = Global.prefs.getString(key);
    if (userJson != null) {
      Map userObj = json.decode(userJson);
      _walidainLogedIn = WalidainDataBaseModel.fromJson(userObj);
      
      return _walidainLogedIn;
    }
    return null;
  }
  MoulimDataBaseModel getmoulimData ({String key = 'moulim'}){
    String userJson = Global.prefs.getString(key);
    if (userJson != null) {
      Map userObj = json.decode(userJson);
      _moulimDataBaseModel = MoulimDataBaseModel.fromJson(userObj);
      return _moulimDataBaseModel;
    }
    return null;
  }
   ThalibheDataBaseModel getThalibheData ({String key = 'thalibhe'}){
    String userJson = Global.prefs.getString(key);
    if (userJson != null) {
      Map userObj = json.decode(userJson);
      _thalibLoginModel = ThalibheDataBaseModel.fromJson(userObj);
      return _thalibLoginModel;
    }
    return null;
  } 
  
}