import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;

class ResetMoulimPassword {
  bool status;
  String message;

  ResetMoulimPassword({this.status, this.message});

  ResetMoulimPassword.fromJson(Map<String, dynamic> json) {
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

Future<ResetMoulimPassword> updateMoulimPassword(String username ,String mobileNo,String password) async {
  print(mobileNo);
  print(password);
  Map<String,String> credentials= {
    'e_username' : username,
    'mobile' : mobileNo,
    'newPassword': password
  };
  final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.moulimDataBaseModel.token}',
  };
  final response = await http.post(
      Uri.parse('${Global.baseurl}/api/mualemResetPass'),body: credentials,headers: token);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return ResetMoulimPassword.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}