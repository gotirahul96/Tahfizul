import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CustomButton.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Follow_Maulim_Profile extends StatefulWidget {
  Follow_Maulim_Profile({Key key}) : super(key: key);

  @override
  _Follow_Maulim_ProfileState createState() => _Follow_Maulim_ProfileState();
}

class _Follow_Maulim_ProfileState extends State<Follow_Maulim_Profile> {
  double rating = 2.5;
  bool editProfile = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController madarsaName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController about = TextEditingController();
  
  @override
  void initState() {
   madarsaName.text = 'Madarsa Darul Uloom';
   phoneNo.text = '9809087657';
   emailId.text = 'indo@darululoom.com';
   about.text = '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ''';
    super.initState();
  }
  initData(){
    //Global.thalibheDataBaseModel
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
                    appbarColor : AppColors.talibhebuttonbg,  
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
                                          color: AppColors.talibhebuttonbg,
                                        ),
                                       
                                      ]),
                                      Positioned(
                                        right: 0,
                                        left: 0,
                                        top: SizeConfig.safeBlockVertical * 3,
                                        child: Column(
                                          children: [
                                            Container(
                                                   child: Image.asset('assets/images/img.png',
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
                                                child: Text('Abdul Gaffar',style: AppStyles.mediumtitleTextStyle.copyWith(fontSize: 25),),
                                                ),
                                                Padding(padding: EdgeInsets.only(top: 5),
                                                child: Text('Hydrabad,India',
                                                style: AppStyles.mediumtitleTextStyle.copyWith(fontWeight: FontWeight.normal)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 10),
                                                child: Row(
                                                mainAxisAlignment:  MainAxisAlignment.center, 
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors.orangeColor,

                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: Text(' '),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text('Available Now',style: AppStyles.blackTextStyle.copyWith(color: AppColors.lightOrangeColor),),
                                                  ],
                                                ),
                                                ),
                                                Padding(
                                                padding: EdgeInsets.only(top: 5),
                                                child: SmoothStarRating(
                                                allowHalfRating: true,
                                                 onRated: (v) {
                                                 },
                                                 starCount: 5,
                                                  rating: rating,
                                                   size: 28.0,
                                                  isReadOnly : true,                                                    
                                                   color: AppColors.appBarColor,
                                                   borderColor:  AppColors.appBarColor,
                                                   spacing:0.0
                                                 ),
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
                                                        child: Text('About :',
                                                        style: AppStyles.mediumtitleTextStyle.copyWith(fontSize: 25,),)),
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
                                                          style: AppStyles.mediumtitleTextStyle,
                                                          controller: madarsaName,
                                                          readOnly: editProfile,
                                                          textAlign: TextAlign.center,
                                                          decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            isDense: true,
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                          ),
                                                        ),
                                                        TextFormField(
                                                          style: AppStyles.mediumtitleTextStyle,
                                                          controller: phoneNo,
                                                          readOnly: editProfile,
                                                          textAlign: TextAlign.center,
                                                          decoration: InputDecoration(
                                                            isDense: true,
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                            border: InputBorder.none
                                                          ),
                                                        ),
                                                         TextFormField(
                                                          style: AppStyles.mediumtitleTextStyle,
                                                          controller: emailId,
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
                                                      //   text:  'Follow ',
                                                      //   onPressed: (){},
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