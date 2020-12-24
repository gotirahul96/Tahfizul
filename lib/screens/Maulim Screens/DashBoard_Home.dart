import 'package:Tahfizul/data/models/Moulim_Models/ClassTimeSlot.dart';
import 'package:Tahfizul/data/models/Moulim_Models/MoulimDetails.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/Maulim_Drawer.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';

class DashBoard_Home extends StatefulWidget {
  DashBoard_Home({Key key}) : super(key: key);

  @override
  _DashBoard_HomeState createState() => _DashBoard_HomeState();
}

class _DashBoard_HomeState extends State<DashBoard_Home> {
  MoulimTimeSlots classTimeslot = MoulimTimeSlots();
  int columnCount = 2;
  DateTime backbuttonpressedTime;
  bool checkclass = false;
  final serverText = 'https://meet.amtechgcc.com/';
  final roomText = TextEditingController(text: "plugintestroom");
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
    print(Global.moulimDataBaseModel.token);
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
  initdata(){
    setState(() => Global.isLoading = true);
    fetchMoulimDetails(Global.moulimDataBaseModel.mualemId).then((value) {
      if (value.status == true) {
        setState(() {
          Global.globalMoulimDetails = value;
          subjectText.text = "My Plugin Test Meeting";
   nameText.text  = Global.globalMoulimDetails.data.name;
   emailText.text = Global.globalMoulimDetails.data.email;
        });
      }
    });
    fetchMoulimTodayClassDetails(Global.moulimDataBaseModel.mualemId).then((value) {
      setState(() => Global.isLoading = false);
      if (value.status == true) {
        setState(() {
          classTimeslot = value;
        });
      }
      else{
        setState(() {
          checkclass = true;
        });
        Toast.show('${value.status}', context);
      }

    });
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

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
      _showMyDialog('Your Class is over');
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
    _showMyDialog('Something went wrong.');
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
      var options = JitsiMeetingOptions()
        ..room = roomText.text
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
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
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
                    drawer: NavDrawer(),
                    appBar: AppBarLayout(
                      titleColor: AppColors.whiteColor,
                      appBarTitle: 'Mualem TimeSlots',
                      icontheme: IconThemeData(
                        color: AppColors.whiteColor
                      ),
                    ),
                    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,                  
                    body: LayoutBuilder(builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return WillPopScope(
                        onWillPop: onWillPop,
                            child: Container(
                            width: double.infinity,
                            padding : EdgeInsets.only(left :12,right: 12),
                            child: SingleChildScrollView(
                                child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: viewportConstraints.maxHeight,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                     FutureBuilder<MoulimTimeSlots>(
                                       future: fetchMoulimTodayClassDetails(Global.moulimDataBaseModel.mualemId),
                                       builder: (context,snapshot){
                                       if (snapshot.connectionState == ConnectionState.done) {
                                         if (snapshot.data.status) {
                                           return Stack(
                                            children: [                                           
                                        Column(
                                                 mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(   
                                                    margin: EdgeInsets.only(top: 30),                                     
                                                    child: AnimationLimiter(
                                                      child: GridView.count(
                                                        crossAxisCount: columnCount,
                                                        physics: ScrollPhysics(),
                                                        //childAspectRatio: 1.2,
                                                        shrinkWrap: true,
                                                        children: List.generate(
                                                            classTimeslot.data.length,
                                                            (index) {
                                                          return AnimationConfiguration
                                                              .staggeredGrid(
                                                                position: index,                                                        
                                                                  columnCount:  columnCount,   
                                                                  duration: const Duration(milliseconds: 500),  
                                                                  child: ScaleAnimation(
                                                                      child: FadeInAnimation( 
                                                                        child: Padding(
                                                                         padding: EdgeInsets.all(2),
                                                                        child: GestureDetector(
                                                                          onTap: (){
                                                                            _joinMeeting();
                                                                          },
                                                                      child: Card(                                                                                                                                 
                                                                    elevation: 2,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(10.0),
                                                                      child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                height: 12,
                                                                                width: 12,
                                                                                decoration: BoxDecoration(
                                                                                  color: classTimeslot.data[index].status == 0 ? AppColors.lightestGreyColor : 
                                                                                  classTimeslot.data[index].status == 1 ? AppColors.orangeColor : AppColors.greenColor,
                                                                                  shape: BoxShape.circle
                                                                                ),
                                                                                child: Text(' '),
                                                                              ),
                                                                              Center(child: Padding(
                                                                                padding: const EdgeInsets.only(top : 8.0),
                                                                                child: Text(classTimeslot.data[index].slotType,style: AppStyles.mediumtitleTextStyle,),
                                                                              )),  
                                                                              Center(
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(top: 10),
                                                                                  child: Text('${classTimeslot.data[index].startTime} TO ${classTimeslot.data[index].endTime}',
                                                                                  style: AppStyles.greyTextStyle.copyWith(color: AppColors.mediumGreyColor,
                                                                                  fontWeight: FontWeight.w500,fontSize: 13,)),
                                                                                
                                                                                ),
                                                                              ),
                                                                              Center(child: Padding(
                                                                                padding: const EdgeInsets.only(top : 5.0),
                                                                                child: Text(classTimeslot.data[index].description,
                                                                                textAlign: TextAlign.center,
                                                                                style: AppStyles.mediumtitleTextStyle,),
                                                                              )),                                                                                                                               
                                                                            ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                        ),
                                                                      ))));
                                                        }),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Positioned(
                                              top: 7,
                                              right: 0,
                                              child: Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: FloatingActionButton(
                                                onPressed: (){},
                                                backgroundColor: AppColors.buttonBg,
                                                child: Icon(Icons.add,color: AppColors.whiteColor,),
                                                ),
                                              ),)
                                            ],
                                          );
                                         }
                                         else{
                                           return Center(child: Text('No Records'),);
                                         }
                                       }
                                       return Center(
                                         child: SpinKitDoubleBounce(
                        color: AppColors.appBarColor,
                        size: 70.0,
                      ),
                                       );
                                     })    
                                        ])))),
                      );
                    })))));
  }
}
