import 'package:Tahfizul/data/models/Moulim_Models/ClassRecords.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:Tahfizul/widgets/CustomExpansionTile.dart';

class WalidainClassRecordsWidget extends StatefulWidget {
  
  final ClassRecords classrecords;
  WalidainClassRecordsWidget({Key key, this.classrecords}) : super(key: key);
  
  @override
  _WalidainClassRecordsWidgetState createState() => _WalidainClassRecordsWidgetState();
}

class _WalidainClassRecordsWidgetState extends State<WalidainClassRecordsWidget> {
  bool isExpanded = false;
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
               Text('Class ${widget.classrecords.slotNo}',
               style:  isExpanded ? AppStyles.whiteTextStyle.copyWith(fontWeight: FontWeight.w500):
                AppStyles.blackTextStyle,),
               SizedBox(width: 10,),
               Text('(${widget.classrecords.slotFrom} TO ${widget.classrecords.slotTo})',
               style:  isExpanded ? AppStyles.whiteTextStyle.copyWith(fontWeight: FontWeight.w500):
                AppStyles.blackTextStyle,),
             ],
           )
         ],
       ),
       onExpansionChanged: (value) {
         print(value);
         setState(()=> isExpanded = value);
       },
       headerBackgroundColor: isExpanded ? AppColors.darkblue : AppColors.greyColor.withOpacity(0.7),   
       iconColor : Colors.transparent, 
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
                       color: AppColors.darkblue,
                       fontWeight: FontWeight.w500,
                       ),
                     ),
                     Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('Number of Class - ${widget.classrecords.noOfClasses}',
                      style: AppStyles.greenTextStyle),
                     ),
                     Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text('Assigned Class :',
                      style: AppStyles.greenTextStyle),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top : 5.0),
                       child: Text(widget.classrecords.assignedClass,
                       style: AppStyles.greenTextStyle,),
                     )
                   ],
                 ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     IconButton(
                     icon: Icon(Icons.play_circle_outline,color: AppColors.darkblue,size: 55,), 
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