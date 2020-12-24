import 'package:Tahfizul/data/models/Talibhe_Models/ThalibLogin.dart';
import 'package:Tahfizul/services/DataBaseFile.dart';
import 'package:Tahfizul/services/ThalibheDataBaseModel.dart';
import 'package:Tahfizul/util/AuthProvider.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CustomButton.dart';
import 'package:Tahfizul/widgets/CustomTextFeild.dart';
import 'package:Tahfizul/widgets/FullSreenLoader.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class TalibheLogin extends StatefulWidget {
  TalibheLogin({Key key}) : super(key: key);

  @override
  _TalibheLoginState createState() => _TalibheLoginState();
}

class _TalibheLoginState extends State<TalibheLogin> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  FocusNode mobileNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  static bool obscure = false;
  bool autoValidate = false;
  ThalibheDataBaseModel responseData;
  AuthProvider authProvider = AuthProvider();
  
  void submitlogin() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
     showWait(context,AppColors.talibheappbarColor);
     fetchThalibLoginCredentials(username,password).then((value) {
       
       if (value.status == true) {
         saveDataInDataBase(value);
         Navigator.pop(context, showWait);
         Navigator.of(context).pushNamed('talibhedashboard');
       }
       if (value.status == false) {
         Navigator.pop(context, showWait);
         Toast.show(value.message, context);
       }
     });
    }
  }
  void saveDataInDataBase(ThalibLoginModel value){
    responseData = ThalibheDataBaseModel(
     talibIlmId: value.data.talibIlmId,
     token: value.data.token
     
    );
    if (Global.thalibheLoginSave) {
      authProvider.setThalibheData(user: responseData);
     Global.thalibheDataBaseModel = authProvider.getThalibheData();
    } else {
      Global.thalibheDataBaseModel = responseData;
    }
     
    // databaseInstance.insertThalibheData(responseData);
    // databaseInstance.getThalibDetail().then((value) {
    //   value.forEach((element) { 
    //     Global.thalibheDataBaseModel = element;
    //     print(element.username);
    //     print(element.name);
    //   });
    // } );
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
          child: Scaffold(body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return Container(
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
                            
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 10,
                                  left: 16,
                                  right: 16),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomTextfeild(
                                        hintText: 'Username',
                                        focusNode: mobileNode,
                                        validator: (value) {
                                          if (value.trim().isEmpty) {
                                            return 'Please enter Username';
                                          } 
                                          return null;
                                        },
                                        onChanged: (val) =>
                                            setState(() { 
                                              username = val;
                                              autoValidate = true;}),
                                        onEditComplete: (value) {
                                          FocusScope.of(context) .requestFocus(passwordNode);
                                             
                                        },
                                        textInputType: TextInputType.text,
                                        textInputFormatter: [
                                          new FilteringTextInputFormatter.allow(
                                              RegExp("[a-z A-Z]")),
                                        ],
                                        prefixicon: Icons.person),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: CustomTextfeild(
                                          hintText: 'Password',
                                          focusNode: passwordNode,
                                          onEditComplete: (value) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          obscureText: obscure,
                                          validator: (value) {
                                            if (value.trim().isEmpty) {
                                              return 'Please enter your password.';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) => setState((){
                                            password = val;
                                          }),
                                          suffixIcon: IconButton(
                                              icon: obscure
                                                  ? Icon(Icons.visibility_off,
                                                      color: AppColors.greyColor,)
                                                  : Icon(Icons.visibility,
                                                      color: AppColors.greyColor,),
                                              onPressed: () {
                                                setState(() {
                                                  obscure = !obscure;
                                                });
                                              }),
                                          prefixicon: Icons.vpn_key),
                                    ),
                                      Padding(
                                     padding: EdgeInsets.only(top: 10),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Checkbox(
                                          value: Global.thalibheLoginSave,
                                          activeColor: AppColors.talibhebuttonbg,
                                          onChanged: (value){
                                            setState(() {
                                              Global.thalibheLoginSave = !Global.thalibheLoginSave;
                                            });
                                          }),
                                          Text('Remember Me',style: TextStyle(fontWeight: FontWeight.w800),)
                                       ],
                                     ),
                                     ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: CustomRoundedButton(
                                        text: 'Login',
                                        onPressed: submitlogin,
                                        bgcolor: AppColors.talibhebuttonbg
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // GestureDetector(
                                          //   onTap: () => Navigator.of(context)
                                          //       .pushNamed('registration'),
                                          //   child: Text('New Registration?',
                                          //       style:  AppStyles.greenTextStyle.copyWith(
                                          //         fontWeight: FontWeight.w500,
                                          //         color: AppColors.talibhebuttonbg
                                          //       )),
                                                   
                                          // ),
                                          Text(
                                            'Forgot Password',
                                            style: AppStyles.greenTextStyle.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.talibhebuttonbg
                                                ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ))));
          })),
        ),
      ),
    );
  }
}
