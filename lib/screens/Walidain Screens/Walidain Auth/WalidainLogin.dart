import 'package:Tahfizul/data/models/Walidain_Models/WalidainLogin.dart';
import 'package:Tahfizul/services/DataBaseFile.dart';
import 'package:Tahfizul/services/WalidainDataBaseModel.dart';
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

class WalidainLogin extends StatefulWidget {
  WalidainLogin({Key key}) : super(key: key);

  @override
  _WalidainLoginState createState() => _WalidainLoginState();
}

class _WalidainLoginState extends State<WalidainLogin> {
 final _formKey = GlobalKey<FormState>();
  FocusNode mobileNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  static bool obscure = false;
  static bool autoValidate = false;
  String mobileNo = '';
  String password = '';
  WalidainDataBaseModel responseData;
  AuthProvider authProvider = AuthProvider();
  @override
  void initState() {
   
    super.initState();
  }
 

   void submitlogin() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
     showWait(context,AppColors.darkblue);
     fetchWalidainLoginCredentials(mobileNo,password).then((value) {
       
       if (value.status == true) {
         saveDataInDataBase(value);
         Navigator.pop(context, showWait);
         Navigator.of(context).pushNamed('walidaindashboard');
       }
       if (value.status == false) {
         Navigator.pop(context, showWait);
         Toast.show(value.message, context);
       }
     });
    }
  }

  void saveDataInDataBase(WalidainLoginModel value){
     responseData = WalidainDataBaseModel(
           walidainId: value.data.walidainId,
           token: value.data.token,
           
         );
         if (Global.walidainLoginSave) {
            authProvider.setWalidainData(user: responseData);
         Global.walidainDatabaseModel = authProvider.getWalidainData();
         } else {
           Global.walidainDatabaseModel = responseData;
         }
        
        //  _databaseInstance.insertUserData(responseData);
        //  _databaseInstance.getAllDetail().then((value) {
        //    value.forEach((element) { 
        //      Global.walidainDatabaseModel = element;
        //      print(Global.walidainDatabaseModel);
        //    });
        //  });
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
                                        hintText: 'mobileNo',
                                        focusNode: mobileNode,
                                        autovalidate: autoValidate,
                                        validator: (value) {
                                          if (value.trim().isEmpty) {
                                            return 'Please Enter your mobileNo.';
                                          } 
                                          return null;
                                        },
                                        onChanged: (val) =>
                                            setState(() {
                                              autoValidate = true;
                                              mobileNo = val;
                                            }),
                                        onEditComplete: (value) {
                                          FocusScope.of(context) .requestFocus(passwordNode);
                                             
                                        },
                                        maxLength: 10,
                                        textInputType: TextInputType.phone,
                                        textInputFormatter: [
                                          new FilteringTextInputFormatter.allow(
                                              RegExp("[0-9]")),
                                        ],
                                        prefixicon: Icons.phone_iphone),
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
                                          onChanged: (val) =>
                                            setState(() {
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
                                          value: Global.walidainLoginSave,
                                          activeColor: AppColors.darkblue,
                                          onChanged: (value){
                                            setState(() {
                                              Global.walidainLoginSave = !Global.walidainLoginSave;
                                            });
                                          }),
                                          Text('Remember Me',style: TextStyle(fontWeight: FontWeight.w800),)
                                       ],
                                     ),
                                     ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: CustomRoundedButton(
                                        text: 'Login',
                                        onPressed: submitlogin,
                                        bgcolor: AppColors.darkblue,
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
                                          //       style:
                                          //           AppStyles.greenTextStyle.copyWith(
                                          //             color: AppColors.darkblue,
                                          //             fontWeight: FontWeight.w500)),
                                          // ),
                                          Text(
                                            'Forgot Password',
                                            style: AppStyles.greenTextStyle.copyWith(
                                              color: AppColors.darkblue,
                                              fontWeight: FontWeight.w500),
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