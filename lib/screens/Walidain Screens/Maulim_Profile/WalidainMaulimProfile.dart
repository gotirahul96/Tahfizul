import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CustomButton.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WalidainMaulimProfile extends StatefulWidget {
  WalidainMaulimProfile({Key key}) : super(key: key);

  @override
  _WalidainMaulimProfileState createState() => _WalidainMaulimProfileState();
}

class _WalidainMaulimProfileState extends State<WalidainMaulimProfile> {
 
  bool editProfile = true;
  final _formKey = GlobalKey<FormState>();
  
  TextEditingController phoneNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController about = TextEditingController();
  @override
  void initState() {

   phoneNo.text = '9809087657';
   emailId.text = 'indo@darululoom.com';
   about.text = '''Address: No. 23-78/19, R K Anand Bagh X Roads, Street No. 3, R K Nagar Colony, Malkajgiri, Hyderabad, Telangana 500047''';
    super.initState();
  }
  void saveProfile(){
    setState(() {
      editProfile = !editProfile;
    });
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
                    appbarColor : AppColors.darkblue,   
                    icontheme: IconThemeData(
                    color: Colors.white, //change your color here
                    ),    
                    ),
                    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
                    body: LayoutBuilder(builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return Container(
                          width: double.infinity,                          
                          child: SingleChildScrollView(
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: viewportConstraints.maxHeight,
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(                                        
                                          children: [
                                            Container(
                                              height: SizeConfig.safeBlockVertical* 10,
                                              color: AppColors.darkblue,
                                            ),
                                            
                                          ]),
                                          Positioned(
                                            right: 0,
                                            left: 0,
                                            top: SizeConfig.safeBlockVertical * 3,
                                            child: Column(
                                              children: [
                                                Container(
                                                         child: Image.asset('assets/images/Moulvi.png',
                                                          height: 100,
                                                          width: 100,                      
                                                         ),
                                                  ),
                                                  Container(
                                             padding : EdgeInsets.only(left :12,right: 12,bottom: 12),
                                             child: Column(
                                             mainAxisAlignment:  MainAxisAlignment.center,                                            
                                             crossAxisAlignment: CrossAxisAlignment.center,   
                                             mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(padding: EdgeInsets.only(
                                                    top: SizeConfig.safeBlockVertical * 7.5),
                                                    child: Text('Abdul Gaffar',style: AppStyles.mediumtitleTextStyle.copyWith(
                                                      color: AppColors.darkblue,
                                                      fontSize: 25),),
                                                    ),
                                                    Padding(padding: EdgeInsets.only(top: 5),
                                                    child: Text('Hydrabad,India',
                                                    style: AppStyles.mediumtitleTextStyle.copyWith(
                                                      color: AppColors.darkblue,
                                                      fontWeight: FontWeight.normal)),
                                                    ),
                                                    
                                                    Divider(color: AppColors.greyColor,),
                                                    Padding(padding: EdgeInsets.only(top: 10),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: Form(
                                                        key: _formKey,
                                                          child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Opacity( 
                                                            opacity: editProfile ? 0.5: 1.0 ,
                                                            child: Text('Address :',
                                                            style: AppStyles.mediumtitleTextStyle.copyWith(
                                                              color: AppColors.darkblue,
                                                              fontSize: 25,),)),
                                                            Opacity(
                                                              opacity: editProfile ? 0.5: 1.0,
                                                              child: TextFormField(
                                                              //style: AppStyles.mediumtitleTextStyle,
                                                              controller: about,
                                                              maxLines: null,
                                                              readOnly: editProfile,
                                                              textAlign: TextAlign.justify,
                                                              decoration: InputDecoration(
                                                                border: InputBorder.none,
                                                                isDense: true,
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                              ),
                                                            ),
                                                              ),
                                                           
                                                             TextFormField(
                                                              style: AppStyles.mediumtitleTextStyle.copyWith(color: AppColors.darkblue),
                                                              controller: emailId,
                                                              readOnly: editProfile,
                                                              textAlign: TextAlign.center,
                                                              decoration: InputDecoration(
                                                                isDense: true,
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                                border: InputBorder.none
                                                              ),
                                                            ),
                                                             TextFormField(
                                                              style: AppStyles.mediumtitleTextStyle.copyWith(color: AppColors.darkblue),
                                                              controller: phoneNo,
                                                              readOnly: editProfile,
                                                              textAlign: TextAlign.center,
                                                              decoration: InputDecoration(
                                                                isDense: true,
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                                border: InputBorder.none
                                                              ),
                                                            ),
                                                          //   Padding(
                                                          //   padding: EdgeInsets.only(top: 20),
                                                          //   child: CustomRoundedButton(
                                                          //   text: editProfile ? 'Edit Profile' : 'Save Profile',
                                                          //   onPressed: saveProfile,
                                                          //   bgcolor: AppColors.darkblue,
                                                          //  ),
                                                          //  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    )
                                                ],
                                              ),
                                            )
                                              ],
                                            ),)
                                    ],
                                  ))));})))));
   
  }
}