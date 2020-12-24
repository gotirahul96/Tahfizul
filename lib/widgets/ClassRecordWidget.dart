import 'package:Tahfizul/data/models/Moulim_Models/ClassRecords.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:Tahfizul/widgets/CustomExpansionTile.dart';

class ClassRecordsWidget extends StatefulWidget {
  
  final ClassRecords classrecords;
  ClassRecordsWidget({Key key, this.classrecords}) : super(key: key);
  
  @override
  _ClassRecordsWidgetState createState() => _ClassRecordsWidgetState();
}

class _ClassRecordsWidgetState extends State<ClassRecordsWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top : 8.0),
      child: Card(
       shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
       child: CustomExpansionTile(
       title: Row(
         children: [
           Row(
             children: [
               Text('SLOT ${widget.classrecords.slotNo}',
               style: AppStyles.greenTextStyle.copyWith(fontWeight: FontWeight.w500),),
               SizedBox(width: 10,),
               Text('(${widget.classrecords.slotFrom} TO ${widget.classrecords.slotTo})',
               style: AppStyles.greenTextStyle.copyWith(fontWeight: FontWeight.w500),)
             ],
           )
         ],
       ),
       headerBackgroundColor: AppColors.bgGreenColor,   
       iconColor : AppColors.buttonBg, 
       backgroundColor : AppColors.whiteColor,
       borderRadius: BorderRadius.only(
         topLeft: Radius.circular(10),
         topRight: Radius.circular(10),
         bottomLeft:  Radius.circular(10),
         bottomRight:  Radius.circular(10),
       ),
       children: [
           Padding(
             padding: const EdgeInsets.all(15.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(widget.classrecords.name,
                     style: AppStyles.blackTextStyle.copyWith(
                       color: AppColors.orangeButton,
                       fontWeight: FontWeight.w500,
                       ),
                     ),
                     Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('Number of Class - ${widget.classrecords.noOfClasses}',
                      style: AppStyles.greenTextStyle.copyWith(fontWeight: FontWeight.w500),),
                     ),
                     Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text('Assigned Class :',
                      style: AppStyles.greenTextStyle.copyWith(fontWeight: FontWeight.w500),),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top : 5.0),
                       child: Text(widget.classrecords.assignedClass,
                       style: AppStyles.blackTextStyle.copyWith(
                         color: AppColors.orangeButton,
                         fontWeight: FontWeight.w500,
                         fontSize: 16
                         ),),
                     )
                   ],
                 ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     IconButton(
                     icon: Icon(Icons.play_circle_outline,color: AppColors.orangeColor,size: 55,), 
                     onPressed: null),
                     Padding(
                       padding: const EdgeInsets.only(top : 25.0),
                       child: Row(
                         children: [
                          IconButton(
                       icon: Icon(Icons.file_download,color: AppColors.buttonBg,size: 25,), 
                       onPressed: null),
                       IconButton(
                       icon: Icon(Icons.remove_red_eye,color: AppColors.buttonBg,size: 25,), 
                       onPressed: null),
                         ],
                       ),
                     )
                   ],
                 )
               ],
             ),
           )
       ],
       ),
        ),
    );
  }
}