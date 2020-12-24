
class WalidainDataBaseModel {
  int walidainId;
  String token;

  WalidainDataBaseModel({this.walidainId, this.token});

  WalidainDataBaseModel.fromJson(Map<String, dynamic> json) {
    walidainId = json['walidain_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['walidain_id'] = this.walidainId;
    data['token'] = this.token;
    return data;
  }
  factory WalidainDataBaseModel.fromMap(Map<String, dynamic> json) => new WalidainDataBaseModel(
    walidainId : json['walidain_id'],
    token : json['token'],
  );
   Map<String ,dynamic> toMap(){
    return {
       'walidain_id' : walidainId,
       'token' : token,
       };}
}
//  Map<String ,dynamic> toMap(){
//     return {
//        'id' : id,
//        'parent_id': parentId,
//        'name': name,
//        'username':username,
//        'password':password,
//        'madarsa_id': madarsaId,
//        'country_id': countryId,
//        'state_id' : stateId,
//        'city_id': cityId,
//        'address' : address,
//        'course_id':countryId,
//        'talib_ilm_type' : talibIlmType,
//        'talib_ilm_slot_type' : talibIlmSlotType,
//        'talib_ilm_time_slot' : talibIlmTimeSlot,
//        'assigned_mualem_id' : assignedMualemId,
//        'IsActive': isActive,
//        'created_at': createdAt,
//        'createdBy' : createdBy,
//        'updated_at' : updatedAt,
//        'updatedBy' : updatedBy
//     };
//   }