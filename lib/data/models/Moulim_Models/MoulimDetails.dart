import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;

class MoulimDetailsModel {
  bool status;
  Data data;

  MoulimDetailsModel({this.status, this.data});

  MoulimDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  String mobile;
  String image;
  int madarsaId;
  String email;
  String address;
  String about;
  int assignedNumberOfstudents;
  List<int> assignedStudentsIds;
  double rating;
  String madarsaName;

  Data(
      {this.name,
      this.mobile,
      this.image,
      this.madarsaId,
      this.email,
      this.address,
      this.about,
      this.assignedNumberOfstudents,
      this.assignedStudentsIds,
      this.rating,
      this.madarsaName});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    image = json['image'];
    madarsaId = json['madarsa_id'];
    email = json['email'];
    address = json['address'];
    about = json['about'];
    assignedNumberOfstudents = json['assignedNumberOfstudents'];
    assignedStudentsIds = json['assignedStudentsIds'].cast<int>();
    rating = json['rating'];
    madarsaName = json['madarsa_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['madarsa_id'] = this.madarsaId;
    data['email'] = this.email;
    data['address'] = this.address;
    data['about'] = this.about;
    data['assignedNumberOfstudents'] = this.assignedNumberOfstudents;
    data['assignedStudentsIds'] = this.assignedStudentsIds;
    data['rating'] = this.rating;
    data['madarsa_name'] = this.madarsaName;
    return data;
  }
}

Future<MoulimDetailsModel> fetchMoulimDetails(int id) async {
  final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.moulimDataBaseModel.token}',
  };
  final response = await http.get('http://167.99.155.227/api/mualem/$id',headers: token);
      
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return MoulimDetailsModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}