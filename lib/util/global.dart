import 'package:Tahfizul/data/models/Moulim_Models/ClassRecords.dart';
import 'package:Tahfizul/data/models/Moulim_Models/ClassTimeSlot.dart';
import 'package:Tahfizul/data/models/Moulim_Models/MoulimDetails.dart';
import 'package:Tahfizul/data/models/Moulim_Models/PendingAssignments.dart';
import 'package:Tahfizul/data/models/Moulim_Models/TalibDetails.dart';
import 'package:Tahfizul/data/models/Talibhe_Models/ClassSlot.dart';
import 'package:Tahfizul/data/models/Talibhe_Models/TalibheClassRecords.dart';
import 'package:Tahfizul/data/models/Talibhe_Models/TalibheDetails.dart';
import 'package:Tahfizul/data/models/Talibhe_Models/TalibhePendingModel.dart';
import 'package:Tahfizul/data/models/Walidain_Models/WalidainClassRecords.dart';
import 'package:Tahfizul/data/models/Walidain_Models/WalidainDetails.dart';
import 'package:Tahfizul/services/MoulimDataBaseModel.dart';
import 'package:Tahfizul/services/ThalibheDataBaseModel.dart';
import 'package:Tahfizul/services/WalidainDataBaseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static String baseurl = 'https://www.tahfizulquranonline.com';
  static bool isLoading = false;
  static String token = '';
  static bool walidainLoginSave = false;
  static bool thalibheLoginSave = false;
  static bool moulimLoginSave = false;
  static int selectedIndex = 0;
  static SharedPreferences prefs;
  static WalidainDataBaseModel walidainDatabaseModel;
  static MoulimDataBaseModel moulimDataBaseModel ;
  static ThalibheDataBaseModel thalibheDataBaseModel;
  static WalidainDetails globalWalidainDetails;
  static ThalibheDetails globalThalibheDetails;
  static MoulimDetailsModel globalMoulimDetails;
  static List<WalidainClassRecords> walidainclassRecords = [
    WalidainClassRecords(
      noOfClasses: 10,
      assignedClass: 'Para 1,Ruku 3',
      name: 'SALEEM',
      classNo : 4,
      assignedTopic: 'PARA - 1'
    ),
    WalidainClassRecords(
      noOfClasses: 10,
      assignedClass: 'Para 1,Ruku 3',
      name: 'SALEEM',
      classNo : 4,
      assignedTopic: 'PARA - 1'
    ),
    WalidainClassRecords(
      noOfClasses: 10,
      assignedClass: 'Para 1,Ruku 3',
      name: 'SALEEM',
      classNo : 4,
      assignedTopic: 'PARA - 1'
    ),
    WalidainClassRecords(
      noOfClasses: 10,
      assignedClass: 'Para 1,Ruku 3',
      name: 'SALEEM',
      classNo : 4,
      assignedTopic: 'PARA - 1'
    ),

    WalidainClassRecords(
      noOfClasses: 10,
      assignedClass: 'Para 1,Ruku 3',
      name: 'SALEEM',
      classNo : 4,
      assignedTopic: 'PARA - 1'
    ),
    WalidainClassRecords(
      noOfClasses: 10,
      assignedClass: 'Para 1,Ruku 3',
      name: 'SALEEM',
      classNo : 4,
      assignedTopic: 'PARA - 1'
    ),
    WalidainClassRecords(
      noOfClasses: 10,
      assignedClass: 'Para 1,Ruku 3',
      name: 'SALEEM',
      classNo : 4,
      assignedTopic: 'PARA - 1'
    ),
    WalidainClassRecords(
      noOfClasses: 10,
      assignedClass: 'Para 1,Ruku 3',
      name: 'SALEEM',
      classNo : 4,
      assignedTopic: 'PARA - 1'
    ),
    WalidainClassRecords(
      noOfClasses: 10,
      assignedClass: 'Para 1,Ruku 3',
      name: 'SALEEM',
      classNo : 4,
      assignedTopic: 'PARA - 1'
    ),
    WalidainClassRecords(
      noOfClasses: 10,
      assignedClass: 'Para 1,Ruku 3',
      name: 'SALEEM',
      classNo : 4,
      assignedTopic: 'PARA - 1'
    ),
  ];
  static List<TalibheClassRecords> talivheClassrecords = [
    TalibheClassRecords(
      classNo: '1',
      assignmentNo: 'Para-1,Ruku-2'
    ),
    TalibheClassRecords(
      classNo: '1',
      assignmentNo: 'Para-1,Ruku-2'
    ),
    TalibheClassRecords(
      classNo: '1',
      assignmentNo: 'Para-1,Ruku-2'
    ),
    TalibheClassRecords(
      classNo: '1',
      assignmentNo: 'Para-1,Ruku-2'
    ),
    TalibheClassRecords(
      classNo: '1',
      assignmentNo: 'Para-1,Ruku-2'
    ),
    
  ];
  static List<TalibhePendingModel> talibheCompleted = [
    TalibhePendingModel(
      classNo: '4',
      assignmentTopic: 'PARA-1',
      slotNo: '1',
      assignemntDetails: 'Para No - 1,Ruku 2',
      status: 'Completed',
      moulimName: 'Abdul Gaffar',
      assignDate: '20-8-2020',
      assignmentType: 'Weekly',
      aboutAssignment : 'ahjshdjsdhjshdsjdhsjdhsjdhjshdjshdjshdjshdjshdjshdjshdjshdjshd'
    ),
    TalibhePendingModel(
      classNo: '4',
      assignmentTopic: 'PARA-1',
      slotNo: '1',
      assignemntDetails: 'Para No - 1,Ruku 2',
      status: 'Completed',
      moulimName: 'Abdul Gaffar',
      assignDate: '20-8-2020',
      assignmentType: 'Weekly',
      aboutAssignment : 'ahjshdjsdhjshdsjdhsjdhsjdhjshdjshdjshdjshdjshdjshdjshdjshdjshd'
    ),
    TalibhePendingModel(
      classNo: '4',
      assignmentTopic: 'PARA-1',
      slotNo: '1',
      assignemntDetails: 'Para No - 1,Ruku 2',
      status: 'Completed',
      moulimName: 'Abdul Gaffar',
      assignDate: '20-8-2020',
      assignmentType: 'Weekly',
      aboutAssignment : 'ahjshdjsdhjshdsjdhsjdhsjdhjshdjshdjshdjshdjshdjshdjshdjshdjshd'
    ),
    TalibhePendingModel(
      classNo: '4',
      assignmentTopic: 'PARA-1',
      slotNo: '1',
      assignemntDetails: 'Para No - 1,Ruku 2',
      status: 'Completed',
      moulimName: 'Abdul Gaffar',
      assignDate: '20-8-2020',
      assignmentType: 'Weekly',
      aboutAssignment : 'ahjshdjsdhjshdsjdhsjdhsjdhjshdjshdjshdjshdjshdjshdjshdjshdjshd'
    ),
    TalibhePendingModel(
      classNo: '4',
      assignmentTopic: 'PARA-1',
      slotNo: '1',
      assignemntDetails: 'Para No - 1,Ruku 2',
      status: 'Completed',
      moulimName: 'Abdul Gaffar',
      assignDate: '20-8-2020',
      assignmentType: 'Weekly',
      aboutAssignment : 'ahjshdjsdhjshdsjdhsjdhsjdhjshdjshdjshdjshdjshdjshdjshdjshdjshd'
    ),
    TalibhePendingModel(
      classNo: '4',
      assignmentTopic: 'PARA-1',
      slotNo: '1',
      assignemntDetails: 'Para No - 1,Ruku 2',
      status: 'Completed',
      moulimName: 'Abdul Gaffar',
      assignDate: '20-8-2020',
      assignmentType: 'Weekly',
      aboutAssignment : 'ahjshdjsdhjshdsjdhsjdhsjdhjshdjshdjshdjshdjshdjshdjshdjshdjshd'
    ),
  ];
  static List<TalibhePendingModel> talibhePending = [
    TalibhePendingModel(
      classNo: '4',
      assignmentTopic: 'PARA-1',
      slotNo: '1',
      assignemntDetails: 'Para No - 1,Ruku 2',
      status: 'Pending',
      moulimName: 'Abdul Gaffar',
      assignDate: '20-8-2020',
      assignmentType: 'Weekly',
      aboutAssignment : 'ahjshdjsdhjshdsjdhsjdhsjdhjshdjshdjshdjshdjshdjshdjshdjshdjshd'
    ),
    TalibhePendingModel(
      classNo: '4',
      assignmentTopic: 'PARA-1',
      slotNo: '1',
      assignemntDetails: 'Para No - 1,Ruku 2',
      status: 'Pending',
      moulimName: 'Abdul Gaffar',
      assignDate: '20-8-2020',
      assignmentType: 'Weekly',
      aboutAssignment : 'ahjshdjsdhjshdsjdhsjdhsjdhjshdjshdjshdjshdjshdjshdjshdjshdjshd'
    ),
    TalibhePendingModel(
      classNo: '4',
      assignmentTopic: 'PARA-1',
      slotNo: '1',
      assignemntDetails: 'Para No - 1,Ruku 2',
      status: 'Pending',
      moulimName: 'Abdul Gaffar',
      assignDate: '20-8-2020',
      assignmentType: 'Weekly',
      aboutAssignment : 'ahjshdjsdhjshdsjdhsjdhsjdhjshdjshdjshdjshdjshdjshdjshdjshdjshd'
    ),
    TalibhePendingModel(
      classNo: '4',
      assignmentTopic: 'PARA-1',
      slotNo: '1',
      assignemntDetails: 'Para No - 1,Ruku 2',
      status: 'Pending',
      moulimName: 'Abdul Gaffar',
      assignDate: '20-8-2020',
      assignmentType: 'Weekly',
      aboutAssignment : 'ahjshdjsdhjshdsjdhsjdhsjdhjshdjshdjshdjshdjshdjshdjshdjshdjshd'
    ),
    TalibhePendingModel(
      classNo: '4',
      assignmentTopic: 'PARA-1',
      slotNo: '1',
      assignemntDetails: 'Para No - 1,Ruku 2',
      status: 'Pending',
      moulimName: 'Abdul Gaffar',
      assignDate: '20-8-2020',
      assignmentType: 'Weekly',
      aboutAssignment : 'ahjshdjsdhjshdsjdhsjdhsjdhjshdjshdjshdjshdjshdjshdjshdjshdjshd'
    ),
  ];
  static List<TalibheTimeSlots>  talibleTimeSlot = [
    TalibheTimeSlots(
      slotName: '1',
      slotTo: '9:00',
      slotfrom: '9:30'
    ),
    TalibheTimeSlots(
      slotName: '2',
      slotTo: '9:45',
      slotfrom: '10:15'
    ),
  ];
  static List<ClassRecords> classRecords = [
    ClassRecords(
      slotNo: 1,
      slotFrom: '9:00',
      slotTo: '9:30',
      name: 'SALEEM',
      noOfClasses: '10',
      assignedClass: 'Para 1,Ruku 3'
    ),
     ClassRecords(
      slotNo: 1,
      slotFrom: '9:00',
      slotTo: '9:30',
      name: 'SALEEM',
      noOfClasses: '10',
      assignedClass: 'Para 1,Ruku 3'
    ),
     ClassRecords(
      slotNo: 1,
      slotFrom: '9:00',
      slotTo: '9:30',
      name: 'SALEEM',
      noOfClasses: '10',
      assignedClass: 'Para 1,Ruku 3'
    ),
     ClassRecords(
      slotNo: 1,
      slotFrom: '9:00',
      slotTo: '9:30',
      name: 'SALEEM',
      noOfClasses: '10',
      assignedClass: 'Para 1,Ruku 3'
    ),
     ClassRecords(
      slotNo: 1,
      slotFrom: '9:00',
      slotTo: '9:30',
      name: 'SALEEM',
      noOfClasses: '10',
      assignedClass: 'Para 1,Ruku 3'
    ),
     ClassRecords(
      slotNo: 1,
      slotFrom: '9:00',
      slotTo: '9:30',
      name: 'SALEEM',
      noOfClasses: '10',
      assignedClass: 'Para 1,Ruku 3'
    ),
  ];
  static List<TalibDetails> talibTable = [
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),

    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
    TalibDetails(
      name: 'Saleem',
      allotedSlot: 'Slot 1',
      slotFrom: '9:00',
      slotTo: '9:30',
      completeQuran: 'Para 1'
    ),
  ];
 
}
