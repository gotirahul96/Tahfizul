import 'dart:convert';
import 'package:http/http.dart' as http;

class ThalibLoginModel {
  bool status;
  String message;
  Data data;

  ThalibLoginModel({this.status, this.message, this.data});

  ThalibLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int talibIlmId;
  String token;

  Data({this.talibIlmId, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    talibIlmId = json['talib_ilm_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['talib_ilm_id'] = this.talibIlmId;
    data['token'] = this.token;
    return data;
  }
}
Future<ThalibLoginModel> fetchThalibLoginCredentials(String userName,String password) async {
  print(userName);
  print(password);
  Map<String,String> credentials= {
    'username' : userName,
    'password': password
  };
  final response = await http.post('http://167.99.155.227/api/talibilmlogin',
                                   body: credentials);
      
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return ThalibLoginModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}