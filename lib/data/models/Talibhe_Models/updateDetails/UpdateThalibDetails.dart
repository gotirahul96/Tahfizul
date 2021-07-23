



import 'dart:convert';
import 'dart:io';

import 'package:Tahfizul/util/global.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class UpdateThalibDetails {
  bool status;
  String message;

  UpdateThalibDetails({this.status, this.message});

  UpdateThalibDetails.fromJson(Map<String, dynamic> json) {
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
Future<UpdateThalibDetails>  uploadThalibFileFromDio(String username,int id, File photoFile) async {
    var dio = new Dio();
     FormData formdata;
    dio.options.baseUrl = '${Global.baseurl}/';
    final Map<String,String> token= {
      'Content-Type': 'application/json; charset=UTF-8',
    'Authorization' : 'Bearer ${Global.thalibheDataBaseModel.token}',
  };
    dio.options.connectTimeout = 20000; //5s
    dio.options.receiveTimeout = 20000;
    //dio.options.headers = token;
   
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
 else {
   formdata = FormData.fromMap({
    'e_username' : username,
   });
 }
 print(formdata.fields);
    try {
      var response = await dio.post("api/talibilmUpdate/$id",
        data: jsonEncode(formdata),
        options: Options(
            method: 'POST',
            headers: {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader : 'Bearer ${Global.thalibheDataBaseModel.token}'
  },
            followRedirects: false,
            // will not throw errors
            validateStatus: (status) => true,
            //contentType: 'multipart/form-data',
            responseType: ResponseType.plain // or ResponseType.JSON
            ));
                     print(response.data);
    if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return UpdateThalibDetails.fromJson(json.decode(response.data));
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    print(response.statusCode);
    throw Exception('Failed to load post');
  }
    } catch (e) {

    if (e is DioError) {
    //handle DioError here by error type or by error code
         print(e);
    } 
 //return empty list (you can also return custom error to be handled by Future Builder)
}
  }