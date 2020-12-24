import 'package:Tahfizul/screens/Maulim%20Screens/ClassRecords/ClassRecords.dart';
import 'package:Tahfizul/services/DataBaseFile.dart';
import 'package:Tahfizul/util/AuthProvider.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/Common Screens/Selection_Screen.dart';
import 'screens/Maulim Screens/Assignment Screens/CompletedAssignment.dart';
import 'screens/Maulim Screens/Assignment Screens/New_Assignment.dart';
import 'screens/Maulim Screens/Assignment Screens/PendingAssignment.dart';
import 'screens/Maulim Screens/Assignment Screens/PendingAssignmentDetails.dart';
import 'screens/Maulim Screens/DashBoard_Home.dart';
import 'screens/Maulim Screens/FeedBack/Feedback.dart';
import 'screens/Maulim Screens/Maulim auth/login.dart';
import 'screens/Maulim Screens/Maulim auth/registration.dart';
import 'screens/Maulim Screens/Profile/Maulim_Profile.dart';
import 'screens/Maulim Screens/ResetPassword/Resetpassword.dart';
import 'screens/Maulim Screens/TalibeDetails/TalibellmDetailScreen.dart';
import 'screens/Maulim Screens/TalibeReport/TalibellmReportScreen.dart';
import 'screens/Talibhe Screens/Assignments/CompletedAssignment/Talibhe_Completed_Assignment.dart';
import 'screens/Talibhe Screens/Assignments/Talibhe_PendingDetails.dart';
import 'screens/Talibhe Screens/Assignments/Talibhe_Pending_Assignment.dart';
import 'screens/Talibhe Screens/DashBoard_Home.dart';
import 'screens/Talibhe Screens/Maulim Profile/Follow_Maulim.dart';
import 'screens/Talibhe Screens/ResePassword/ResetPassword.dart';
import 'screens/Talibhe Screens/Talibhe Class Records/TalibheClassRecords.dart';
import 'screens/Talibhe Screens/Talibhe Details/TalibheDetail.dart';
import 'screens/Talibhe Screens/Talibhe Report/TalibheReport.dart';
import 'screens/Talibhe Screens/Talibhe auth/login.dart';
import 'screens/Walidain Screens/Assignment/WalidainAssignmentDetails.dart';
import 'screens/Walidain Screens/Assignment/WalidainCompletedAssignment.dart';
import 'screens/Walidain Screens/Assignment/WalidainPendingAssignment.dart';
import 'screens/Walidain Screens/Dashboard_Home.dart';
import 'screens/Walidain Screens/FeedBack/WalidainFeedBack.dart';
import 'screens/Walidain Screens/Maulim_Profile/WalidainMaulimProfile.dart';
import 'screens/Walidain Screens/ResetPassword/ResetWalidainPassword.dart';
import 'screens/Walidain Screens/TalibilmReport/WalidainTalibilmReport.dart';
import 'screens/Walidain Screens/WalidainClassRecords/WalidainClassRecordsScreen.dart';
import 'screens/Walidain Screens/WalidainDetails/WalidainDetails.dart';
import 'util/theme.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthProvider authProvider = AuthProvider();
  String userType = '';
  Widget _defaultHome = Selection_Screen();
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) { 
      Global.prefs = value;
      checkUserType();
      });
    super.initState();
    
    
  }
  void checkUserType(){
    if (authProvider.getUserType() != null) {
     userType = authProvider.getUserType();
    }
   
   if (userType != '') {
     if (userType == 'walidain') {
       Global.walidainDatabaseModel = authProvider.getWalidainData();
       setState(() => _defaultHome = WalidainDashBoard());
      
     } else if (userType == 'moulim') {
       Global.moulimDataBaseModel = authProvider.getmoulimData();
       setState(() => _defaultHome = DashBoard_Home());
       
    
     } else if (userType == 'thalibhe') {
       Global.thalibheDataBaseModel = authProvider.getThalibheData();
       setState(() =>  _defaultHome = TalibheDashBoard());
      
     
     }
   }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahfizul',
      routes: <String, WidgetBuilder>{
    //Selection Screen
    'selection_screen': (BuildContext context) => Selection_Screen(),
    //Maulim Screens
    'moulimlogin': (BuildContext context) => MoulimLogin(),
    'registration': (BuildContext context) => Registration(),
    'dashBoard_home': (BuildContext context) => DashBoard_Home(),
    'maulim_profile': (BuildContext context) => Maulim_Profile(),
    'pendingassignmentscreen' : (BuildContext context) => PendingAssignmentScreen(),
    'completedassignmentscreen': (BuildContext context) => CompletedAssignmentScreen(),
    'new_assignment': (BuildContext context) => New_Assignment(),
    'talibellmdetailsscreen': (BuildContext context) => TalibellmDetailsScreen(),
    'maulimfeedback': (BuildContext context) => MaulimFeedBack(),
    'talibellmreportscreen': (BuildContext context) => TalibellmReportScreen(),
    'classrecordscreen': (BuildContext context) => ClassRecordScreen(),
    'pendingassignmentdetails': (BuildContext context) => PendingAssignmentDetails(),
    'resetpassword' : (BuildContext context) => Resetpassword(),
    //Talibhe Screens 
    'talibhelogin' : (BuildContext context) => TalibheLogin(),
    'talibhedashboard': (BuildContext context) => TalibheDashBoard(),
    'followmaulim_profile': (BuildContext context) => Follow_Maulim_Profile(),
    'Talibhe_Pending_Assignment': (BuildContext context) => Talibhe_Pending_Assignment(),
    'TalibhePendingDetails': (BuildContext context) => TalibhePendingDetails(),
    'TalibheCompletedAssignemnt' : (BuildContext context) => TalibheCompletedAssignemnt(),
    'TalibheClassrecords': (BuildContext context) => TalibheClassrecords(),
    'TalibellmReport': (BuildContext context) => TalibellmReport(),
    'TalibheDetails': (BuildContext context) => TalibheDetails(),
    'ResetThalibhepassword': (BuildContext context) => ResetThalibhepassword(),
    //Walidain Screens 
    'walidaindashboard': (BuildContext context) => WalidainDashBoard(),
    'WalidainMaulimProfile': (BuildContext context) => WalidainMaulimProfile(),
    'walidainpendingassignment': (BuildContext context) => WalidainPendingAssignment(),
    'walidaincompletedassignment' : (BuildContext context) => WalidainCompletedAssignment(),
    'walidainassignmentdetails': (BuildContext context) => WalidainAssignmentDetails(),
    'WalidainClassRecordsScreen': (BuildContext context) => WalidainClassRecordsScreen(),
    'WalidainTalibellmReport': (BuildContext context) => WalidainTalibellmReport(),
    'walidaindetails': (BuildContext context) => WalidainDetails(),
    'WalidainFeedBack': (BuildContext context) => WalidainFeedBack(),
    'ResetWalidainpassword': (BuildContext context) => ResetWalidainpassword(),
    },
      theme: appTheme(),
      home: _defaultHome,
    );
  }
}
