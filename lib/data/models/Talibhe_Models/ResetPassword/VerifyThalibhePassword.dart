import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;



class VerifyThalibhePasswordChange {
  bool status;
  String message;

  VerifyThalibhePasswordChange({this.status, this.message});

  VerifyThalibhePasswordChange.fromJson(Map<String, dynamic> json) {
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

Future<VerifyThalibhePasswordChange> verifyThalibheusername(String username) async {
  print(username);
 
  final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.thalibheDataBaseModel.token}',
  };
  print(token);
  print('${Global.baseurl}/api/talibilmVerify/$username');
  final response = await http.get(
      Uri.parse('${Global.baseurl}/api/talibilmVerify/$username'),headers: token);
  
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return VerifyThalibhePasswordChange.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    print(response.statusCode);
    throw Exception('Failed to load post');
  }
}