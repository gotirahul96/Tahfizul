import 'package:Tahfizul/util/theme.dart';
import 'package:flutter/material.dart';

class Add_Assignment extends StatelessWidget {
  const Add_Assignment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FloatingActionButton(
            backgroundColor: AppColors.orangeButton,
            elevation: 0,
            child: Icon(Icons.add,size: 40,),
            onPressed: () => Navigator.of(context).pushNamed('new_assignment')),
          Padding(
            padding: const EdgeInsets.only(top : 5.0),
            child: Text('New Assignment',
            style: AppStyles.greenTextStyle.copyWith(
            color: AppColors.buttonBg,
            fontSize: 18,
            fontWeight: FontWeight.w500
            ),),
          ),
        ],
      ),
    );
  }
}