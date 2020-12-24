import 'dart:ui';

import 'package:Tahfizul/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoader extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color loaderColor;
  //passing props in react style
  AppLoader({
    Key key,
    this.child,
    this.padding = const EdgeInsets.all(8),
    this.margin = const EdgeInsets.only(top: 8), this.loaderColor = AppColors.appBarColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          // width: MediaQuery.of(context).size.width,
                          child: SpinKitDoubleBounce(
                        color: loaderColor,
                        size: 70.0,
                      )),
                      // Container(
                      //   margin: EdgeInsets.symmetric(vertical: 20),
                      //   child: Text(
                      //     "LOADING...",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ));
  }
}

