import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:Tahfizul/data/models/Walidain_Models/Assignment.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Talibhe_Assignment extends StatefulWidget {
  final WalidainPendingAssignmentModel pendingAssignment;
  final Color bgColor;
  final Color buttonColor;
  final Color textColor;
  final int index;
  Talibhe_Assignment({this.pendingAssignment, this.bgColor = AppColors.whiteColor, 
  this.buttonColor = AppColors.appBarColor, this.textColor = AppColors.orangeButton, this.index,
  
  });
  @override
  _Talibhe_AssignmentState createState() => _Talibhe_AssignmentState();
}

class _Talibhe_AssignmentState extends State<Talibhe_Assignment>  with SingleTickerProviderStateMixin {
   bool expandFlag = false;
   AnimationController _controller;
   final myFormat = DateFormat('d/MM/yy');
   Directory _downloadsDirectory;
  double progress = 0;
  String progressString = '';
  ProgressDialog pr;
   String id  = '';
   bool downloading = false;
   @override
      void initState() {
        _controller = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 200),
        );  
        super.initState();
          initDownloadAlert();
     initDownloadsDirectoryState();
      }
   @override
      void dispose() {
        _controller.dispose();
        super.dispose();
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        expandFlag = !expandFlag;
        if (expandFlag) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
        }),
        child: Card(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
        color: widget.bgColor,
        child: Column(
          children: [
            Container(  
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
                ),
                color: expandFlag ? AppColors.talibheappbarColor : AppColors.whiteColor ,
              ),
              child: Padding(
                 padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text('Class ${widget.pendingAssignment.courseId}  (PARA ${widget.pendingAssignment.paraId},RUKU ${widget.pendingAssignment.ruku})',
                        style: AppStyles.blackTextStyle.copyWith(
                        color: expandFlag ? AppColors.whiteColor : AppColors.darkColor,
                        fontWeight: expandFlag ? FontWeight.w500 : FontWeight.w400
                        ),),
                      ],
                    ),
                    Icon(
                    Icons.av_timer ,
                    size: 30,
                    color: expandFlag ? AppColors.whiteColor : AppColors.darkColor,)
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: SizeTransition(
                sizeFactor: _controller,
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Slot No : ${widget.pendingAssignment.name}',style: AppStyles.greenTextStyle,),
                      Padding(
                        padding: const EdgeInsets.only(top : 5.0),
                        child: Text('Description - ${widget.pendingAssignment.description}',style: AppStyles.greenTextStyle,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top : 5.0),
                        child: Text('Status - ${widget.pendingAssignment.status}',style: AppStyles.greenTextStyle,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top : 5.0),
                        child: Text('Moulim - ${widget.pendingAssignment.mualemName}',
                        style: AppStyles.greenTextStyle.copyWith(color: AppColors.orangeColor),),
                      ),
                            Padding(padding: EdgeInsets.only(top:5),
                            child:       
               GestureDetector(
                onTap: () {
                  print('Tapped');
                  print(widget.pendingAssignment.file);
                  _launchURL(widget.pendingAssignment.file);
                },
                child: Icon(Icons.play_circle_outline,
                size: 55,
                color: widget.textColor!=null ? widget.textColor : AppColors.appBarColor,
                         ),),
                            ),
                      Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                         widget.pendingAssignment.status == 'Pending' ? Container() : 
                          IconButton(
                          icon: Icon(Icons.file_download,
                           color: widget.textColor!=null ? widget.textColor : AppColors.appBarColor,
                           size: 30,
                          ), 
                          onPressed: (){
                             downloadAlert(widget.pendingAssignment.submittedFile,'test');
                            //downloadAlert('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4', 'test');
                          }),
                          IconButton(
                          icon: Icon(Icons.remove_red_eye,
                           color: widget.textColor!=null ? widget.textColor : AppColors.appBarColor,
                           size: 30,
                          ), 
                          onPressed: ()=>
                          Navigator.of(context).pushNamed('TalibhePendingDetails',
                          arguments: {'PendingModel' : widget.pendingAssignment,}
                          )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
           
          ],
        )),
    );
  }
}