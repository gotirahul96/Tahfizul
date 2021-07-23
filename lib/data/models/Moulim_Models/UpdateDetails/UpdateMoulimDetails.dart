import 'dart:convert';
import 'dart:io';
import 'package:Tahfizul/util/global.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class UpdateMoulimDetails {
  bool status;
  String message;

  UpdateMoulimDetails({this.status, this.message});

  UpdateMoulimDetails.fromJson(Map<String, dynamic> json) {
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
Future<UpdateMoulimDetails>  uploadmoulimFileFromDio(String username,int id, File photoFile) async {
    var dio = new Dio();
     FormData formdata;
    dio.options.baseUrl = '${Global.baseurl}/';
    final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.moulimDataBaseModel.token}',
  };
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    dio.options.headers = token;
   
    if (photoFile != null &&
        photoFile.path != null &&
        photoFile.path.isNotEmpty) {
      // Create a FormData
      String fileName = basename(photoFile.path);
      print("File Name : $fileName");
      print("File Size : ${photoFile.lengthSync()}");
   formdata = FormData.fromMap({
    'e_username' : username,
      "image": await MultipartFile.fromFile(
        photoFile.path,
        filename: fileName,
      ),
   });
 }
    var response = await dio.post("api/mualemUpdate/$id",
        data: formdata,
        options: Options(
            method: 'POST',
            responseType: ResponseType.plain // or ResponseType.JSON
            ));
    if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return UpdateMoulimDetails.fromJson(json.decode(response.data));
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    print(response.statusCode);
    throw Exception('Failed to load post');
  }
  }