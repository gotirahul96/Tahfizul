import 'dart:ui';

import 'package:Tahfizul/data/models/Walidain_Models/Assignment.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/Walidain_Widgets/WalidainAssignmentWidget.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class WalidainPendingAssignment extends StatefulWidget {
  WalidainPendingAssignment({Key key}) : super(key: key);

  @override
  _WalidainPendingAssignmentState createState() => _WalidainPendingAssignmentState();
}

class _WalidainPendingAssignmentState extends State<WalidainPendingAssignment> {
  WalidainAssignment _assignment = WalidainAssignment();
  List<WalidainPendingAssignmentModel> totalAssignment = [];
  List<WalidainPendingAssignmentModel> filteredPendingAssignment = [];
  bool loading = false;
  String checkdata ;
  @override
  void initState() {
   super.initState();
  // setState(() => loading = true);
  
     initData();
  }

  initData(){
    
    Global.globalWalidainDetails.data.studentsIds.forEach((element) {    
       
    fetchWalidainAssignemnt(element).then((value) {
     if (value.status == true) {
        _assignment = value;
     value.data.forEach((element) { 
       var a = WalidainPendingAssignmentModel(
           id:  element.id,
           madarsaId: element.madarsaId,
           mualemId: element.madarsaId,
           courseId: element.courseId,
           type: element.type,
           typeId: element.typeId,
           paraId : element.paraId,
           surahId: element.surahId,
           ruku: element.ruku,
           name: element.name,
           description: element.description,
           file: element.file,
           assignedDate: element.assignedDate,
           deadline: element.deadline,
           statusId: element.statusId,
           mualemName: element.mualemName,
           talibilmId: element.talibilmId,
           submittedFile: element.submittedFile,
           status: element.status,
           
       );
       totalAssignment.add(a);
     });

     setState(() {
       filteredPendingAssignment = totalAssignment.where((element) => element.status.contains('Pending') ).toList();
     });
     }
     else{
       Toast.show('No Records', context);
       setState(() {
         checkdata = 'No Records';
       });
     }
     
    });
    });
    // Navigator.pop(context, showWait);
  
    //  loading = false;
   
  }
  
  void showWait(context) {
    showDialog(
        context: context,
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: WillPopScope(
                onWillPop: () async => false,
                          child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          // width: MediaQuery.of(context).size.width,
                          child: SpinKitDoubleBounce(
                        color: Color.fromRGBO(250, 178, 43, 1),
                        size: 70.0,
                      )),
                      // Container(
                      //   margin: EdgeInsets.symmetric(vertical: 20),
                      //   child: Text(
                      //     "LOADING...",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            )));
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.buttonBg,
        progressIndicator: AppLoader(loaderColor: AppColors.darkblue,),
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
                child: Scaffold(                      
                    appBar: AppBarLayout(
                    appbarColor: AppColors.lightestGreyColor,
                    icontheme: IconThemeData(
                    color: Colors.black, //change your color here
                    ),),
                    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,                   
                    body: LayoutBuilder(builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return Container(
                          width: double.infinity,
                          padding : EdgeInsets.only(left :10,right: 10,bottom: 12),
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
                                         Padding(
                                          padding: const EdgeInsets.only(top :8.0),
                                          child: Text('PENDING',style: AppStyles.greenTextStyle.copyWith(
                                            color: AppColors.darkblue,fontSize: 25,fontWeight: FontWeight.w500),),
                                        ),
                                        Text('ASSIGNMENTS',style: AppStyles.greenTextStyle.copyWith(
                                          color: AppColors.darkColor,fontSize: 25),),
                                    Column(
                                        mainAxisAlignment:
                                     MainAxisAlignment.center,
                                        crossAxisAlignment:
                                     CrossAxisAlignment.center,
                                        children: [
                                    filteredPendingAssignment.isEmpty ?Center(
                                     child: SpinKitDoubleBounce(
                                               color: AppColors.darkblue,
                                               size: 70.0,
                                              ),
                                   ) : checkdata != null ?  Container(
                                         child: Center(child: Text('No Assignemnt',style: AppStyles.blackTextStyle,)),
                                       ) :  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        
                                          Container(
                                     child: ListView.builder(
                                     shrinkWrap: true,
                                     physics: NeverScrollableScrollPhysics(),
                                     itemCount: filteredPendingAssignment.length,
                                     itemBuilder: (BuildContext context,index)
                                     {
                                         return WlidainAssignmentWidget(pendingAssignments: filteredPendingAssignment[index],);
                                     }),
                                          )
                                      ],
                                    ),
                                         )
                                        ],
                                      )
                                          ]))));}))))
    );
  }
}