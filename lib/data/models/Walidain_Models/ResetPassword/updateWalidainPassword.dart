import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;

class ResetWalidainPassword {
  bool status;
  String message;

  ResetWalidainPassword({this.status, this.message});

  ResetWalidainPassword.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

Future<ResetWalidainPassword> updateWalidainPassword(String username ,String password,String mobileno) async {
  
  print(password);
  print(mobileno);
  print(username);
  Map<String,String> credentials= {
    'e_username' : username,
    'newPassword': password
  };
  final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.walidainDatabaseModel.token}',
  };
  final response = await http.post(
      Uri.parse('${Global.baseurl}/api/walidainResetPass/$mobileno'),body: credentials,headers: token);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return ResetWalidainPassword.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    print(response.statusCode);
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}