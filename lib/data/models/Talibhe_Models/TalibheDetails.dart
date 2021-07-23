import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;
class ThalibheDetails {
  bool status;
  Data data;

  ThalibheDetails({this.status, this.data});

  ThalibheDetails.fromJson(Map<String, dynamic> json) {
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
  String username;
  String image;
  int madarsaId;
  String email;
  String address;

  Data(
      {this.name,
      this.username,
      this.image,
      this.madarsaId,
      this.email,
      this.address});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    image = json['image'] != null ? json['image'] : '';
    madarsaId = json['madarsa_id'];
    email = json['email'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['image'] = this.image;
    data['madarsa_id'] = this.madarsaId;
    data['email'] = this.email;
    data['address'] = this.address;
    return data;
  }
}

Future<ThalibheDetails> fetchthalibheDetails(int id) async {
  final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.thalibheDataBaseModel.token}',
  };
  final response = await http.get(Uri.parse('${Global.baseurl}/api/talibilm/$id'),headers: token);
      
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return ThalibheDetails.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}