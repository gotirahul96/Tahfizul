import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class TalibheClassrecords extends StatefulWidget {
  TalibheClassrecords({Key key}) : super(key: key);

  @override
  _TalibheClassrecordsState createState() => _TalibheClassrecordsState();
}

class _TalibheClassrecordsState extends State<TalibheClassrecords> {
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
            appBar: AppBarLayout(
                      titleColor: AppColors.whiteColor,
                      appBarTitle: 'Talibhe llm Class records',
                      appbarColor : AppColors.talibhebuttonbg,
                      icontheme: IconThemeData(
                    color: Colors.white, //change your color here
                    ), 
                    ),
            body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return Container(
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
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: Global.talivheClassrecords.length,
                              itemBuilder: (BuildContext context,index)
                              => Padding(
                                padding: const EdgeInsets.only(top : 5.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Class ${Global.talivheClassrecords[index].classNo} (${Global.talivheClassrecords[index].assignmentNo})',
                                        style: AppStyles.greyTextStyle,
                                        ),
                                        Row(
                                          children: [
                                             Icon(Icons.file_download,color: AppColors.greyColor,),
                                             Padding(
                                               padding: const EdgeInsets.only(left : 5.0),
                                               child: Icon(Icons.remove_red_eye,color: AppColors.greyColor,),
                                             )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          ]))));}))))
    );
  }
}