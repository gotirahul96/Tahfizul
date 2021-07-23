import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;

class MoulimLoginModel {
  bool status;
  String message;
  Data data;

  MoulimLoginModel({this.status, this.message, this.data});

  MoulimLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int mualemId;
  String token;

  Data({this.mualemId, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    mualemId = json['mualem_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mualem_id'] = this.mualemId;
    data['token'] = this.token;
    return data;
  }
}
Future<MoulimLoginModel> fetchmoulimLoginCredentials(String mobileNo,String password) async {
  print(mobileNo);
  print(password);
  
  // Map<String,String> header = {
  //   'Content-Type': 'application/json; charset=UTF-8',
  // };
  Map<String,String> credentials= {
    'mobile' : mobileNo,
    'password': password
  };
  final response = await http.post(
      Uri.parse('${Global.baseurl}/api/mualemlogin'),body: json.encode(credentials));
  print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    

    return MoulimLoginModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}