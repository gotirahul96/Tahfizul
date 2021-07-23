import 'package:Tahfizul/screens/Maulim%20Screens/Maulim%20auth/login.dart';
import 'package:Tahfizul/screens/Talibhe%20Screens/Talibhe%20auth/login.dart';
import 'package:Tahfizul/screens/Walidain%20Screens/Walidain%20Auth/WalidainLogin.dart';
import 'package:Tahfizul/util/global.dart';
import 'package:Tahfizul/util/size_Config.dart';
import 'package:Tahfizul/util/theme.dart';
import 'package:Tahfizul/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Selection_Screen extends StatefulWidget {
  Selection_Screen({Key key}) : super(key: key);

  @override
  Selection_ScreenState createState() => Selection_ScreenState();
}

class Selection_ScreenState extends State<Selection_Screen> with SingleTickerProviderStateMixin{

  TabController _tabController;
  int index = 0;
  @override
  void initState() {
    super.initState();
   

    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
    _tabController
        .addListener((){
          setState(() {
            index = _tabController.index;
          }); 
        });  
  }

   @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
      SizeConfig().init(context);
      setState(() {
          Global.isLoading = false;
        });
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              width: double.infinity,
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 15),
                          child: Text('Please Select One',style: AppStyles.blackTextStyle.copyWith(
                            fontSize: 26
                          ),),
                          ),
                Container(
                margin: EdgeInsets.only(top: 20),
                child:  TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.zero,
                indicator: ShapeDecoration(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5), 
                    topLeft: Radius.circular(5))),
                  color: index == 0 ? AppColors.darkblue : index == 1 ? AppColors.buttonBg : AppColors.talibhebuttonbg,
                ),
                labelStyle: TextStyle(fontSize: 16),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text('Walidain',style: TextStyle(fontWeight: FontWeight.w500),),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Mualem',style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Talib Ilm',style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
              ),
              Container(
              child: Container(
                height: SizeConfig.safeScreenHeight - 116,
                child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    WalidainLogin(),
                    MoulimLogin(),
                    TalibheLogin()
                  ],
                ),
              ),
            ),
                        ]))));}))));
  }
}