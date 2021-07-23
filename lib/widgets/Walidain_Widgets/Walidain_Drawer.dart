import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CommonLogout.dart';
import 'package:flutter/material.dart';



class WalidainNavDrawer extends StatefulWidget {
  WalidainNavDrawer({Key key}) : super(key: key);

  @override
  _WalidainNavDrawerState createState() => _WalidainNavDrawerState();
}

class _WalidainNavDrawerState extends State<WalidainNavDrawer> {
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
                  Global.globalWalidainDetails.data.image.isNotEmpty ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(45),
                                                child : Image.network('https://www.tahfizulquranonline.com${Global.globalWalidainDetails.data.image}',height: 90,fit: BoxFit.cover,
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
                      Global.globalWalidainDetails.data.name,
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 18),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: AppColors.darkblue,
              ),
            ),
            Container(
              color: AppColors.darkblue.withAlpha(120),
              child: ListTile(
                leading: Icon(
                  Icons.person_pin,
                  size: 30,
                  color: AppColors.darkblue.withAlpha(200),
                ),
                title: Text(
                  'Mualem Profile',
                  style: AppStyles.greyTextStyle.copyWith(color: AppColors.whiteColor),
                ),
                onTap: () => {
                  Navigator.of(context).pop(),
                  Navigator.of(context).pushNamed('WalidainMaulimProfile')
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.darkblue.withAlpha(120),
                child: ListTile(
                  leading: Icon(
                    Icons.phone_iphone,
                    size: 30,
                    color: AppColors.darkblue.withAlpha(200),
                  ),
                  title: Text(
                    "Today's Classes",
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.whiteColor),
                  ),
                   
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushReplacementNamed('walidaindashboard')
                    },
                ),
              ),
            ),
              Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      color: AppColors.darkblue.withAlpha(120),
                      child: ListTile(
                        leading: Icon(
                          Icons.av_timer,
                          size: 30,
                          color: AppColors.darkblue.withAlpha(200),
                        ),
                        title: Text(
                          'Pending Assignment',
                          style: AppStyles.greyTextStyle.copyWith(color: AppColors.whiteColor),
                        ),
                       
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('walidainpendingassignment')
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      color: AppColors.darkblue.withAlpha(120),
                      child: ListTile(
                        leading: Icon(
                          Icons.check_circle_outline,
                          size: 30,
                          color: AppColors.darkblue.withAlpha(200),
                        ),
                        title: Text(
                          'Completed Assignment',
                          style: AppStyles.greyTextStyle.copyWith(color: AppColors.whiteColor),
                        ),
                       
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('walidaincompletedassignment')
                          },
                      ),
                    ),
                  ),
                
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.darkblue.withAlpha(120),
                child: ListTile(
                  leading: Icon(
                    Icons.list,
                    size: 30,
                    color: AppColors.darkblue.withAlpha(200),
                  ),
                  title: Text(
                    'Talib llm Class records',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.whiteColor),
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('WalidainClassRecordsScreen')
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.darkblue.withAlpha(120),
                child: ListTile(
                  leading: Icon(
                    Icons.report,
                    size: 30,
                    color: AppColors.darkblue.withAlpha(200),
                  ),
                  title: Text(
                    'Talib llm Report',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.whiteColor),
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('WalidainTalibellmReport')
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.darkblue.withAlpha(120),
                child: ListTile(
                  leading: Icon(
                    Icons.person_pin,
                    size: 30,
                    color: AppColors.darkblue.withAlpha(200),
                  ),
                  title: Text(
                    'Talib llm Details',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.whiteColor),
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('walidaindetails')
                  },
                ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.darkblue.withAlpha(120),
                child: ListTile(
                  leading: Icon(
                    Icons.feedback,
                    size: 30,
                    color: AppColors.darkblue.withAlpha(200),
                  ),
                  title: Text(
                    'FeedBack',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.whiteColor),
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('WalidainFeedBack')
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.darkblue.withAlpha(120),
                child: ListTile(
                  leading: Icon(
                    Icons.lock_open_outlined,
                    size: 30,
                    color: AppColors.darkblue.withAlpha(200),
                  ),
                  title: Text(
                    'Reset Password',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.whiteColor),
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('ResetWalidainpassword')
                  },
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.darkblue.withAlpha(120),
                child: ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    size: 30,
                    color: AppColors.darkblue.withAlpha(200),
                  ),
                  title: Text(
                    'Logout',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.whiteColor),
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                   showMyDialog(context,AppColors.darkblue)
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
