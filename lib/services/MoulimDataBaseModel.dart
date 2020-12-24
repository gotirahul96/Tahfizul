class MoulimDataBaseModel {
  int mualemId;
  String token;

  MoulimDataBaseModel({this.mualemId, this.token});

  MoulimDataBaseModel.fromJson(Map<String, dynamic> json) {
    mualemId = json['mualem_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mualem_id'] = this.mualemId;
    data['token'] = this.token;
    return data;
  }
  factory MoulimDataBaseModel.fromMap(Map<String, dynamic> json) => new MoulimDataBaseModel(
    mualemId : json['mualem_id'],
    token : json['token'],
  );
   Map<String ,dynamic> toMap(){
    return {
       'mualem_id' : mualemId,
       'token' : token,
       };}
}
