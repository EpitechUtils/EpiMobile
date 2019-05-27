import 'package:flutter/material.dart';
import 'package:mobile_intranet/views/DashboardPage.dart';
import 'package:mobile_intranet/views/LoginWebview.dart';
import 'package:mobile_intranet/views/ProfilePage.dart';
import 'package:mobile_intranet/views/SplashScreen.dart';

void main() => runApp(EpitechMobile());

class EpitechMobile extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Epitech Mobile',
            theme: ThemeData(primarySwatch: Colors.indigo),
            home: SplashScreen(),
            routes: {
                '/home': (context) => DashboardPage(),
                '/profile': (context) => ProfilePage()
            },
            //debugShowMaterialGrid: true,
            //debugShowCheckedModeBanner: false
        );
    }

}