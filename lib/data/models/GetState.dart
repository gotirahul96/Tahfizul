import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;
class GetStateModel {
  bool status;
  Data data;

  GetStateModel({this.status, this.data});

  GetStateModel.fromJson(Map<String, dynamic> json) {
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
  int countryId;
  String stateName;
  String createdAt;
  String createdBy;
  String updatedAt;
  String updatedBy;
  int isActive;

  Data(
      {this.id,
      this.countryId,
      this.stateName,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    stateName = json['state_name'];
    createdAt = json['created_at'];
    createdBy = json['createdBy'];
    updatedAt = json['updated_at'];
    updatedBy = json['updatedBy'];
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['state_name'] = this.stateName;
    data['created_at'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    data['IsActive'] = this.isActive;
    return data;
  }
}
Future<GetStateModel> getStateName(int stateId) async {
  
  final response = await http.get(Uri.parse('${Global.baseurl}/master_management/state/$stateId'));
      
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return GetStateModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
