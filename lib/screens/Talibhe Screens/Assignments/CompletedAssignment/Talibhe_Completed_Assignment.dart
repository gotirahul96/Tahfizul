import 'package:Tahfizul/data/models/Walidain_Models/Assignment.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/Talibhe_Widgets/TalibheAssignmentWidget.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class TalibheCompletedAssignemnt extends StatefulWidget {
  TalibheCompletedAssignemnt({Key key}) : super(key: key);

  @override
  _TalibheCompletedAssignemntState createState() => _TalibheCompletedAssignemntState();
}

class _TalibheCompletedAssignemntState extends State<TalibheCompletedAssignemnt> {
   WalidainAssignment _assignment = WalidainAssignment();
  List<WalidainPendingAssignmentModel> totalAssignment = [];
  List<WalidainPendingAssignmentModel> filteredPendingAssignment = [];

   @override
  void initState() {
    super.initState();
     initData();
  }

   initData(){
      setState(() => Global.isLoading = true);
     fetchThalibheAssignemnt(Global.thalibheDataBaseModel.talibIlmId).then((value) {
        setState(() => Global.isLoading = false);
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
       Toast.show('No Records', context);
     }
    
     });

      setState(() => Global.isLoading = true);
   
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
                  backgroundColor: AppColors.talibhenavbar_bg,         
                    appBar: AppBarLayout(
                    appbarColor: AppColors.talibhenavbar_bg,
                    icontheme: IconThemeData(
                    color: Colors.white, //change your color here
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
                                          child: Text('COMPLETED',style: 
                                          AppStyles.greenTextStyle.copyWith(
                                            color: AppColors.appBarColor,
                                            fontSize: 25,fontWeight: FontWeight.w500),),
                                        ),
                                        Text('ASSIGNMENTS',style: AppStyles.greenTextStyle.copyWith(
                                          color: AppColors.whiteColor,fontSize: 25),),
                                filteredPendingAssignment.isEmpty ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top : 30.0),
                                    child: Text('No Assignment',style: AppStyles.blackTextStyle,),
                                  ),
                                ) : Container(
                                       child: Column(
                                         children: [
                                          
                                        Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: filteredPendingAssignment.length,
                                              itemBuilder: (BuildContext context , index){
                                              Global.selectedIndex = index;
                                              return Talibhe_Assignment(
                                              pendingAssignment: filteredPendingAssignment[index],
                                              index : index,
                                              textColor: AppColors.talibhebuttonbg,);
                                            }),
                                          )
                                         ],
                                       ),
                                     )
                                      ]))));}))))
    );
  }
}