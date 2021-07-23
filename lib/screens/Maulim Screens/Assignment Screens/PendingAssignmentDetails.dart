import 'dart:collection';
import 'dart:io';
import 'package:Tahfizul/widgets/CustomButton.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:Tahfizul/data/models/Walidain_Models/Assignment.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:Tahfizul/widgets/appbar_layout.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class PendingAssignmentDetails extends StatefulWidget {
  PendingAssignmentDetails({Key key}) : super(key: key);

  @override
  _PendingAssignmentDetailsState createState() => _PendingAssignmentDetailsState();
}

class _PendingAssignmentDetailsState extends State<PendingAssignmentDetails> {
 
  Directory _downloadsDirectory;
  double progress = 0;
  String progressString = '';
  ProgressDialog pr;
   String id  = '';
   bool downloading = false;
   TextEditingController remarks = TextEditingController();
 
   @override
   void initState() { 
     super.initState();
      initDownloadAlert();
     initDownloadsDirectoryState();
   }
   _launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
 }
   downloadFile(String apkUrl,String filename) async{
    final status = await Permission.storage.request();
    print( _downloadsDirectory.path);
    if (status.isGranted) {
  
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();
      print("path ${dir.path}");
      pr.show();
      await dio.download(apkUrl, "${_downloadsDirectory.path}/demo.mp4",
          onReceiveProgress: (rec, total) {
        
        print("Rec: $rec , Total: $total");
        setState(() {
          downloading = true;
          progress = ((rec / total) * 100).roundToDouble();
          updateAlert(progress);
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          print(progressString);
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      pr.hide();
      Toast.show('Video Downlaoded.Please Check you Downlaod Folder', context);
      progressString = "Completed";
    });
    print("Download completed");
  
    } else {
      print('No Permission');
    }
  } 
  
    // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initDownloadsDirectoryState() async {
    Directory downloadsDirectory;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS).then((value){
        downloadsDirectory =  Directory(value);
      });
    } on PlatformException {
      print('Could not get the downloads directory');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _downloadsDirectory = downloadsDirectory;
      print(_downloadsDirectory);
    });
  }

    downloadAlert(String apkUrl,String filename){
    return showDialog(
  context: context,
  builder: (BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
       
        return AlertDialog( 
          actionsPadding:  EdgeInsets.zero,
          contentPadding: EdgeInsets.all(15),
          titlePadding: EdgeInsets.only(bottom: 0,left: 20,top: 20,right: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
        actions: [
         FlatButton(
          onPressed: () { 
            Navigator.of(context).pop();
           },
          child: Text('No'),),
          FlatButton(
          onPressed: () { 
            setState(() {
              progress = 0;
            });
            Navigator.of(context).pop();
            downloadFile(apkUrl , filename);
           },
          child: Text('Yes'),),
        ],
        title :  Text('Do you want to download the File?',style: AppStyles.blackTextStyle,)
        
      );
      },     
    );
  },
);
}
initDownloadAlert(){
    pr = new ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: true);
    pr.style(
  message: 'Please wait...',
  borderRadius: 10.0,
  backgroundColor: Colors.white,
  progressWidget: CircularProgressIndicator(),
  elevation: 10.0,
  insetAnimCurve: Curves.easeInOut,
  progress: 0.0,
  maxProgress: 100.0,
  progressTextStyle: TextStyle(
     color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  messageTextStyle: TextStyle(
     color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );
}
updateAlert(double progress){
pr.update(
  progress:  progress,
  message: "Downloading file...",
  progressWidget: CircularProgressIndicator(),
  maxProgress: 100.0,
  progressTextStyle: TextStyle(
    color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  messageTextStyle: TextStyle(
    color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
  );
   }
  

   _displayDialog(BuildContext context) async {
      final _formKey = GlobalKey<FormState>();
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0, 24, 0, 24),
            title: Text(' '),
            content: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 180,
              width: double.infinity,
              //color: AppColors.driverprimaryColor,
              child: Form(
                  key: _formKey,
                  child: Column(
                  children: [
                    TextFormField(
                      controller: remarks,
                      textInputAction: TextInputAction.go,
                      maxLines: 5,
                      style: TextStyle(
                                      
                                      color: AppColors.darkColor,
                                      fontSize: 22
                                    ),
                      validator: (val){
                        if (val.trim().isEmpty) {
                          return 'Please enter the details.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Remarks",
                        labelStyle: TextStyle(                                    
                                         fontWeight: FontWeight.w600,
                                         fontSize: 20,
                                         color: AppColors.appBarColor
                                       ),
                                       border: OutlineInputBorder(
                                         borderSide: BorderSide(color: AppColors.appBarColor)
                                       ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL',
                style: TextStyle(
                                       
                                       fontWeight: FontWeight.w600,
                                       fontSize: 17,
                                       color: AppColors.appBarColor
                                     ),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('SUBMIT',
                style: TextStyle(
                                       
                                       fontWeight: FontWeight.w600,
                                       fontSize: 17,
                                       color: AppColors.appBarColor
                                     ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
    final LinkedHashMap<String, WalidainPendingAssignmentModel> args =
        ModalRoute.of(context).settings.arguments;
    final assignmentDetails = args['assignmentDetails'];
    DateTime now = DateFormat("yyyy-MM-dd hh:mm:ss").parse(assignmentDetails.assignedDate);
    
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.buttonBg,
        progressIndicator: AppLoader(),
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
                child: Scaffold(               
                    appBar: AppBarLayout(
                    appbarColor: AppColors.lightestGreyColor,
                    icontheme: IconThemeData(
                    color: Colors.black, //change your color here
                    ),),
                    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,                   
                    body: LayoutBuilder(builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return Padding(
                       padding : EdgeInsets.only(left :12,right: 12),
                        child: SingleChildScrollView(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: viewportConstraints.maxHeight,
                                ),
                                child: Column(
                                 mainAxisAlignment:  MainAxisAlignment.spaceBetween,                                       
                                 //crossAxisAlignment:  CrossAxisAlignment.start, 
                                 mainAxisSize: MainAxisSize.max,
                                 children: [
                                   Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             Column(
                mainAxisAlignment:  MainAxisAlignment.start,                                       
                                 crossAxisAlignment:  CrossAxisAlignment.start, 
                                 mainAxisSize: MainAxisSize.max,
               children: [
                    Padding(
                    padding: const EdgeInsets.only(top :8.0),
                    child: assignmentDetails.status == 'Completed' ? 
                     Text('COMPLETED',style: 
                                          AppStyles.greenTextStyle.copyWith(
                                            color: AppColors.appBarColor,
                                            fontSize: 25,fontWeight: FontWeight.w500),)
                     : Text('PENDING',style: AppStyles.greenTextStyle.copyWith(
                    fontSize: 25,fontWeight: FontWeight.w500),),
                    ),
                    Text('ASSIGNMENTS',
                    style: AppStyles.greenTextStyle.copyWith(
                    color: AppColors.darkColor,fontSize: 25),),
            Padding(
              padding: const EdgeInsets.only(top : 15.0),
              child: Card(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        ),
        color: assignmentDetails.status == 'Pending' ? AppColors.whiteColor :  AppColors.whiteColor,
        child: Container(
          child: Column(
            children: [
                Container(  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                    ),
                    color: assignmentDetails.status == 'Pending' ? AppColors.appBarColor : AppColors.appBarColor ,
                  ),
                  child: Padding(
                     padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('Class ${assignmentDetails.courseId}  ( PARA - ${assignmentDetails.paraId})',
                            style: AppStyles.blackTextStyle.copyWith(
                            color: AppColors.whiteColor ,
                            fontWeight:FontWeight.w500 
                            ),),
                          ],
                        ),
                        Icon(
                        Icons.av_timer ,
                        size: 30,
                        color:  AppColors.whiteColor,)
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Slot No : ${assignmentDetails.name}',style: AppStyles.greenTextStyle,),
                        Padding(
                          padding: const EdgeInsets.only(top : 5.0),
                          child: Text('Assignment Type - ${assignmentDetails.type}',style: AppStyles.greenTextStyle,),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(top : 5.0),
                          child: Text(assignmentDetails.description,style: AppStyles.greenTextStyle,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top : 5.0),
                          child: Text('Status - ${assignmentDetails.status}',style: AppStyles.greenTextStyle,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top : 5.0),
                          child: Text('Assign Date - ${DateFormat.yMMMMd().format(now)}',style: AppStyles.greenTextStyle,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top : 5.0),
                          child: Text('About Assignment - ${assignmentDetails.description}',style: AppStyles.greenTextStyle,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top : 5.0),
                          child: Text('Moulim - ${assignmentDetails.mualemName}',
                          style: AppStyles.greenTextStyle.copyWith(color: AppColors.orangeColor),),
                        ),
                        GestureDetector(
                          child:  Icon(Icons.play_circle_outline,size: 60,
                           color:  assignmentDetails.status == 'Pending' ? AppColors.appBarColor : AppColors.appBarColor,
                           ),
                           onTap: (){_launchURL(assignmentDetails.file);}
                        ),
                       
                        Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                        assignmentDetails.status == 'Pending' ?Container() :    IconButton(
                            icon: Icon(Icons.file_download,
                             color:  assignmentDetails.status == 'Pending' ? AppColors.appBarColor: AppColors.appBarColor,
                             size: 30,
                            ), 
                            onPressed: (){
                              downloadAlert(assignmentDetails.submittedFile,'test');
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
             
            ],
          ),
        )),
      ),
               ],
             ),
        
        ],
       ),
       assignmentDetails.status == 'Pending' ? Container() : Padding(
          padding: const EdgeInsets.only(bottom : 12.0),
          child: CustomRoundedButton(
            text: 'Submit',
            bgcolor: AppColors.appBarColor,
            onPressed: (){
               _displayDialog(context);
            },
          ),
        )
                                 ]))));}))))
    );
  }
}