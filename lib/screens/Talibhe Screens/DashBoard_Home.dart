import 'package:Tahfizul/data/models/Talibhe_Models/TalibheDetails.dart';
import 'package:Tahfizul/data/models/Walidain_Models/TodaysClasses.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/Talibhe_Widgets/Talibhe_Drawer.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';

class TalibheDashBoard extends StatefulWidget {
  TalibheDashBoard({Key key}) : super(key: key);

  @override
  _TalibheDashBoardState createState() => _TalibheDashBoardState();
}

class _TalibheDashBoardState extends State<TalibheDashBoard> {
  DateTime backbuttonpressedTime;
  TodayClasses classTimeslot ;
  final serverText = 'https://meet.thedronline.com/';
  TextEditingController roomText = TextEditingController(text: "plugintestroom");
  TextEditingController subjectText = TextEditingController(text: "My Plugin Test Meeting");
  TextEditingController nameText = TextEditingController(text: "Plugin Test User");
  TextEditingController emailText = TextEditingController(text: "fake@email.com");
  bool isAudioOnly = true;
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  @override
  void initState() { 
    super.initState();
     initdata();  
     initJitsiListerners();
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }
  initJitsiListerners(){
  
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  
   static final Map<RoomNameConstraintType, RoomNameConstraint>
      customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
              .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
    _showMyDialog('Something went wrong.');
  }

  
  ///////////Join Meeting 
 
   _joinMeeting() async {
    String serverUrl =
        serverText?.trim()?.isEmpty ?? "" ? null : serverText;

    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };

      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      // Define meetings options here
      var options = JitsiMeetingOptions(room: roomText.text)
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureFlags);

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: (message) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: (message) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: (message) {
         
          debugPrint("${options.room} terminated with message: $message");
         
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
      _showMyDialog(error);
    }
  }
   Future<void> _showMyDialog(String title) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  initdata(){
    fetchthalibheDetails(Global.thalibheDataBaseModel.talibIlmId).then((value) {
      if (value.status == true) {
        setState(() {
          Global.globalThalibheDetails = value; 
           subjectText.text = "My Plugin Test Meeting";
   nameText.text  = Global.globalThalibheDetails.data.username;
   emailText.text = Global.globalThalibheDetails.data.email;
        });
      }
    });
    
  }

  Future<bool> onWillPop() async {
  DateTime currentTime = DateTime.now();

  //Statement 1 Or statement2
  bool backButton = backbuttonpressedTime == null ||
      currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);

  if (backButton) {
    backbuttonpressedTime = currentTime;
        Toast.show("Double Click to exit app", context, duration: Toast.LENGTH_LONG,
         gravity:  Toast.BOTTOM);
    return false;
  }
  SystemNavigator.pop();
  return true;
}

bool isCurrentDateInRange(DateTime startDate, DateTime endDate) {
  
  final currentDate = DateTime.now();
  return currentDate.isAfter(startDate) && currentDate.isBefore(endDate);
}
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.buttonBg,
      progressIndicator: AppLoader(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.talibhebuttonbg,
            drawer: Talibhe_NavDrawer(),
            appBar: AppBarLayout(
                      titleColor: AppColors.whiteColor,
                      appBarTitle: 'Todays Classes Time Slots',
                      appbarColor : AppColors.talibheappbarColor,
                      icontheme: IconThemeData(
                    color: Colors.white, //change your color here
                    ), 
            ),
            body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return WillPopScope(
               onWillPop: onWillPop,
                child: Container(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: FutureBuilder<TodayClasses>(
                        future: fetchThalibheTodayClassDetails(Global.thalibheDataBaseModel.talibIlmId),                                 
                        builder: ( context,  snapshot) {
                       if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.data.status == true) {
                              return Container(
                                height: SizeConfig.safeScreenHeight,
                                child: Padding(
                                  padding:  EdgeInsets.only(bottom : 65.0),
                                  child: ListView.builder(
                           shrinkWrap: true,
                           
                           itemCount: snapshot.data.data.length,
                           itemBuilder: (BuildContext context,index)
                           {
                             snapshot.data.data.sort((a,b) => a.startTime.compareTo(b.endTime));
                          return Container(
                      margin: EdgeInsets.only(top: 20),
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        onPressed: () {                       
                          
                            if (isCurrentDateInRange(DateFormat("yyyy-MM-dd hh:mm a").parse('${snapshot.data.data[index].date} ${snapshot.data.data[index].startTime}'),DateFormat("yyyy-MM-dd hh:mm a").parse('${snapshot.data.data[index].date} ${snapshot.data.data[index].endTime}'))) {
                                                                   print('in range');
                                                                   _joinMeeting();
                                                                 }
                                                                 else {
                                                                   print('not in range');
                                                                   Toast.show('Select TimeSlots according to the current Time.', context);
                                                                 }
                        },
                        color: AppColors.whiteColor,
                         shape: StadiumBorder(),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${snapshot.data.data[index].slotType}',
                            style: AppStyles.greenTextStyle.copyWith(
                             fontSize: 20,
                             fontWeight: FontWeight.w500),),
                            Padding(
                             padding: EdgeInsets.only(top: 10),
                             child: Text('${snapshot.data.data[index].startTime} TO ${snapshot.data.data[index].endTime}',
                             style: AppStyles.greyTextStyle.copyWith(
                             color: isCurrentDateInRange(DateFormat("yyyy-MM-dd hh:mm a").parse('${snapshot.data.data[index].date} ${snapshot.data.data[index].startTime}'),DateFormat("yyyy-MM-dd hh:mm a").parse('${snapshot.data.data[index].date} ${snapshot.data.data[index].endTime}')) ? Colors.blue : AppColors.mediumGreyColor,
                             fontWeight: FontWeight.w500
                             ),
                             ),
                             )
                          ],
                        ),
                      ),
                       );}),
                                ),
                              );
                          }else{
                              return Container(
                                child: Text('No Records',style: AppStyles.blackTextStyle,),
                              );
                            }
                          }
                          return Center(
                               child: SpinKitDoubleBounce(
                        color: AppColors.talibheappbarColor,
                        size: 70.0,
                       ),
                      );
                        },
                      ))),
            );}))))
    );
  }
}