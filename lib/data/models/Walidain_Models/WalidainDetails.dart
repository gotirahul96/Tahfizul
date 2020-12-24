
import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;

class WalidainDetails {
  bool status;
  Data data;

  WalidainDetails({this.status, this.data});

  WalidainDetails.fromJson(Map<String, dynamic> json) {
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
  int numberOfstudents;
  List<int> studentsIds;

  Data(
      {this.name,
      this.mobile,
      this.image,
      this.madarsaId,
      this.email,
      this.address,
      this.numberOfstudents,
      this.studentsIds});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    image = json['image'];
    madarsaId = json['madarsa_id'];
    email = json['email'];
    address = json['address'];
    numberOfstudents = json['numberOfstudents'];
    studentsIds = json['studentsIds'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['madarsa_id'] = this.madarsaId;
    data['email'] = this.email;
    data['address'] = this.address;
    data['numberOfstudents'] = this.numberOfstudents;
    data['studentsIds'] = this.studentsIds;
    return data;
  }
}

Future<WalidainDetails> fetchWalidainDetails(int id) async {
 print(id);
 final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.walidainDatabaseModel.token}',
  };
  
  final response = await http.get('http://167.99.155.227/api/walidain/$id',
                                   headers: token,);
      
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return WalidainDetails.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    print(response.statusCode);
    throw Exception('Failed to load post');
  }
}