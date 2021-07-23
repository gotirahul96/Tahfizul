
import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;


class TodayClasses {
  bool status;
  List<Data> data;

  TodayClasses({this.status, this.data});

  TodayClasses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int madarsaId;
  int mualemId;
  String description;
  int status;
  String date;
  int manageTimeId;
  int timeSlotId;
  String startTime;
  String endTime;
  String slotType;

  Data(
      {this.id,
      this.madarsaId,
      this.mualemId,
      this.date,
      this.description,
      this.status,
      this.manageTimeId,
      this.timeSlotId,
      this.startTime,
      this.endTime,
      this.slotType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    madarsaId = json['madarsa_id'];
    mualemId = json['mualem_id'];
    description = json['description'];
    status = json['status'];
    date = json['date'];
    manageTimeId = json['manage_time_id'];
    timeSlotId = json['time_slot_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    slotType = json['slot_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['madarsa_id'] = this.madarsaId;
    data['mualem_id'] = this.mualemId;
    data['description'] = this.description;
    data['status'] = this.status;
    data['date'] = this.date;
    data['manage_time_id'] = this.manageTimeId;
    data['time_slot_id'] = this.timeSlotId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['slot_type'] = this.slotType;
    return data;
  }
}

Future<TodayClasses> fetchTodayClassDetails(int id) async {
 print(id);
 final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.walidainDatabaseModel.token}',
  };
  
  final response = await http.get(Uri.parse('${Global.baseurl}/api/class/$id'),
                                   headers: token,);
      
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return TodayClasses.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    print(response.statusCode);
    throw Exception('Failed to load post');
  }
}

Future<TodayClasses> fetchThalibheTodayClassDetails(int id) async {
 print(id);
 final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.thalibheDataBaseModel.token}',
  };
  print(token);
  final response = await http.get(Uri.parse('${Global.baseurl}/api/class/$id'),
                                   headers: token,);
      
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return TodayClasses.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    print(response.statusCode);
    throw Exception('Failed to load post');
  }
}