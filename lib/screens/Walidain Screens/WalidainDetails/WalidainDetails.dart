//top-bg_thalibe-ilm

import 'dart:io';

import 'package:Tahfizul/data/models/Talibhe_Models/TalibheDetails.dart';
import 'package:Tahfizul/data/models/Walidain_Models/WalidainDetails.dart';
import 'package:Tahfizul/data/models/Walidain_Models/updateDetails/UpdateWalidainDetails.dart';
import 'package:Tahfizul/data/models/madarsaDetails.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/util/validators/validators.dart';
import 'package:Tahfizul/widgets/CustomButton.dart';
import 'package:Tahfizul/widgets/CustomTextFeild.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class WalidainDetails extends StatefulWidget {
  WalidainDetails({Key key}) : super(key: key);

  @override
  _WalidainDetailsState createState() => _WalidainDetailsState();
}

class _WalidainDetailsState extends State<WalidainDetails> {
  final _formKey = GlobalKey<FormState>();
  FocusNode nameNode = FocusNode();
  FocusNode mobileNode = FocusNode();
  FocusNode emailIdNode = FocusNode();
  FocusNode thalibeNameNode = FocusNode();
  FocusNode madarsaNode = FocusNode();
  FocusNode courseNode = FocusNode();
  FocusNode addressNode = FocusNode();
  String name = '';
  String mobileNo = '';
  String emailId = '';
  String thalibeName = '';
  String madarsa = '';
  int madarsaId = 0 ;
  String image = '';
  String course = '';
  TextEditingController address = TextEditingController();
  bool autoValidateM = false;
  bool cPautoValidate = false;
  bool obscure = true;
  bool obscureCP = true;
  File _image;
  File croppedFile;
  File result;
  bool makeVisible = false;
  bool editProfile = true;
  
  @override
  void initState() {
    initData();
    print(Global.walidainDatabaseModel.walidainId);
    print('This is run');
    super.initState();
  }
  initData(){
    setState(() => Global.isLoading = true);
   
    fetchWalidainDetails(Global.walidainDatabaseModel.walidainId).then(
      (value){
        if (value.status == true) {
          setState(() => Global.isLoading = false);
          name = value.data.name;
          mobileNo = value.data.mobile;
          emailId = value.data.email;
          address.text = value.data.address;
          madarsa = value.data.madarsaId.toString();
          image = value.data.image;
        }
        
      }
     );
    //  madarsaDetails(madarsaId).then((value) {
    //    madarsa = value.data.name;
    //  });
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
      uploadwalidainFileFromDio(name,Global.walidainDatabaseModel.walidainId, _image).then((value) {
        setState(()=> Global.isLoading = false);
        if (value.message == 'Success') {
          Toast.show('Update Successful', context);
        }
        else {
          setState(()=> Global.isLoading = false);
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
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            
            body: LayoutBuilder(builder:
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
                                  height: SizeConfig.safeBlockVertical * 27,
                                  width: SizeConfig.screenWidth,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: ExactAssetImage(
                                            'assets/images/top-bg_thalibe-ilm.png',
                                          ),
                                          fit: BoxFit.cover)),
                                  child: Text(' '),
                             ),
                              AppBarLayout(
                             appbarColor: Colors.transparent,
                             titleColor: AppColors.darkColor,
                             icontheme: IconThemeData(
                             color: Colors.white, //change your color here
                             ),),
                                Positioned(
                                  top: SizeConfig.blockSizeVertical * 2,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Column(
                                      children: [
                                      GestureDetector(
                                         onTap: () => editProfile ? 
                                                    null : imageModalBottomSheet(context),                                   
                                           child:  _image != null  ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(45),
                                                child : Image.file(_image,height: 90,fit: BoxFit.cover,
                                                width: 90,)
                                              ): image != null ?  Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(45)),
                                                image: DecorationImage(
                                                    image: NetworkImage(image),
                                                    fit: BoxFit.cover)),
                                          child: Text(' '),
                                        ) :   Container(
                                                           child: Image.asset('assets/images/Moulvi.png',
                                                            height: 100,
                                                            width: 100,                      
                                                           ),
                                                     ),
                                      ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical),
                                          child: Text(
                                            name,
                                            style: AppStyles.whiteTextStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22
                                            ),
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
                                  right: 16,
                                  bottom: 16),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: CustomTextfeild(
                                          hintText: 'Name',
                                          text: name,
                                          readOnly: editProfile,
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
                                          readOnly: editProfile,
                                          text: mobileNo,
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
                                                .requestFocus(emailIdNode);
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
                                          hintText: 'Email Id',
                                          focusNode: emailIdNode,
                                          readOnly: editProfile,
                                          text: emailId,
                                          validator: (value) {
                                            if (value.trim().isEmpty) {
                                              return 'Please enter your emailId.';
                                            }
                                            return Validators.mustEmail(value);
                                            
                                          },
                                          onChanged: (val) =>
                                              setState(() => emailId = val),
                                          
                                          onEditComplete: (value) {
                                            FocusScope.of(context).requestFocus(
                                                thalibeNameNode);
                                          },
                                          prefixicon: Icons.vpn_key),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: CustomTextfeild(
                                          hintText: 'Thalibe llm Name',
                                          focusNode: thalibeNameNode,
                                          readOnly: editProfile,
                                          text: thalibeName,
                                          autovalidate: cPautoValidate,
                                          validator: (value) {
                                            if (value.trim().isEmpty) {
                                              return 'Please enter your emailId.';
                                            } else if (emailId.trim() !=
                                                thalibeName) {
                                              return 'emailId Does not Match.';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) {
                                            setState(() {
                                              thalibeName = val;
                                              cPautoValidate = true;
                                            });
                                          },
                                          onSaved: (val) =>
                                              setState(() => thalibeName = val),
                                          
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
                                          text: madarsa,
                                          focusNode: madarsaNode,
                                          readOnly: editProfile,
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
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: CustomTextfeild(
                                          hintText: 'Course',
                                          readOnly: editProfile,
                                          text: course,
                                          focusNode: courseNode,
                                          onEditComplete: (value) {
                                            FocusScope.of(context)
                                                .requestFocus(addressNode);
                                          },
                                          onChanged: (val) =>
                                              setState(() => name = val),
                                          validator: (value) {
                                            if (value.trim().isEmpty) {
                                              return 'Please enter your Course';
                                            }
                                            return null;
                                          },
                                          prefixicon: Icons.book),
                                    ),
                                    Padding(
                                       padding: const EdgeInsets.only(top: 10.0),
                                       child: TextFormField(
                                         focusNode: addressNode,
                                         maxLines: 5,
                                         controller: address,
                                         readOnly: editProfile,
                                         decoration: InputDecoration(
                                           hintText: 'Waliden Address',
                                           filled: true,
                                           fillColor: AppColors.greyColor.withOpacity(0.3),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                         ),
                                       ),
                                    ),
                                    Padding(
                                                            padding: EdgeInsets.only(top: 20),
                                                            child: CustomRoundedButton(
                                                              bgcolor: AppColors.darkblue,
                                                            text: editProfile ? 'Edit Profile' : 'Save Profile',
                                                            onPressed: saveProfile,
                                                           ),
                                                           ),
                                  ],
                                ),
                              ),
                            ),
                             
                          ],
                        ))));
          })),
        ),
      ),
    );
  }
}
