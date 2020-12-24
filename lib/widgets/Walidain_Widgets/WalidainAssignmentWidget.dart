import 'dart:io';

import 'package:Tahfizul/data/models/Walidain_Models/Assignment.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class WlidainAssignmentWidget extends StatefulWidget {
   final WalidainPendingAssignmentModel pendingAssignments ;
  final Color bgColor;
  final Color iconColor;
  final Color titleColor;
  final Color textcolor;
  WlidainAssignmentWidget({this.pendingAssignments, this.bgColor = AppColors.blueColor, 
  this.iconColor = AppColors.darkblue, this.titleColor = AppColors.buttonBg, this.textcolor = AppColors.darkColor});

  @override
  _WlidainAssignmentWidgetState createState() => _WlidainAssignmentWidgetState();
}

class _WlidainAssignmentWidgetState extends State<WlidainAssignmentWidget> {
 
Directory _downloadsDirectory;
  double progress = 0;
  String progressString = '';
  ProgressDialog pr;
   String id  = '';
   bool downloading = false;
   
  
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
      await dio.download(apkUrl, "${_downloadsDirectory.path}/$filename.mp4",
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
      progressString = "Completed";
      Toast.show('Video Downlaoded.Please Check you Downlaod Folder', context);
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
      downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
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
    DateTime now = DateFormat("yyyy-MM-dd hh:mm:ss").parse(widget.pendingAssignments.assignedDate);
    return Padding(
      padding: const EdgeInsets.only(top : 5.0),
      child: Card(
          child: Container(
          decoration: BoxDecoration(
            color: widget.bgColor
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.pendingAssignments.name}',
                        style: AppStyles.greenTextStyle.copyWith(color: widget.titleColor),),
                        SizedBox(
                          height: 5,
                        ),
                        Text(widget.pendingAssignments.description,style: AppStyles.blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                    Padding(
                      padding:  EdgeInsets.only(left : 12.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(DateFormat.yMMMMd().format(now) ,style: TextStyle(color: widget.textcolor),),
                      ],
                  ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top : 5.0),
                child: Text(widget.pendingAssignments.description,
                style: AppStyles.blackTextStyle.copyWith(fontSize: 13,color: widget.textcolor),),
              ),
              Padding(
              padding: const EdgeInsets.only(top : 5.0),
              child: GestureDetector(
                onTap: () {
                  print('Tapped');
                  print(widget.pendingAssignments.file);
                  _launchURL(widget.pendingAssignments.file);
                },
                child: Icon(Icons.play_circle_outline,
                size: 55,
                color: widget.iconColor,),
              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
             widget.pendingAssignments.status == 'Pending' ? Container() :     GestureDetector(
                onTap: () {
                  print('DownloadTapped');
                  print(widget.pendingAssignments.submittedFile);
                   downloadAlert(widget.pendingAssignments.submittedFile,'test');
                },
                child: Icon(Icons.file_download,
                size: 30,
                color: widget.iconColor,),
              ),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('walidainassignmentdetails',
                          arguments: {'assignmentDetails' : widget.pendingAssignments,}
                          ),
                child: Icon(Icons.remove_red_eye,
                size: 30,
                color: widget.iconColor,),
              ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}