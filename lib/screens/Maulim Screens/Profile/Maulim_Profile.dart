import 'dart:io';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:Tahfizul/data/models/Moulim_Models/MoulimDetails.dart';
import 'package:Tahfizul/data/models/Moulim_Models/UpdateDetails/UpdateMoulimDetails.dart';
import 'package:Tahfizul/data/models/madarsaDetails.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CustomButton.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class Maulim_Profile extends StatefulWidget {
  Maulim_Profile({Key key}) : super(key: key);

  @override
  _Maulim_ProfileState createState() => _Maulim_ProfileState();
}

class _Maulim_ProfileState extends State<Maulim_Profile> {
  double rating = 0;
  bool editProfile = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController madarsaName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController about = TextEditingController();
  File _image;
  File croppedFile;
  File result;
  bool makeVisible = false;
  String image ;
  @override
  void initState() {
    initData();
   super.initState();
  }
  initData(){
    setState(() => Global.isLoading = true);
    
     fetchMoulimDetails(Global.moulimDataBaseModel.mualemId).then((value) {
       setState(() => Global.isLoading = false);
       if (value.status == true) {
        setState(() {
           madarsaName.text = value.data.madarsaName;
         phoneNo.text = value.data.mobile;
         emailId.text = value.data.email;
         about.text = value.data.about;
         name.text = value.data.name;
         address.text = value.data.address;
        setState(() =>  rating = double.parse(value.data.rating.toString()));
         image = value.data.image;
        });
       }
       setState(() {
         
       });
     });
  }


    getImageFile(ImageSource source) async {
    //pickImage(source: source);
    final picker = ImagePicker();
    var selectedimage = await picker.getImage(source: source);

    if (selectedimage != null) {
      croppedFile = await ImageCropper.cropImage(
          sourcePath: selectedimage.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColors.appBarColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      if (croppedFile != null) {
        File compressedFile = await FlutterNativeImage.compressImage(
            croppedFile.path,
            quality: 88,
            percentage: 80);
        print(compressedFile.lengthSync());
        setState(() {
          _image = compressedFile;
          print("This the Image $_image");
          print("This is the compressed image size :-${_image?.lengthSync()}");
          makeVisible = true;
        });
      }
    }
  }
  //Bottom Sheet
  void imageModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 150.0,
            color: Colors.white,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    label:
                        Text('Camera'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      //image = "";
                      getImageFile(ImageSource.camera);
                    },
                    heroTag: UniqueKey(),
                    icon: Icon(Icons.camera),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    label:
                        Text('Gallery'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();

                      getImageFile(ImageSource.gallery);
                    },
                    heroTag: UniqueKey(),
                    icon: Icon(Icons.photo_library),
                  ),
                )
              ],
            ),
          );
        });
  }


  void saveProfile(){
    if(editProfile == false)
    {
      setState(()=> Global.isLoading = true);
      uploadmoulimFileFromDio(name.text,Global.moulimDataBaseModel.mualemId , _image).then((value) {
        setState(()=> Global.isLoading = false);
        if (value.message == 'Success') {
          Toast.show('Update Successful', context);
        }
        else {
          Toast.show(value.message, context);
        }
      });
    }
    setState(() {
      editProfile = !editProfile;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    setState(() {
      
    });
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.buttonBg,
        progressIndicator: AppLoader(),
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
                child: Scaffold(
                    appBar: AppBarLayout(
                    appbarColor : AppColors.buttonBg,  
                    icontheme: IconThemeData(
                      color: AppColors.whiteColor
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
                                              color: AppColors.buttonBg,
                                            ),
                                           
                                          ]),
                                          Positioned(
                                            right: 0,
                                            left: 0,
                                            top: SizeConfig.safeBlockVertical * 3,
                                            child: Column(
                                              children: [
                                            GestureDetector(
                                              onTap: () => editProfile ? 
                                                    null : imageModalBottomSheet(context),    
                                                child: _image != null  ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(45),
                                                child : Image.file(_image,height: 90,fit: BoxFit.cover,
                                                width: 90,)
                                              ): image != null ?  Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(45)),
                                                image: DecorationImage(
                                                    image: NetworkImage('https://www.tahfizulquranonline.com$image'),
                                                    fit: BoxFit.cover)),
                                          child: Text(' '),
                                        ) :   Container(
                                                           child: Image.asset('assets/images/Moulvi.png',
                                                            height: 100,
                                                            width: 100,                      
                                                           ),
                                                     ),
                                            ),
                                                    Container(
                                             padding : EdgeInsets.only(left :12,right: 12,bottom: 12,top: 10),
                                             child: Column(
                                             mainAxisAlignment:  MainAxisAlignment.center,                                            
                                             crossAxisAlignment: CrossAxisAlignment.center,   
                                             mainAxisSize: MainAxisSize.max,
                                                children: [
                                                   TextFormField(
                                                              style: AppStyles.mediumtitleTextStyle,
                                                              controller: name,
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
                                                              controller: address,
                                                              readOnly: editProfile,
                                                              textAlign: TextAlign.center,
                                                              decoration: InputDecoration(
                                                                isDense: true,
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                                border: InputBorder.none
                                                              ),
                                                            ),
                                                   RatingBar(
                                                     
   initialRating: rating,
   ignoreGestures: true,
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   
   onRatingUpdate: (rating) {
     print(rating);
   }, ratingWidget: RatingWidget(full: 
   Icon(
     Icons.star,
     color: AppColors.appBarColor,
   )
   , half: Icon(
     Icons.star_half,
     color: AppColors.appBarColor,
   ), empty: Icon(
     Icons.star_border,
     color: AppColors.appBarColor,
   )),
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
                                                          //   text: editProfile ? 'Edit Profile' : 'Save Profile',
                                                          //   onPressed: saveProfile,
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