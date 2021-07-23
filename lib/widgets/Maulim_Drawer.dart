import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CommonLogout.dart';
import 'package:flutter/material.dart';

import 'CustomExpansionTile.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer({Key key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.lightestGreyColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                 Global.globalMoulimDetails.data.image.isNotEmpty ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(45),
                                                child : Image.network('https://www.tahfizulquranonline.com${Global.globalMoulimDetails.data.image}',height: 90,fit: BoxFit.cover,
                                                width: 90,)
                                              ): Container(
                    child: Image.asset(
                      'assets/images/Moulvi.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      Global.globalMoulimDetails.data.name,
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 18),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: AppColors.buttonBg,
              ),
            ),
            Container(
              color: AppColors.lightGreenColor,
              child: ListTile(
                leading: Icon(
                  Icons.person_pin,
                  size: 30,
                  color: AppColors.mediumGreenColor,
                ),
                title: Text(
                  'Mualem Profile',
                  style: AppStyles.greyTextStyle,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.whiteColor,
                  size: 15,
                ),
                onTap: () => {
                  Navigator.of(context).pop(),
                  Navigator.of(context).pushNamed('maulim_profile')
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.lightGreenColor,
                child: ListTile(
                  leading: Icon(
                    Icons.phone_iphone,
                    size: 30,
                    color: AppColors.mediumGreenColor,
                  ),
                  title: Text(
                    'Mualem Timeslots',
                    style: AppStyles.greyTextStyle,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.whiteColor,
                    size: 15,
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushReplacementNamed('dashBoard_home')
                   
                    },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomExpansionTile(
                title: Text(
                  'Assignments',
                  style: AppStyles.greyTextStyle,
                ),
                headerBackgroundColor: AppColors.lightGreenColor,
                backgroundColor: AppColors.lightestGreyColor,
                leading: Icon(
                  Icons.assignment_turned_in,
                  color: AppColors.mediumGreenColor,
                ),
                iconColor: AppColors.whiteColor,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      color: AppColors.lightestGreenColor,
                      child: ListTile(
                        leading: Icon(
                          Icons.new_releases,
                          size: 30,
                          color: AppColors.mediumGreenColor,
                        ),
                        title: Text(
                          'New Assignment',
                          style: AppStyles.greyTextStyle,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.whiteColor,
                          size: 15,
                        ),
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('new_assignment')
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      color: AppColors.lightestGreenColor,
                      child: ListTile(
                        leading: Icon(
                          Icons.av_timer,
                          size: 30,
                          color: AppColors.mediumGreenColor,
                        ),
                        title: Text(
                          'Pending Assignment',
                          style: AppStyles.greyTextStyle,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.whiteColor,
                          size: 15,
                        ),
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('pendingassignmentscreen')
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      color: AppColors.lightestGreenColor,
                      child: ListTile(
                        leading: Icon(
                          Icons.check_circle_outline,
                          size: 30,
                          color: AppColors.mediumGreenColor,
                        ),
                        title: Text(
                          'Completed Assignment',
                          style: AppStyles.greyTextStyle,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.whiteColor,
                          size: 15,
                        ),
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('completedassignmentscreen')
                          },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.lightGreenColor,
                child: ListTile(
                  leading: Icon(
                    Icons.list,
                    size: 30,
                    color: AppColors.mediumGreenColor,
                  ),
                  title: Text(
                    'Mualem Class records',
                    style: AppStyles.greyTextStyle,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.whiteColor,
                    size: 15,
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('classrecordscreen')
                    },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.lightGreenColor,
                child: ListTile(
                  leading: Icon(
                    Icons.report,
                    size: 30,
                    color: AppColors.mediumGreenColor,
                  ),
                  title: Text(
                    'Talib  llm Report',
                    style: AppStyles.greyTextStyle,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.whiteColor,
                    size: 15,
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('talibellmreportscreen')
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.lightGreenColor,
                child: ListTile(
                  leading: Icon(
                    Icons.person_pin,
                    size: 30,
                    color: AppColors.mediumGreenColor,
                  ),
                  title: Text(
                    'Talib  llm Details',
                    style: AppStyles.greyTextStyle,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.whiteColor,
                    size: 15,
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('talibellmdetailsscreen')
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.lightGreenColor,
                child: ListTile(
                  leading: Icon(
                    Icons.feedback,
                    size: 30,
                    color: AppColors.mediumGreenColor,
                  ),
                  title: Text(
                    'Feedback',
                    style: AppStyles.greyTextStyle,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.whiteColor,
                    size: 15,
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('maulimfeedback')
                    },
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.lightGreenColor,
                child: ListTile(
                  leading: Icon(
                    Icons.lock_outline_rounded,
                    size: 30,
                    color: AppColors.mediumGreenColor,
                  ),
                  title: Text(
                    'Reset Password',
                    style: AppStyles.greyTextStyle,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.whiteColor,
                    size: 15,
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('resetpassword')
                    },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.lightGreenColor,
                child: ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    size: 30,
                    color: AppColors.mediumGreenColor,
                  ),
                  title: Text(
                    'Logout',
                    style: AppStyles.greyTextStyle,
                  ),
                  onTap: () => {
                  Navigator.of(context).pop(),
                   showMyDialog(context,AppColors.mediumGreenColor)
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
