import 'package:Tahfizul/data/models/Moulim_Models/MoulimLogin.dart';
import 'package:Tahfizul/services/DataBaseFile.dart';
import 'package:Tahfizul/services/MoulimDataBaseModel.dart';
import 'package:Tahfizul/util/AuthProvider.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CustomButton.dart';
import 'package:Tahfizul/widgets/CustomTextFeild.dart';
import 'package:Tahfizul/widgets/FullSreenLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class MoulimLogin extends StatefulWidget {
  MoulimLogin({Key key}) : super(key: key);

  @override
  _MoulimLoginState createState() => _MoulimLoginState();
}

class _MoulimLoginState extends State<MoulimLogin> {
  final _formKey = GlobalKey<FormState>();
  String mobileNo = '';
  String password = '';
  FocusNode mobileNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  static bool obscure = false;
  static bool autoValidate = false;
  MoulimDataBaseModel responseData;
  AuthProvider authProvider = AuthProvider();
  @override
  void initState() {
    //databaseInstance.moulimdatabase;
    super.initState();
  }
 
  void submitlogin() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
     setState(() =>  Global.isLoading = true);
     showWait(context,AppColors.appBarColor);    
     fetchmoulimLoginCredentials(mobileNo,password).then((value) {
       setState(() =>  Global.isLoading = false);
       if (value.status == true) {
         saveDataInDataBase(value);
         Navigator.pop(context, showWait);
         Navigator.of(context).pushNamed('dashBoard_home');
       }
       if (value.status == false) {
         setState(() =>  Global.isLoading = false);
         Navigator.pop(context, showWait);
         Toast.show(value.message, context);
       }
     });
    }
  }

  void saveDataInDataBase(MoulimLoginModel value){
    responseData = MoulimDataBaseModel(
     mualemId: value.data.mualemId,
     token: value.data.token
     
    );
    if (Global.moulimLoginSave) {
      authProvider.setMoulimData(user: responseData);
    Global.moulimDataBaseModel = authProvider.getmoulimData();
    } else {
      Global.moulimDataBaseModel = responseData;
    }
    
    // databaseInstance.insertMoulimData(responseData);
    // databaseInstance.getMoulimDetail().then((value) {
    //   value.forEach((element) { 
    //     Global.moulimDataBaseModel = element;
    //     print(element.name);
    //   });
    // } );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
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
                                  hintText: 'Mobile Number',
                                  text: mobileNo,
                                  focusNode: mobileNode,
                                  maxLength: 10,
                                  autovalidate: autoValidate,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'Please Enter Mobile No';
                                    } else if (value.length > 10 ||
                                        value.length < 10) {
                                      return 'Please Enter Valid Mobile no.';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) =>
                                      setState(() {
                                        autoValidate = true;
                                        mobileNo = val;
                                      } ),
                                  onEditComplete: (value) {
                                    FocusScope.of(context) .requestFocus(passwordNode);
                                       
                                  },
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
                                    text: password,
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
                                    value: Global.moulimLoginSave,
                                    activeColor: AppColors.buttonBg,
                                    onChanged: (value){
                                      setState(() {
                                        Global.moulimLoginSave = !Global.moulimLoginSave;
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
                                    //             fontWeight: FontWeight.w500)),
                                    // ),
                                    Text(
                                      'Forgot Password',
                                      style: AppStyles.greenTextStyle.copyWith(
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
      );
  }
}
