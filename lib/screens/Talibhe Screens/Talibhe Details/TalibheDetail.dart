import 'dart:io';

import 'package:Tahfizul/data/models/GetCountry.dart';
import 'package:Tahfizul/data/models/GetState.dart';
import 'package:Tahfizul/data/models/Talibhe_Models/TalibheDetails.dart';
import 'package:Tahfizul/data/models/Talibhe_Models/updateDetails/UpdateThalibDetails.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CustomButton.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class TalibheDetails extends StatefulWidget {
  TalibheDetails({Key key}) : super(key: key);

  @override
  _TalibheDetailsState createState() => _TalibheDetailsState();
}

class _TalibheDetailsState extends State<TalibheDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  String image = '';
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  bool editProfile = true;
  File _image;
  File croppedFile;
  File result;
  bool makeVisible = false;
  ThalibheDetails _thalibheDetails = ThalibheDetails();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
   initData();
    super.initState();
  }
  initData(){
    setState(() => Global.isLoading = true);
    fetchthalibheDetails(Global.thalibheDataBaseModel.talibIlmId).then((value) {
      setState(() {
        Global.isLoading = false;
        _thalibheDetails = value;
        name.text = value.data.name;
        username.text = value.data.username;
        image = value.data.image;
        email.text = value.data.email;
        address.text = value.data.address;
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
              toolbarColor: Colors.deepOrange,
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
      uploadThalibFileFromDio(name.text,Global.thalibheDataBaseModel.talibIlmId , _image).then((value) {
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
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.buttonBg,
        progressIndicator: AppLoader(
          loaderColor : AppColors.talibheappbarColor
        ),
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
                child: Scaffold(               
                    appBar: AppBarLayout(
                      titleColor: AppColors.whiteColor,
                    appBarTitle: 'Talibe llm Details',
                    appbarColor: AppColors.talibheappbarColor,
                    icontheme: IconThemeData(
                    color: Colors.white, //change your color here
                    ),),
                    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,                   
                    body: LayoutBuilder(builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return Form(
                          key: _formKey,
                          child: Padding(
                         padding : EdgeInsets.only(left :12,right: 12,top: 15),
                          child: SingleChildScrollView(
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: viewportConstraints.maxHeight,
                                  ),
                                  child: Column(
                                   mainAxisAlignment:  MainAxisAlignment.start,                                       
                                   crossAxisAlignment:  CrossAxisAlignment.start, 
                                   mainAxisSize: MainAxisSize.max,
                                   children: [
                                     Center(
                                       child: GestureDetector(
                                                onTap: () => editProfile ? 
                                                    null : imageModalBottomSheet(context)
                                                ,
                                                child: _image != null  ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(45),
                                                child : Image.file(_image,height: 90,fit: BoxFit.cover,
                                                width: 90,)
                                              ):Container(
                                                height: 90,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(45)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(image),
                                                        fit: BoxFit.cover)),
                                                child: Text(' '),
                                              ),
                                       ),
                                     ),
                                    Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: TextFormField(
                                                      style: AppStyles.mediumtitleTextStyle,
                                                       controller: name,
                                                      readOnly: editProfile,
                                                        textAlign: TextAlign.start,
                                                          decoration: InputDecoration(
                                                          prefixText: 'Name :-       ',
                                                         isDense: true,
                                                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                           border: InputBorder.none
                                                             ),
                                                              ),
                                    ),
                                    Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: TextFormField(
                                                      style: AppStyles.mediumtitleTextStyle,
                                                       controller: username,
                                                      readOnly: editProfile,
                                                        textAlign: TextAlign.start,
                                                          decoration: InputDecoration(
                                                          prefixText: 'UserName :-       ',
                                                         isDense: true,
                                                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                           border: InputBorder.none
                                                             ),
                                                              ),
                                    ),
                                    Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: TextFormField(
                                                      style: AppStyles.mediumtitleTextStyle,
                                                       controller: address,
                                                      readOnly: editProfile,
                                                        textAlign: TextAlign.start,
                                                          decoration: InputDecoration(
                                                          prefixText: 'Address :-       ',
                                                         isDense: true,
                                                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                           border: InputBorder.none
                                                             ),
                                                              ),
                                    ),
                                    
                                    Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: TextFormField(
                                                      style: AppStyles.mediumtitleTextStyle,
                                                       controller: email,
                                                      readOnly: editProfile,
                                                        textAlign: TextAlign.start,
                                                          decoration: InputDecoration(
                                                          prefixText: 'Email :-       ',
                                                         isDense: true,
                                                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                           border: InputBorder.none
                                                             ),
                                                              ),
                                    ),
                                     Padding(
                                               padding: EdgeInsets.only(top: 20),
                                                     child: CustomRoundedButton(
                                                      bgcolor: AppColors.talibheappbarColor,
                                                      text: editProfile ? 'Edit Profile' : 'Save Profile',
                                                       onPressed: saveProfile,
                                                             ),
                                                             ),
                                   ])))),
                      );}))))
    );
  }
}