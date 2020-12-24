import 'package:Tahfizul/data/models/Moulim_Models/PendingAssignments.dart';
import 'package:Tahfizul/data/models/Walidain_Models/Assignment.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/Add_Assignment.dart';
import 'package:Tahfizul/widgets/AssignmentWidget.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CompletedAssignmentScreen extends StatefulWidget {
  CompletedAssignmentScreen({Key key}) : super(key: key);

  @override
  _CompletedAssignmentScreenState createState() => _CompletedAssignmentScreenState();
}

class _CompletedAssignmentScreenState extends State<CompletedAssignmentScreen> {
    MoulimAssignment _assignment = MoulimAssignment();
  List<WalidainPendingAssignmentModel> totalAssignment = [];
  List<WalidainPendingAssignmentModel> filteredPendingAssignment = [];
  
  String checkdata ;
  @override
  void initState() {
    super.initState();
    setState(() => Global.isLoading = true);
    initData();
  }
 

   initData(){
    
    Global.globalMoulimDetails.data.assignedStudentsIds.forEach((element) { 
    fetchMoulimAssignemnt(element).then((value) {
     if (value.status == true) {
       setState(() {
        _assignment = value;
     });
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
       filteredPendingAssignment = totalAssignment.where((element) => element.status.contains('Completed') ).toList();
     });
     }
     else{
       setState(() {
         checkdata = 'No Records';
       });
     }
    });
    setState(() => Global.isLoading = false);
    });
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
                    appBar: AppBarLayout(appbarColor: AppColors.lightestGreyColor,
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
                                   filteredPendingAssignment.isEmpty? Center(
                                     child: SpinKitDoubleBounce(
                                               color: AppColors.appBarColor,
                                               size: 70.0,
                                              ),
                                   ) : checkdata != null ? Center(
                                              child: Text(checkdata,style: AppStyles.blackTextStyle),
                                            ) :Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                 Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Add_Assignment(),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top :8.0),
                                          child: Text('COMPLETED',style: 
                                          AppStyles.greenTextStyle.copyWith(
                                            color: AppColors.appBarColor,fontSize: 25,fontWeight: FontWeight.w500),),
                                        ),
                                        Text('ASSIGNMENTS',style: AppStyles.greenTextStyle.copyWith(
                                          color: AppColors.buttonBg,fontSize: 25),),
                                         Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: filteredPendingAssignment.length,
                                              itemBuilder: (BuildContext context , index){
                                              return Assignment(pendingAssignment: filteredPendingAssignment[index],
                                              bgColor: AppColors.appBarColor,
                                              textColor: AppColors.whiteColor,
                                              );
                                            }),
                                          )
                                              ],
                                            )
                                      ]))));}))))
    );
  }
}