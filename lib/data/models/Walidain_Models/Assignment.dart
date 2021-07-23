
import 'dart:convert';
import 'package:Tahfizul/util/global.dart';
import 'package:http/http.dart' as http;

class WalidainAssignment {
  bool status;
  List<Data> data;

  WalidainAssignment({this.status, this.data});

  WalidainAssignment.fromJson(Map<String, dynamic> json) {
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
  int courseId;
  int typeId;
  int paraId;
  int surahId;
  int ruku;
  String name;
  String description;
  String file;
  String assignedDate;
  String deadline;
  int statusId;
  String mualemName;
  String talibilmId;
  String status;
  String submittedFile;
  String type;

  Data(
      {this.id,
      this.madarsaId,
      this.mualemId,
      this.courseId,
      this.typeId,
      this.paraId,
      this.surahId,
      this.ruku,
      this.name,
      this.description,
      this.file,
      this.assignedDate,
      this.deadline,
      this.statusId,
      this.mualemName,
      this.talibilmId,
      this.status,
      this.submittedFile,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    madarsaId = json['madarsa_id'];
    mualemId = json['mualem_id'];
    courseId = json['course_id'];
    typeId = json['type_id'];
    paraId = json['para_id'];
    surahId = json['surah_id'];
    ruku = json['ruku'];
    name = json['name'];
    description = json['description'];
    file = json['file'];
    assignedDate = json['assigned_date'];
    deadline = json['deadline'];
    statusId = json['status_id'];
    mualemName = json['mualem_name'];
    talibilmId = json['talibilm_id'];
    status = json['status'];
    submittedFile = json['submitted_file'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['madarsa_id'] = this.madarsaId;
    data['mualem_id'] = this.mualemId;
    data['course_id'] = this.courseId;
    data['type_id'] = this.typeId;
    data['para_id'] = this.paraId;
    data['surah_id'] = this.surahId;
    data['ruku'] = this.ruku;
    data['name'] = this.name;
    data['description'] = this.description;
    data['file'] = this.file;
    data['assigned_date'] = this.assignedDate;
    data['deadline'] = this.deadline;
    data['status_id'] = this.statusId;
    data['mualem_name'] = this.mualemName;
    data['talibilm_id'] = this.talibilmId;
    data['status'] = this.status;
    data['submitted_file'] = this.submittedFile;
    data['type'] = this.type;
    return data;
  }
}

Future<WalidainAssignment> fetchWalidainAssignemnt(int id) async {
  final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.walidainDatabaseModel.token}',
  };
  final response = await http.get(Uri.parse('${Global.baseurl}/api/assignment/walidain/$id'),headers: token);
      
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return WalidainAssignment.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<WalidainAssignment> fetchThalibheAssignemnt(int id) async {
  final Map<String,String> token= {
    'Authorization' : 'Bearer ${Global.thalibheDataBaseModel.token}',
  };
  final response = await http.get(Uri.parse('${Global.baseurl}/api/assignment/talibilm/$id'),headers: token);
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return WalidainAssignment.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class WalidainPendingAssignmentModel {
  int id;
  int madarsaId;
  int mualemId;
  int courseId;
  int typeId;
  int paraId;
  int surahId;
  int ruku;
  String name;
  String description;
  String file;
  String assignedDate;
  String deadline;
  int statusId;
  String mualemName;
  String talibilmId;
  String status;
  String submittedFile;
  String type;

  WalidainPendingAssignmentModel(
      {this.id,
      this.madarsaId,
      this.mualemId,
      this.courseId,
      this.typeId,
      this.paraId,
      this.surahId,
      this.ruku,
      this.name,
      this.description,
      this.file,
      this.assignedDate,
      this.deadline,
      this.statusId,
      this.mualemName,
      this.talibilmId,
      this.status,
      this.submittedFile,
      this.type});

  WalidainPendingAssignmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    madarsaId = json['madarsa_id'];
    mualemId = json['mualem_id'];
    courseId = json['course_id'];
    typeId = json['type_id'];
    paraId = json['para_id'];
    surahId = json['surah_id'];
    ruku = json['ruku'];
    name = json['name'];
    description = json['description'];
    file = json['file'];
    assignedDate = json['assigned_date'];
    deadline = json['deadline'];
    statusId = json['status_id'];
    mualemName = json['mualem_name'];
    talibilmId = json['talibilm_id'];
    status = json['status'];
    submittedFile = json['submitted_file'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['madarsa_id'] = this.madarsaId;
    data['mualem_id'] = this.mualemId;
    data['course_id'] = this.courseId;
    data['type_id'] = this.typeId;
    data['para_id'] = this.paraId;
    data['surah_id'] = this.surahId;
    data['ruku'] = this.ruku;
    data['name'] = this.name;
    data['description'] = this.description;
    data['file'] = this.file;
    data['assigned_date'] = this.assignedDate;
    data['deadline'] = this.deadline;
    data['status_id'] = this.statusId;
    data['mualem_name'] = this.mualemName;
    data['talibilm_id'] = this.talibilmId;
    data['status'] = this.status;
    data['submitted_file'] = this.submittedFile;
    data['type'] = this.type;
    return data;
  }
}