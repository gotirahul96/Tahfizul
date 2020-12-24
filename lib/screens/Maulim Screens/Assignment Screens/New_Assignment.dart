import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CustomExpansionTile.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class New_Assignment extends StatefulWidget {
  New_Assignment({Key key}) : super(key: key);

  @override
  _New_AssignmentState createState() => _New_AssignmentState();
}

class _New_AssignmentState extends State<New_Assignment> {
  TextEditingController assignmentDetails = TextEditingController();
  @override
  void initState() {
    assignmentDetails.text = '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,''';
    super.initState();
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
                  backgroundColor: AppColors.buttonBg,       
                    appBar: AppBarLayout(
                    appbarColor: AppColors.buttonBg,
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
                                          child: Text('NEW',style: AppStyles.greenTextStyle.copyWith(
                                            color: AppColors.whiteColor,fontSize: 30,fontWeight: FontWeight.w500),),
                                        ),
                                        Text('ASSIGNMENT',style: AppStyles.greenTextStyle.copyWith(
                                          color: AppColors.whiteColor,fontSize: 23),),
                                      Padding(
                                        padding: const EdgeInsets.only(top : 20.0),
                                        child: CustomExpansionTile(
                                          title: Text('ASSIGNMENT TYPE',style: TextStyle(
                                            fontWeight: FontWeight.w500
                                          ),),
                                          backgroundColor: AppColors.buttonBg,
                                          headerBackgroundColor : AppColors.whiteColor,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top : 15.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.arrow_forward_ios,size: 18,color: AppColors.whiteColor,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left :8.0),
                                                    child: Text('DAILY ASSIGNMENT',
                                                    style: AppStyles.whiteTextStyle.copyWith(fontSize: 18,fontWeight: FontWeight.w500),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top : 15.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.arrow_forward_ios,size: 18,color: AppColors.whiteColor,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left :8.0),
                                                    child: Text('WEEKLY ASSIGNMENT',
                                                    style: AppStyles.whiteTextStyle.copyWith(fontSize: 18,fontWeight: FontWeight.w500),),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                          ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top : 20.0),
                                        child: CustomExpansionTile(
                                          title: Text('STUDENT NAME',style: TextStyle(
                                            fontWeight: FontWeight.w500
                                          ),),
                                          backgroundColor: AppColors.buttonBg,
                                          headerBackgroundColor : AppColors.whiteColor,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top : 15.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.arrow_forward_ios,size: 18,color: AppColors.whiteColor,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left :8.0),
                                                    child: Text('DAILY ASSIGNMENT',
                                                    style: AppStyles.whiteTextStyle.copyWith(fontSize: 18,fontWeight: FontWeight.w500),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top : 15.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.arrow_forward_ios,size: 18,color: AppColors.whiteColor,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left :8.0),
                                                    child: Text('WEEKLY ASSIGNMENT',
                                                    style: AppStyles.whiteTextStyle.copyWith(fontSize: 18,fontWeight: FontWeight.w500),),
                                                  )
                                                ],
                                              ),
                                            ),
                                           
                                          ],
                                          ),
                                      ),
                                       Padding(
                                              padding: const EdgeInsets.only(top : 25.0),
                                              child: Container(
                                                padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                                                color: AppColors.whiteColor,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('About ASSIGNMENT',
                                                    style: AppStyles.blackTextStyle.copyWith(fontSize: 20,fontWeight: FontWeight.w400),),
                                                    TextFormField(
                                                      controller: assignmentDetails,
                                                      maxLength: null,
                                                      maxLines: null,
                                                      style: AppStyles.greyTextStyle.copyWith(color: Color(0xffadadad),fontSize: 16),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('MEDIA FILES',style: AppStyles.whiteTextStyle.copyWith(fontSize: 16),),
                                              Padding(
                                                padding: const EdgeInsets.only(left : 8.0),
                                                child: RaisedButton(
                                                  onPressed: (){},
                                                  color: AppColors.whiteColor,
                                                  child: Text('UPLOAD'),
                                                  ),
                                              )
                                            ],
                                          ),
                                        )

                                      ]))));}))))
    );
  }
}