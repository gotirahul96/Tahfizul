import 'dart:io';
import 'dart:async';
import 'package:Tahfizul/services/MoulimDataBaseModel.dart';
import 'package:Tahfizul/services/ThalibheDataBaseModel.dart';
import 'package:Tahfizul/services/WalidainDataBaseModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class WalidainUserCredentialDataBase{
  WalidainUserCredentialDataBase._();

  static final WalidainUserCredentialDataBase db = WalidainUserCredentialDataBase._();
  Database _database;
  ////Get database path for walidain
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  } 
  ////Get database path for Moulim
  Future<Database> get moulimdatabase async {
    if (_database != null) return _database;
    _database = await getMoulimDatabaseInstance();
    return _database;
  }
  ////Get database path for Moulim
  Future<Database> get thalibhedatabase async {
    if (_database != null) return _database;
    _database = await getThalibheDatabaseInstance();
    return _database;
  }
  //Open database Thalibhe
  Future <Database> getThalibheDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print('Thalibhe DataBaseCreated');
    String path = join(directory.path, "ThalibheDetails.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      
      await db.execute(
        "CREATE TABLE ThalibeData (id INTEGER ,parent_id INTEGER ,name TEXT,username TEXT  ,password TEXT ,madarsa_id INTEGER,country_id INTEGER ,state_id INTEGER ,city_id INTEGER ,address TEXT ,course_id INTEGER ,talib_ilm_type INTEGER ,talib_ilm_slot_type INTEGER, talib_ilm_time_slot INTEGER, assigned_mualem_id INTEGER ,IsActive INTEGER,created_at TEXT ,createdBy TEXT ,updated_at TEXT ,updatedBy TEXT )"
      );
    });
  }
   //Open databaase moulim
  Future<Database> getMoulimDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print('Mouslim DataBaseCreated');
    String path = join(directory.path, "moulimDetails.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      
      await db.execute(
        "CREATE TABLE MoulimData (id INTEGER ,madarsa_id INTEGER ,name TEXT ,email TEXT ,mobile TEXT ,country_id INTEGER ,state_id INTEGER ,city_id INTEGER ,address TEXT ,slot_type_id INTEGER ,strength_id INTEGER ,time_slot_id INTEGER ,password TEXT ,created_at TEXT ,createdBy TEXT ,updated_at TEXT ,updatedBy TEXT ,IsActive INTEGER)"
      );
    });
  }

  //Open databaase walidain
  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print('DataBaseCreated');
    String path = join(directory.path, "talibWalidDetails.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE UserData (id INTEGER , name TEXT, username TEXT, password TEXT , madarsa_id INTEGER , talib_ilm_id INTEGER , designation TEXT,email TEXT,mobile TEXT,address TEXT,country_id INTEGER,state_id INTEGER,city_id INTEGER,created_at TEXT,createrBy TEXT,updated_at TEXT,updatedBy TEXT,IsActive INTEGER)",
      );
      
    });
  }
  deleteDataFromWalidenDb() async {
    final Database db = await database;
    await db.execute("Delete from" + 'UserData');
  }
  deleteDataFromMoulimDb() async {
    final Database db = await moulimdatabase;
    await db.execute("Delete from" + 'Moulimdata');
  }
  deleteDataFromThalibDb() async {
    final Database db = await moulimdatabase;
    await db.execute("Delete from" + 'ThalibeData');
  }
  ///InserData in Thalibhe
  insertThalibheData(ThalibheDataBaseModel usercredentials) async {
    final Database db = await database;
   var res = await db.insert(
      "ThalibeData",
      usercredentials.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }
  ///InserData in walidDb
  insertUserData(WalidainDataBaseModel usercredentials) async {
    final Database db = await database;
   var res = await db.insert(
      "UserData",
      usercredentials.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }
  ///InserData in MoulimDb
  insertMoulimData(MoulimDataBaseModel usercredentials) async {
    final Database db = await moulimdatabase;
   var res = await db.insert(
      "Moulimdata",
      usercredentials.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }
  ///Retrive from ThalibDb
  Future<List<ThalibheDataBaseModel>> getThalibDetail() async {
    final db = await database;
    var response = await db.query("ThalibeData");
    List<ThalibheDataBaseModel> list = 
    response.isNotEmpty ? response.map((c) => ThalibheDataBaseModel.fromMap(c)).toList() : [];
    return list;
  }
  ///Retrive from WalidDb
  Future<List<WalidainDataBaseModel>> getAllDetail() async {
    final db = await database;
    var response = await db.query("UserData");
    List<WalidainDataBaseModel> list = 
    response.isNotEmpty ? response.map((c) => WalidainDataBaseModel.fromMap(c)).toList() : [];
    return list;
  } 
  //Retrive from maoulimdb 
  Future<List<MoulimDataBaseModel>> getMoulimDetail() async {
    final db = await moulimdatabase;
    var response = await db.query("Moulimdata");
    List<MoulimDataBaseModel> list = 
    response.isNotEmpty ? response.map((c) => MoulimDataBaseModel.fromMap(c)).toList() : [];
    return list;
  } 
  closeDb() async {
    final db = await database;
    return db.close();
  }
  closeMoulimDb() async {
    final db = await moulimdatabase;
    return db.close();
  }
  
}