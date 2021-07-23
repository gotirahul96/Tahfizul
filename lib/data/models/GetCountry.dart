import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;

class GetCountryModel {
  bool status;
  Data data;

  GetCountryModel({this.status, this.data});

  GetCountryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String cName;
  String createdAt;
  String createdBy;
  String updatedAt;
  String updatedBy;
  int isActive;

  Data(
      {this.id,
      this.cName,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cName = json['c_name'];
    createdAt = json['created_at'];
    createdBy = json['createdBy'];
    updatedAt = json['updated_at'];
    updatedBy = json['updatedBy'];
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['c_name'] = this.cName;
    data['created_at'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    data['IsActive'] = this.isActive;
    return data;
  }
}
Future<GetCountryModel> getCountryName(int countryId) async {
  
  final response = await http.get(Uri.parse('${Global.baseurl}/master_management/country/$countryId'));
      
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return GetCountryModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}