import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/ClassRecordWidget.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ClassRecordScreen extends StatefulWidget {
  ClassRecordScreen({Key key}) : super(key: key);

  @override
  _ClassRecordScreenState createState() => _ClassRecordScreenState();
}

class _ClassRecordScreenState extends State<ClassRecordScreen> {
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
                  backgroundColor: AppColors.mediumtitleGreenColor,     
                    appBar: AppBarLayout(
                    appBarTitle: 'Moulim Class records',
                    appbarColor: AppColors.appBarColor,
                    titleColor: AppColors.whiteColor,
                    icontheme: IconThemeData(
                    color: Colors.white, //change your color here
                    ),),
                    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,                   
                    body: LayoutBuilder(builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return Padding(
                       padding : EdgeInsets.only(left :12,right: 12,top: 25),
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
                                   ListView.builder(
                                     shrinkWrap: true,
                                     physics: NeverScrollableScrollPhysics(),
                                     itemCount: Global.classRecords.length,
                                     itemBuilder: (BuildContext context,index){
                                        return ClassRecordsWidget(classrecords: Global.classRecords[index],);
                                     })
                                 ]))));}))))
    );
  }
}