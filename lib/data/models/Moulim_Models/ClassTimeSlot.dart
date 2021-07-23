
import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;



class MoulimTimeSlots {
  bool status;
  List<MoulimTimeSlotsData> data;

  MoulimTimeSlots({this.status, this.data});

  MoulimTimeSlots.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<MoulimTimeSlotsData>();
      json['data'].forEach((v) {
        data.add(new MoulimTimeSlotsData.fromJson(v));
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

class MoulimTimeSlotsData {
  int id;
  int madarsaId;
  int talibIlmId;
  String description;
  int status;
  int manageTimeId;
  int timeSlotId;
  String date;
  String startTime;
  String endTime;
  String slotType;

  MoulimTimeSlotsData(
      {this.id,
      this.madarsaId,
      this.talibIlmId,
      this.description,
      this.status,
      this.date,
      this.manageTimeId,
      this.timeSlotId,
      this.startTime,
      this.endTime,
      this.slotType});

  MoulimTimeSlotsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    madarsaId = json['madarsa_id'];
    talibIlmId = json['talib_ilm_id'];
    description = json['description'];
    date = json['date'];
    status = json['status'];
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
    data['talib_ilm_id'] = this.talibIlmId;
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
Future<MoulimTimeSlots> fetchMoulimTodayClassDetails(int id) async {
 print(id);
 final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.moulimDataBaseModel.token}',
  };
  
  final response = await http.get(Uri.parse('${Global.baseurl}/api/mualemclass/$id'),
                                   headers: token,);
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return MoulimTimeSlots.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    print(response.statusCode);
    throw Exception('Failed to load post');
  }
}