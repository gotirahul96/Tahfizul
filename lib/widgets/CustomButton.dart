import 'package:Tahfizul/util/theme.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final onPressed;
  final text;
  final bgcolor;
  CustomRoundedButton({this.onPressed, this.text, this.bgcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        shape: StadiumBorder(
            //side: BorderSide(color: AppColors.buttonBorder, width: 1.2)
            ),
        elevation: 2,
        color: bgcolor ?? AppColors.buttonBg,
        onPressed: onPressed,
        child: Text(
          text,
          style: AppStyles.whiteTextStyle,
        ),
      ),
    );
  }
}
