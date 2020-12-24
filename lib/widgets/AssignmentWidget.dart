import 'dart:io';
import 'dart:ui';
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

class Assignment extends StatefulWidget {
  final WalidainPendingAssignmentModel pendingAssignment;
  final Color bgColor;
  final Color buttonColor;
  final Color textColor;
  Assignment({this.pendingAssignment, this.bgColor = AppColors.bgGreenColor, 
  this.buttonColor = AppColors.appBarColor, this.textColor,
  
  });
  @override
  _AssignmentState createState() => _AssignmentState();
}
extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
class _AssignmentState extends State<Assignment>  with SingleTickerProviderStateMixin {
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
    DateTime now = DateFormat("yyyy-MM-dd hh:mm:ss").parse(widget.pendingAssignment.assignedDate);
    print(widget.pendingAssignment.submittedFile);
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.pendingAssignment.name}',
                      style: TextStyle(color: widget.textColor!=null ? widget.textColor : AppColors.darkColor),),
                      Padding(
                        padding: const EdgeInsets.only(top :8.0),
                        child: Text('PARA ${widget.pendingAssignment.paraId}, RUKU ${widget.pendingAssignment.ruku}',
                        style: AppStyles.blackTextStyle.copyWith(fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: widget.textColor!=null ? widget.textColor : Color(0xff617a55)),),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right : 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                       Container(
                         color: AppColors.greyColor,
                         width: 1,
                         height: 40,
                         child: Text(' '),
                       ),             
                        Padding(
                          padding: const EdgeInsets.only(left : 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat.yMMMMd().format(now),
                              style: TextStyle(color: widget.textColor!=null ? widget.textColor : AppColors.darkColor),),
                             
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top :8.0),
                child: Text(widget.pendingAssignment.description,
                style: TextStyle(fontSize: 13,
                color: widget.textColor!=null ? widget.textColor : AppColors.darkColor
                ),),
              ),
              SizeTransition(
                sizeFactor: _controller,
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
             Padding(
              padding: const EdgeInsets.only(top : 5.0),
              child: GestureDetector(
                onTap: () {
                  print('Tapped');
                  print(widget.pendingAssignment.file);
                  _launchURL(widget.pendingAssignment.file);
                },
                child: Icon(Icons.play_circle_outline,
                size: 55,
                color: widget.textColor!=null ? Color(0xffd2ebc6) : AppColors.appBarColor,),
              ),
              ),
                      Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                       widget.pendingAssignment.status == 'Pending'? Container() :    IconButton(
                          icon: Icon(Icons.file_download,
                           color: widget.textColor!=null ? Color(0xffd2ebc6) : AppColors.appBarColor,
                           size: 30,
                          ), 
                          onPressed: (){
                            print(widget.pendingAssignment.submittedFile);
                            downloadAlert(widget.pendingAssignment.submittedFile,'test');
                          }),
                          IconButton(
                          icon: Icon(Icons.remove_red_eye,
                           color: widget.textColor!=null ? Color(0xffd2ebc6) : AppColors.appBarColor,
                           size: 30,
                          ), 
                          onPressed: ()=> widget.bgColor == AppColors.bgGreenColor ? 
                          Navigator.of(context).pushNamed('pendingassignmentdetails', 
                          arguments: {'assignmentDetails' : widget.pendingAssignment,})
                          :Navigator.of(context).pushNamed('pendingassignmentdetails', 
                          arguments: {'assignmentDetails' : widget.pendingAssignment,}))
                        ],
                      ),
                    ],
                  ),
                ),
              )
             
            ],
          ),
        )),
    );
  }
}