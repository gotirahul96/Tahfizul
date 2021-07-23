import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;

class MadarsaDetails {
  bool status;
  Data data;

  MadarsaDetails({this.status, this.data});

  MadarsaDetails.fromJson(Map<String, dynamic> json) {
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
  String name;
  int countryId;
  int stateId;
  int cityId;
  String address;
  String email;
  String phone;
  String password;
  String createdAt;
  String createdBy;
  String updatedAt;
  String updatedBy;
  int isActive;

  Data(
      {this.id,
      this.name,
      this.countryId,
      this.stateId,
      this.cityId,
      this.address,
      this.email,
      this.phone,
      this.password,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    createdAt = json['created_at'];
    createdBy = json['createdBy'];
    updatedAt = json['updated_at'];
    updatedBy = json['updatedBy'];
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    data['IsActive'] = this.isActive;
    return data;
  }
}

Future<MadarsaDetails> madarsaDetails(int id) async {
  
  final response = await http.get(Uri.parse('${Global.baseurl}/madarsa_management/madarsa/$id'));
      
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return MadarsaDetails.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}