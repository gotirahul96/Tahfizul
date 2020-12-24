import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CustomButton.dart';
import 'package:Tahfizul/widgets/CustomTextFeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class Registration extends StatefulWidget {
  Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  FocusNode nameNode = FocusNode();
  FocusNode mobileNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode madarsaNode = FocusNode();
  String name = '';
  String mobileNo = '';
  String password = '';
  String cPassword = '';
  String madarsa = '';
  bool termsCondition = false;
  bool autoValidateM = false;
  bool cPautoValidate = false;
  bool obscure = true;
  bool obscureCP = true;
  void submitRegistration() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate() && termsCondition) {
      Navigator.of(context).pushNamed('dashBoard_home');
    } else if (!termsCondition) {
      setState(() {
        termsCondition = false;
        Toast.show("Please Agree to 'Terms & Conditions", context, duration: Toast.LENGTH_LONG,
         gravity:  Toast.BOTTOM);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      //progressIndicator: AppLoader(),
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
                            Stack(
                              children: [
                                Container(
                                  height: SizeConfig.safeBlockVertical * 25,
                                  width: SizeConfig.screenWidth,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: ExactAssetImage(
                                            'assets/images/top-bg.png',
                                          ),
                                          fit: BoxFit.cover)),
                                  child: Text(' '),
                                ),
                                Positioned(
                                  top: SizeConfig.blockSizeVertical * 2,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: ExactAssetImage(
                                                    'assets/images/Moulvi.png',
                                                  ),
                                                  fit: BoxFit.cover)),
                                          child: Text(' '),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical),
                                          child: Text(
                                            'Maulim Registration',
                                            style: AppStyles.whiteTextStyle,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 3,
                                  left: 16,
                                  right: 16),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: CustomTextfeild(
                                          hintText: 'Name',
                                          text: name,
                                          focusNode: nameNode,
                                          onEditComplete: (value) {
                                            FocusScope.of(context)
                                                .requestFocus(mobileNode);
                                          },
                                          onChanged: (val) =>
                                              setState(() => name = val),
                                          validator: (value) {
                                            if (value.trim().isEmpty) {
                                              return 'Please enter your Name';
                                            }
                                            return null;
                                          },
                                          prefixicon: Icons.person_pin),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: CustomTextfeild(
                                          hintText: 'Mobile Number',
                                          focusNode: mobileNode,
                                          maxLength: 10,
                                          autovalidate: autoValidateM,
                                          validator: (value) {
                                            if (value.trim().isEmpty) {
                                              return 'Please Enter Mobile No';
                                            } else if (value.trim().length >
                                                    10 ||
                                                value.trim().length < 10) {
                                              return 'Please Enter Valid Mobile no.';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) {
                                            setState(() {
                                              mobileNo = val;
                                              autoValidateM = true;
                                            });
                                          },
                                          onEditComplete: (value) {
                                            FocusScope.of(context)
                                                .requestFocus(passwordNode);
                                          },
                                          textInputType: TextInputType.phone,
                                          textInputFormatter: [
                                            new FilteringTextInputFormatter
                                                .allow(RegExp("[0-9]")),
                                          ],
                                          prefixicon: Icons.phone_iphone),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: CustomTextfeild(
                                          hintText: 'Password',
                                          focusNode: passwordNode,
                                          obscureText: obscure,
                                          validator: (value) {
                                            if (value.trim().isEmpty) {
                                              return 'Please enter your password.';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) =>
                                              setState(() => password = val),
                                          suffixIcon: IconButton(
                                              icon: obscure
                                                  ? Icon(Icons.visibility_off,
                                                      color: Color.fromRGBO(
                                                          214, 204, 205, 1))
                                                  : Icon(Icons.visibility,
                                                      color: Color.fromRGBO(
                                                          214, 204, 205, 1)),
                                              onPressed: () {
                                                setState(() {
                                                  obscure = !obscure;
                                                });
                                              }),
                                          onEditComplete: (value) {
                                            FocusScope.of(context).requestFocus(
                                                confirmPasswordNode);
                                          },
                                          prefixicon: Icons.vpn_key),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: CustomTextfeild(
                                          hintText: 'Confirm Password',
                                          focusNode: confirmPasswordNode,
                                          obscureText: obscureCP,
                                          autovalidate: cPautoValidate,
                                          validator: (value) {
                                            if (value.trim().isEmpty) {
                                              return 'Please enter your password.';
                                            } else if (password.trim() !=
                                                cPassword) {
                                              return 'Password Does not Match.';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) {
                                            setState(() {
                                              cPassword = val;
                                              cPautoValidate = true;
                                            });
                                          },
                                          onSaved: (val) =>
                                              setState(() => cPassword = val),
                                          suffixIcon: IconButton(
                                              icon: obscureCP
                                                  ? Icon(Icons.visibility_off,
                                                      color: Color.fromRGBO(
                                                          214, 204, 205, 1))
                                                  : Icon(Icons.visibility,
                                                      color: Color.fromRGBO(
                                                          214, 204, 205, 1)),
                                              onPressed: () {
                                                setState(() {
                                                  obscureCP = !obscureCP;
                                                });
                                              }),
                                          onEditComplete: (value) {
                                            FocusScope.of(context)
                                                .requestFocus(madarsaNode);
                                          },
                                          prefixicon: Icons.lock),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: CustomTextfeild(
                                          hintText: 'Madarsa',
                                          focusNode: madarsaNode,
                                          onEditComplete: (value) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          validator: (val) {
                                            if (val.trim().isEmpty) {
                                              return 'Please enter the Madarsa';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) =>
                                              setState(() => madarsa = val),
                                          prefixicon: Icons.terrain),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Terms and Conditions",
                                                style: AppStyles.blackTextStyle,
                                              ),
                                              Checkbox(
                                                value: termsCondition,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    termsCondition = newValue;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: CustomRoundedButton(
                                        text: 'Register Now',
                                        onPressed: submitRegistration,
                                      ),
                                    ),
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
