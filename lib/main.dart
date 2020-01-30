import 'package:flutter/material.dart';
import 'package:mobile_intranet/pages/DashboardPage.dart';
import 'package:mobile_intranet/pages/ProfilePage.dart';
import 'package:mobile_intranet/pages/SplashScreen.dart';
import 'package:mobile_intranet/pages/SchedulePage.dart';
import 'package:mobile_intranet/pages/SettingsPage.dart';

void main()
{
    runApp(EpitechMobile());
}

class EpitechMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EpiMobile',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "NunitoSans"),
        home: SplashScreen(),
        routes: {
          '/home': (context) => DashboardPage(),
          '/profile': (context) => ProfilePage(),
          '/schedule': (context) => SchedulePage(),
          '/settings': (context) => SettingsPage()
        },
        //debugShowMaterialGrid: true,
        debugShowCheckedModeBanner: false);
  }
}
