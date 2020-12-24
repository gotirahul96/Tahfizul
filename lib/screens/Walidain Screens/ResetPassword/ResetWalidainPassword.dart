import 'package:Tahfizul/data/models/Moulim_Models/ResetPassword/UpdatePassword.dart';
import 'package:Tahfizul/data/models/Moulim_Models/ResetPassword/VerifyMoulimPasswordChange.dart';
import 'package:Tahfizul/data/models/Walidain_Models/ResetPassword/VerifyWalidainPasswordchange.dart';
import 'package:Tahfizul/data/models/Walidain_Models/ResetPassword/updateWalidainPassword.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CustomButton.dart';
import 'package:Tahfizul/widgets/CustomTextFeild.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class ResetWalidainpassword extends StatefulWidget {
  ResetWalidainpassword({Key key}) : super(key: key);

  @override
  _ResetWalidainpasswordState createState() => _ResetWalidainpasswordState();
}

class _ResetWalidainpasswordState extends State<ResetWalidainpassword> {

  String userName = '';
  bool obscure = false;
  String password = '';
  String mobileNo = '';
  bool autoValidate = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initData();
  }
   initData(){
     verifyWalidainMobile(Global.globalWalidainDetails.data.mobile).then((value) {
       if (value.message == 'Success') {
         Toast.show('You can reset the password', context);
      }
      else {
        Toast.show(value.message, context);
      }
     });
    
  }
  void submitUpdate(){
    if(_formKey.currentState.validate()){
      setState(() => Global.isLoading = true);
      updateWalidainPassword(userName,password,Global.globalWalidainDetails.data.mobile).then((value) {
        setState(() => Global.isLoading = false);
        if (value.message == 'Success') {
          Toast.show('Successfully Changed', context);
          _formKey.currentState.reset();
        }
        else{
          Toast.show(value.message, context);
        }
      });
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
                      appbarColor: AppColors.darkblue,
                      titleColor: AppColors.whiteColor,
                      appBarTitle: 'Reset Password',
                      icontheme: IconThemeData(
                        color: AppColors.whiteColor
                      ),
                    ),
                    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,                  
                    body: LayoutBuilder(builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return Container(
                      width: double.infinity,
                      padding : EdgeInsets.only(left :12,right: 12,top: 12),
                      child: SingleChildScrollView(
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: viewportConstraints.maxHeight,
                              ),
                              child: Form(
                                     key: _formKey, 
                                    child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text('Please Enter Your Details'),
                                      Padding(
                                        padding: const EdgeInsets.only(top : 15.0),
                                        child: CustomTextfeild(
                                        validator: (value) {
                                            if (value.trim().isEmpty) {
                                              return 'Please enter Username';
                                            } 
                                            return null;
                                          },
                                          onChanged: (val) =>
                                              setState(() { 
                                                userName = val;
                                                }),
                                          textInputType: TextInputType.text,
                                          textInputFormatter: [
                                            new FilteringTextInputFormatter.allow(
                                                RegExp("[a-z A-Z]")),
                                          ],
                                        prefixicon: Icons.person,
                                        hintText: 'Username',
                                        ),
                                      ),
                                      
                                       Padding(
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: CustomTextfeild(
                                            hintText: 'New Password',
                                           
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
                                        padding: EdgeInsets.only(top: 20),
                                        child: CustomRoundedButton(
                                          text: 'Update Password',
                                          onPressed: submitUpdate,
                                          bgcolor: AppColors.darkblue,
                                        ),
                                      ),
                                    ]),
                              ))));}))))
    );
  }
}

