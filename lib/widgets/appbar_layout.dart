import 'package:Tahfizul/util/theme.dart';
import 'package:flutter/material.dart';

class AppBarLayout extends AppBar {
  final String appBarTitle;
  final Color titleColor;
  final BuildContext context;
  final VoidCallback onBack;
  final Color appbarColor;
  final double eleVation;
  final IconThemeData icontheme;
  AppBarLayout({Key key,this.appbarColor = AppColors.appBarColor, this.appBarTitle = '',
  this.eleVation = 0.0, this.context, this.onBack,this.icontheme,this.titleColor = AppColors.darkColor })
      : super(
          key: key,
          title: new Text(appBarTitle,
              style: TextStyle(fontSize: 20, color: titleColor)),
          backgroundColor: appbarColor,
          iconTheme : icontheme,
          centerTitle: true,
          elevation : eleVation,
          leading: onBack != null
              ? IconButton(
                  icon: Icon(Icons.navigate_before, color: AppColors.whiteColor,size: 35),
                  onPressed: onBack,
                )
              : null,
          //automaticallyImplyLeading: false,
          actions: <Widget>[],
        );
}
