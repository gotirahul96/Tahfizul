import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/Walidain_Widgets/WalidainClassRecordWidget.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WalidainClassRecordsScreen extends StatefulWidget {
  WalidainClassRecordsScreen({Key key}) : super(key: key);

  @override
  _WalidainClassRecordsScreenState createState() => _WalidainClassRecordsScreenState();
}

class _WalidainClassRecordsScreenState extends State<WalidainClassRecordsScreen> {
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
                    appBarTitle: ' Talibe ilm Class Record',
                    appbarColor: AppColors.lightestGreyColor,
                    titleColor: AppColors.darkColor,
                    icontheme: IconThemeData(
                    color: Colors.black, //change your color here
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
                                      return WalidainClassRecordsWidget(classrecords: Global.classRecords[index],);
                                     })
                                 ]))));}))))
    );
  }
}