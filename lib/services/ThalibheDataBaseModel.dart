

class ThalibheDataBaseModel {
  int talibIlmId;
  String token;

  ThalibheDataBaseModel({this.talibIlmId, this.token});

  ThalibheDataBaseModel.fromJson(Map<String, dynamic> json) {
    talibIlmId = json['talib_ilm_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['talib_ilm_id'] = this.talibIlmId;
    data['token'] = this.token;
    return data;
  }
  factory ThalibheDataBaseModel.fromMap(Map<String, dynamic> json) => new ThalibheDataBaseModel(
    talibIlmId : json['talib_ilm_id'],
    token : json['token'],
  );
   Map<String ,dynamic> toMap(){
    return {
       'talib_ilm_id' : talibIlmId,
       'token' : token,
       };}
}