import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/util/validators/validators.dart';
import 'package:Tahfizul/widgets/CustomButton.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WalidainFeedBack extends StatefulWidget {
  WalidainFeedBack({Key key}) : super(key: key);

  @override
  _WalidainFeedBackState createState() => _WalidainFeedBackState();
}

class _WalidainFeedBackState extends State<WalidainFeedBack> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController studentName = TextEditingController();
  TextEditingController slotNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController moreDetails = TextEditingController();
  FocusNode studentNameNode = FocusNode();
  FocusNode slotNoNode = FocusNode();
  FocusNode emailidNode = FocusNode();
  FocusNode moreDetailsNode = FocusNode();
  

  void onSubmitted(){
    if (_formKey.currentState.validate()) {
      
    }
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
                    appBar: AppBarLayout(
                    appBarTitle: 'FeedBack',
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
                                child: Form(
                                 key: _formKey,
                                 child: Column(
                                  mainAxisAlignment:  MainAxisAlignment.start,                                       
                                  crossAxisAlignment:  CrossAxisAlignment.start, 
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Center(
                                      child: Image.asset('assets/images/walidainfeedback.png',
                                      height: 35,
                                      width: 120,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top : 15.0),
                                      child: TextFormField(
                                        controller: studentName,
                                        style: AppStyles.blackTextStyle,
                                        focusNode: studentNameNode,
                                         validator: (value){
                                          if (value.trim().isEmpty) {
                                            return 'Please enter Student Name.';
                                          }
                                          return null;
                                        },
                                        onFieldSubmitted: (value) =>  FocusScope.of(context) .requestFocus(slotNoNode),
                                        decoration: InputDecoration(
                                          hintText: 'Student Name',
                                          hintStyle: AppStyles.greyTextStyle.
                                          copyWith(color: AppColors.darkblue,fontWeight: FontWeight.w500),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2)
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2
                                            )
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2
                                            )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                     padding: const EdgeInsets.only(top : 15.0),
                                      child: TextFormField(
                                        controller: slotNo,
                                        style: AppStyles.blackTextStyle,
                                        focusNode: slotNoNode,
                                        validator: (value){
                                          if (value.trim().isEmpty) {
                                            return 'Please enter Slot No.';
                                          }
                                          return null;
                                        },
                                        onFieldSubmitted: (value) =>  FocusScope.of(context) .requestFocus(emailidNode),
                                        decoration: InputDecoration(
                                          hintText: 'Slot No',
                                          hintStyle: AppStyles.greyTextStyle.
                                          copyWith(color: AppColors.darkblue,fontWeight: FontWeight.w500),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2)
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2
                                            )
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2
                                            )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top : 15.0),
                                      child: TextFormField(
                                        controller: emailId,
                                        focusNode: emailidNode,
                                        style: AppStyles.blackTextStyle,
                                        validator: (value) =>Validators.mustEmail(value),
                                        onFieldSubmitted: (value) =>  FocusScope.of(context) .requestFocus(moreDetailsNode),
                                        decoration: InputDecoration(
                                          hintText: 'Email ID',
                                          hintStyle: AppStyles.greyTextStyle.
                                          copyWith(color: AppColors.darkblue,fontWeight: FontWeight.w500),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2)
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2
                                            )
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2
                                            )),
                                        ),
                                      ),
                                    ),
                                     Padding(
                                      padding: const EdgeInsets.only(top : 30.0),
                                      child: TextFormField(
                                        controller: moreDetails,
                                        style: AppStyles.blackTextStyle,
                                        focusNode: moreDetailsNode,
                                        maxLines: 5,
                                        onFieldSubmitted: (value) =>  FocusScope.of(context).unfocus(),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.mediumGreenColor,
                                              width: 2
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          )
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top : 20.0),
                                      child: CustomRoundedButton(
                                        text: 'Submit Feedback',
                                        bgcolor: AppColors.darkblue,
                                        onPressed: onSubmitted,
                                      ),
                                    )
                                  ]),
                                ))),
                      );}))))
    );
  }
}