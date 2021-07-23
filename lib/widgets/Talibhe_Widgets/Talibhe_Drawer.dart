import 'package:Tahfizul/util/AuthProvider.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/CommonLogout.dart';
import 'package:flutter/material.dart';



class Talibhe_NavDrawer extends StatefulWidget {
  Talibhe_NavDrawer({Key key}) : super(key: key);

  @override
  _Talibhe_NavDrawerState createState() => _Talibhe_NavDrawerState();
}

class _Talibhe_NavDrawerState extends State<Talibhe_NavDrawer> {
  bool isExpanded = false;
  AuthProvider authProvider = AuthProvider();
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
                  
                  Global.globalThalibheDetails.data.image.isNotEmpty ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(45),
                                                child : Image.network('https://www.tahfizulquranonline.com${Global.globalThalibheDetails.data.image}',height: 90,fit: BoxFit.cover,
                                                width: 90,)
                                              ): Container(
                    child: Image.asset(
                      'assets/images/talib.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      Global.globalThalibheDetails.data.name,
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 18),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: AppColors.talibhebuttonbg,
              ),
            ),
            Container(
              color: AppColors.talibhenavbar_bg,
              child: ListTile(
                leading: Icon(
                  Icons.person_pin,
                  size: 30,
                  color: AppColors.talibhebuttonbg,
                ),
                title: Text(
                  'Mualem Profile',
                  style: AppStyles.greyTextStyle.copyWith(color: AppColors.talibhenavbarText),
                ),
                onTap: () => {
                  Navigator.of(context).pop(),
                  Navigator.of(context).pushNamed('followmaulim_profile')
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.talibhenavbar_bg,
                child: ListTile(
                  leading: Icon(
                    Icons.phone_iphone,
                    size: 30,
                    color: AppColors.talibhebuttonbg,
                  ),
                  title: Text(
                    'Talib llm Timeslots',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.talibhenavbarText),
                  ),
                   
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushReplacementNamed('talibhedashboard')
                    },
                ),
              ),
            ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      color: AppColors.talibhenavbar_bg,
                      child: ListTile(
                        leading: Icon(
                          Icons.av_timer,
                          size: 30,
                          color: AppColors.talibhebuttonbg,
                        ),
                        title: Text(
                          'Pending Assignment',
                          style: AppStyles.greyTextStyle.copyWith(color: AppColors.talibhenavbarText),
                        ),
                       
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('Talibhe_Pending_Assignment')
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      color: AppColors.talibhenavbar_bg,
                      child: ListTile(
                        leading: Icon(
                          Icons.check_circle_outline,
                          size: 30,
                          color: AppColors.talibhebuttonbg,
                        ),
                        title: Text(
                          'Completed Assignment',
                          style: AppStyles.greyTextStyle.copyWith(color: AppColors.talibhenavbarText),
                        ),
                       
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('TalibheCompletedAssignemnt')
                          },
                      ),
                    ),
                  ),
                
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.talibhenavbar_bg,
                child: ListTile(
                  leading: Icon(
                    Icons.list,
                    size: 30,
                    color: AppColors.talibhebuttonbg,
                  ),
                  title: Text(
                    'Talib llm Class records',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.talibhenavbarText),
                  ),
                   
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('TalibheClassrecords')
                    },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.talibhenavbar_bg,
                child: ListTile(
                  leading: Icon(
                    Icons.report,
                    size: 30,
                    color: AppColors.talibhebuttonbg,
                  ),
                  title: Text(
                    'Talib llm Report',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.talibhenavbarText),
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('TalibellmReport')
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.talibhenavbar_bg,
                child: ListTile(
                  leading: Icon(
                    Icons.person_pin,
                    size: 30,
                    color: AppColors.talibhebuttonbg,
                  ),
                  title: Text(
                    'Talib llm Details',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.talibhenavbarText),
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('TalibheDetails')
                  },
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.talibhenavbar_bg,
                child: ListTile(
                  leading: Icon(
                    Icons.lock,
                    size: 30,
                    color: AppColors.talibhebuttonbg,
                  ),
                  title: Text(
                    'Reset Password',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.talibhenavbarText),
                  ),
                  onTap: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushNamed('ResetThalibhepassword')
                  },
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: AppColors.talibhenavbar_bg,
                child: ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    size: 30,
                    color: AppColors.talibhebuttonbg,
                  ),
                  title: Text(
                    'Logout',
                    style: AppStyles.greyTextStyle.copyWith(color: AppColors.talibhenavbarText),
                  ),
                  onTap: () => {
                  Navigator.of(context).pop(),
                   showMyDialog(context,AppColors.talibhebuttonbg)
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
