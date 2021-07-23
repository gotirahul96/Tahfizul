import 'package:Tahfizul/data/models/Moulim_Models/ClassTimeSlot.dart';
import 'package:Tahfizul/data/models/Walidain_Models/TodaysClasses.dart';
import 'package:Tahfizul/data/models/Walidain_Models/WalidainDetails.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/Walidain_Widgets/Walidain_Drawer.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class WalidainDashBoard extends StatefulWidget {
  WalidainDashBoard({Key key}) : super(key: key);

  @override
  _WalidainDashBoardState createState() => _WalidainDashBoardState();
}

class _WalidainDashBoardState extends State<WalidainDashBoard> {

  DateTime backbuttonpressedTime;
  TodayClasses classTimeslot ;
  int columnCount = 2;
  bool checkClass = false;


  @override
  void initState() { 
    super.initState();
    initData();
    print(Global.walidainDatabaseModel.token);
  }

  initData(){
   
    
    fetchWalidainDetails(Global.walidainDatabaseModel.walidainId).then((value) {
      setState(() {
        Global.globalWalidainDetails = value;
      });
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          drawer: WalidainNavDrawer(),
          appBar: AppBarLayout(
                    titleColor: AppColors.whiteColor,
                    appBarTitle: 'Todays Classes',
                    appbarColor : AppColors.darkblue,
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
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                           FutureBuilder<TodayClasses>(
                             future: fetchTodayClassDetails(Global.walidainDatabaseModel.walidainId),
                             builder: (context,snapshot){
                              if (snapshot.connectionState == ConnectionState.done) 
                                 {
                                    if (snapshot.data.status == true) {
                                      return Container(   
                                              margin: EdgeInsets.only(top: 30),                                     
                                              child: AnimationLimiter(
                                                child: GridView.count(
                                                  crossAxisCount: columnCount,
                                                  physics: ScrollPhysics(),
                                                  //childAspectRatio: 1.2,
                                                  shrinkWrap: true,
                                                  children: List.generate(
                                                      snapshot.data.data.length ??= 0,
                                                      (index) {
                                                        snapshot.data.data.sort((a,b) => a.startTime.compareTo(b.endTime));
                                                    return AnimationConfiguration
                                                        .staggeredGrid(
                                                          position: index,                                                        
                                                            columnCount:  columnCount,   
                                                            duration: const Duration(milliseconds: 500),  
                                                            child: ScaleAnimation(
                                                                child: FadeInAnimation( 
                                                                  child: Padding(
                                                                   padding: EdgeInsets.all(2),
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
                                                                          color: snapshot.data.data[index].status == 0 ? AppColors.lightestGreyColor : 
                                                                          snapshot.data.data[index].status == 1 ? AppColors.orangeColor : AppColors.darkblue,
                                                                          shape: BoxShape.circle
                                                                        ),
                                                                        child: Text(' '),
                                                                      ),
                                                                      Center(child: Padding(
                                                                        padding: const EdgeInsets.only(top : 8.0),
                                                                        child: Text(snapshot.data.data[index].slotType,style: AppStyles.mediumtitleTextStyle.copyWith(
                                                                          color: snapshot.data.data[index].status == 2 ?  AppColors.darkblue : AppColors.mediumtitleGreenColor
                                                                        ),),
                                                                      )),  
                                                                      Center(
                                                                        child: Padding(
                                                                          padding: EdgeInsets.only(top: 10),
                                                                          child: Text('${snapshot.data.data[index].startTime} TO ${snapshot.data.data[index].endTime}',
                                                                          style: AppStyles.greyTextStyle.copyWith(color: AppColors.mediumGreyColor,
                                                                          fontWeight: FontWeight.w500,fontSize: 13,)),
                                                                        
                                                                        ),
                                                                      )    ,
                                                                      Center(child: Padding(
                                                                        padding: const EdgeInsets.only(top : 5.0),
                                                                        child: Text(snapshot.data.data[index].description,style: AppStyles.mediumtitleTextStyle,),
                                                                      )),                                                                                                                               
                                                                    ],
                                                                ),
                                                              ),
                                                            ),
                                                                ))));
                                                  }),
                                                ),
                                              ),
                                            );
                                    }else {
                                      return Center(child: Text('No Classes',style: AppStyles.blackTextStyle,));
                                    }
                                 }
                                 else{
                                   Center(child: CircularProgressIndicator(backgroundColor: AppColors.darkblue,));
                                 }
                                 return Center(
                                       child: SpinKitDoubleBounce(
                      color: AppColors.darkblue,
                      size: 70.0,
                    ),
                   );
                                 ;
                           })
                          ])))));}))));
  }
}