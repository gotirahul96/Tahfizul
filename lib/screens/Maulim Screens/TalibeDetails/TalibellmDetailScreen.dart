import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TalibellmDetailsScreen extends StatefulWidget {
  TalibellmDetailsScreen({Key key}) : super(key: key);

  @override
  _TalibellmDetailsScreenState createState() => _TalibellmDetailsScreenState();
}

class _TalibellmDetailsScreenState extends State<TalibellmDetailsScreen> {
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
                    appBarTitle : 'Talibe llm Details',
                    icontheme: IconThemeData(
                    color: Colors.black, //change your color here
                    ),),
                    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,                   
                    body: LayoutBuilder(builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return Container(
                          width: double.infinity,
                          padding : EdgeInsets.only(left :12,right: 12,bottom: 12),
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
                                    SingleChildScrollView(
                                       scrollDirection: Axis.horizontal,
                                       child: FittedBox(
                                         child: DataTable(
                                       columnSpacing: 0,
                                       headingRowHeight: 42,
                                       dividerThickness: 1,
                                       dataRowHeight: 50,
                                       horizontalMargin: 0,
                                         columns: [
                                           DataColumn(
                                           label: 
                                           Container(
                                             padding: EdgeInsets.only(left: 10,right: 10),
                                            decoration: BoxDecoration(
                                             color: AppColors.bgtable,
                                             border: Border(
                                               bottom: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                               left: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                               top: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                             )
                                            ),
                                            
                                             height: 40,
                                             child: Center(child: Text('Name',
                                             style: AppStyles.greenTextStyle,)))),
                                           DataColumn(label: 
                                           Container(
                                            padding: EdgeInsets.only(left: 10,right: 10),
                                             decoration: BoxDecoration(
                                             color: AppColors.bgtable,
                                             border: Border(
                                               bottom: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                               left: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                               top: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                             )
                                            ),
                                            
                                             height: 40,
                                             child: Center(child: Text('Aloted Slot',
                                              style: AppStyles.greenTextStyle,)))),
                                           DataColumn(
                                             label: Container(
                                               padding: EdgeInsets.only(left: 10,right: 10),
                                             decoration: BoxDecoration(
                                             color: AppColors.bgtable,
                                             border: Border(
                                               bottom: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                               left: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                               top: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                             )
                                            ),
                                            
                                             height: 40,
                                               child: Padding(
                                                 padding: const EdgeInsets.only(left : 12.5,right: 12.5),
                                                 child: Center(
                                                   child: Text('Time',
                                            style: AppStyles.greenTextStyle,),
                                                 ),
                                               ),
                                             )),
                                           DataColumn(
                                             label: Container(
                                               padding: EdgeInsets.only(left: 10,right: 10),
                                             decoration: BoxDecoration(
                                             color: AppColors.bgtable,
                                             border: Border(
                                               bottom: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                               left: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                               top: BorderSide(
                                                 color: AppColors.mediumGreenColor
                                               ),
                                             )
                                            ),
                                            
                                             height: 40,
                                               child: Center(
                                                 child: Text('Complete Quran',
                                            style: AppStyles.greenTextStyle,),
                                               ),
                                             )),
                                           DataColumn(
                                             label: Container(
                                               padding: EdgeInsets.only(left: 10,right: 10),
                                             decoration: BoxDecoration(
                                             color: AppColors.bgtable,
                                             border: Border.all(
                                               color: AppColors.mediumGreenColor
                                             )
                                            ),
                                            
                                             height: 40,
                                               child: Center(
                                                 child: Text('View',
                                            style: AppStyles.greenTextStyle,),
                                               ),
                                             )),
                                         ] , 
                                         rows: Global.talibTable.map((e) => 
                                         DataRow(
                                           cells: [
                                             DataCell(
                                               Container(
                                                 decoration: BoxDecoration(
                                                    border: Border(
                                                        left : BorderSide(
                                                            color: AppColors.mediumGreyColor,
                                                            width: 1),
                                                        bottom: BorderSide(
                                                            color: AppColors.mediumGreyColor,
                                                            width: 1),    
                                                            )),
                                                 child: Center(child: Text(e.name,
                                                 style: AppStyles.blackTextStyle.copyWith(fontSize: 15),)))),
                                             DataCell(
                                               Container(
                                                 decoration: BoxDecoration(
                                                    border: Border(
                                                        left : BorderSide(
                                                            color: AppColors.mediumGreyColor,
                                                            width: 1),
                                                        bottom: BorderSide(
                                                            color: AppColors.mediumGreyColor,
                                                            width: 1),    
                                                            )),
                                                 child: Center(child: Text(e.allotedSlot,
                                                 style: AppStyles.blackTextStyle.copyWith(fontSize: 15),)))),
                                             DataCell(
                                               Container(
                                                 padding: EdgeInsets.only(left: 10,right: 10),
                                                 decoration: BoxDecoration(
                                                    border: Border(
                                                        left : BorderSide(
                                                            color: AppColors.mediumGreyColor,
                                                            width: 1),
                                                        bottom: BorderSide(
                                                            color: AppColors.mediumGreyColor,
                                                            width: 1),    
                                                            )),
                                                 child: Center(child: Text('${e.slotFrom}-${e.slotTo}',
                                                 style: AppStyles.blackTextStyle.copyWith(fontSize: 15),)))),
                                             DataCell(
                                               Container(
                                                 decoration: BoxDecoration(
                                                    border: Border(
                                                        left : BorderSide(
                                                            color: AppColors.mediumGreyColor,
                                                            width: 1),
                                                        bottom: BorderSide(
                                                            color: AppColors.mediumGreyColor,
                                                            width: 1),    
                                                            )),
                                               child: Center(child: Text(e.completeQuran,
                                                 style: AppStyles.blackTextStyle.copyWith(fontSize: 15),)))),
                                             DataCell(
                                               Container(
                                                 decoration: BoxDecoration(
                                                    border: Border(
                                                        left : BorderSide(
                                                            color: AppColors.mediumGreyColor,
                                                            width: 1),
                                                        bottom: BorderSide(
                                                            color: AppColors.mediumGreyColor,
                                                            width: 1),   
                                                            right: BorderSide(
                                                            color: AppColors.mediumGreyColor,
                                                            width: 1), 
                                                            )),
                                                 child: Center(
                                                   child: Icon(Icons.remove_red_eye,
                                                   color: AppColors.darkColor,
                                                   )))),
                                           ])
                                           ).toList()),
                                       ),
                                    )
                                  ]))));}))))
    );
  }
}