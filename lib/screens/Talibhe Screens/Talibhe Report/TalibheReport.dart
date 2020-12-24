import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TalibellmReport extends StatefulWidget {
  TalibellmReport({Key key}) : super(key: key);

  @override
  _TalibellmReportState createState() => _TalibellmReportState();
}

class _TalibellmReportState extends State<TalibellmReport> {
  String maulimName = 'SHAIK SALEEM';
  String assignedSlot = '1';
  String totalClassed = '10';
  String completedQuran = 'Para 1';

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
                    appBar: AppBarLayout(
                    appBarTitle: 'Talibe llm Report',
                    appbarColor: AppColors.lightestGreyColor,
                    icontheme: IconThemeData(
                    color: Colors.black, //change your color here
                    ),),
                    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,                   
                    body: LayoutBuilder(builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return Padding(
                       padding : EdgeInsets.only(left :12,right: 12),
                        child: SingleChildScrollView(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: viewportConstraints.maxHeight,
                                ),
                                child: Column(
                                 mainAxisAlignment:  MainAxisAlignment.start,                                       
                                 crossAxisAlignment:  CrossAxisAlignment.start, 
                                 mainAxisSize: MainAxisSize.max,
                                 children: [
                                   Center(
                                     child: Container(
                                     child: Image.asset('assets/images/Moulvi.png',                
                                     height: 90,
                                     width: 90,
                                     ),
                                  ),
                                   ),
                                   Center(
                                     child: Padding(
                                       padding: const EdgeInsets.only(top : 15.0),
                                       child: Text(maulimName,
                                       style: AppStyles.blackTextStyle.copyWith(
                                         color: AppColors.orangeColor),),
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(top : 20.0),
                                     child: Text('Assigned Slot - $assignedSlot',
                                     style: AppStyles.greenTextStyle.copyWith(fontWeight: FontWeight.w500),
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(top : 10.0),
                                     child: Text('Total Classes - $totalClassed',
                                     style: AppStyles.greenTextStyle.copyWith(fontWeight: FontWeight.w500),),
                                   ),
                                   Padding(
                                    padding: const EdgeInsets.only(top : 10.0),
                                     child: Text('Completed Quran - $completedQuran',
                                     style: AppStyles.greenTextStyle.copyWith(fontWeight: FontWeight.w500),),
                                   ),
                                   Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Opacity( 
                                        opacity: 0.5 ,
                                        child: Text('About Saleem:',
                                        style: AppStyles.mediumtitleTextStyle.copyWith(fontSize: 25,),)),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 10),
                                    child: Opacity(
                                      opacity: 0.5 ,
                                      child: Text('''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.''',
                                      style: AppStyles.greyTextStyle,
                                      ),
                                    ),
                                    )
                                 ]))),
                      );}))))
    );
  }
}