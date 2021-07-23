import 'package:Tahfizul/util/AuthProvider.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:flutter/material.dart';

  Future<void> showMyDialog(BuildContext context,Color customColor) async {
    AuthProvider authProvider = AuthProvider();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text('Confirm Logout'),
          content: Text('Are your sure you want to Logout?'),
          actions: <Widget>[
            FlatButton(
              color: customColor,
              child: Text(
                'No',
                style: TextStyle(
                  color: AppColors.whiteColor
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: customColor,
              child: Text(
                'Yes',
                style: TextStyle(
                  color: AppColors.whiteColor,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                // authProvider.deleteUserType();
                // authProvider.deletemoulimData();
                // authProvider.deletethalibheData();
                // authProvider.deletewalidainData();
                authProvider.deleteSharedPreference().then((value) {
                  Navigator.of(context).popAndPushNamed('selection_screen');
                });
              },
            ),
          ],
        );
      },
    );
  }