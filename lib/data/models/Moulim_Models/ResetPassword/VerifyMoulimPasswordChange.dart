import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;



class VerifyMoulimPasswordChange {
  bool status;
  String message;

  VerifyMoulimPasswordChange({this.status, this.message});

  VerifyMoulimPasswordChange.fromJson(Map<String, dynamic> json) {
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

Future<VerifyMoulimPasswordChange> verifyMoulimMobile(String mobileNo) async {
  print(mobileNo);
 
  final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.moulimDataBaseModel.token}',
  };
  
  final response = await http.get(
      'http://167.99.155.227/api/mualemVerify/$mobileNo',headers: token);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return VerifyMoulimPasswordChange.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    print(response.statusCode);
    throw Exception('Failed to load post');
  }
}