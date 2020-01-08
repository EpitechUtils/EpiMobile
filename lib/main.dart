import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_intranet/pages/DashboardPage.dart';
import 'package:mobile_intranet/pages/ProfilePage.dart';
import 'package:mobile_intranet/pages/SplashScreen.dart';
import 'package:mobile_intranet/pages/dashboard.dart';

void main() => runApp(EpitechMobile());

class EpitechMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light
    ));

    return MaterialApp(
        title: 'Intranet Mobile',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: "CalibreSemibold",
            scaffoldBackgroundColor: Colors.black,
            bottomAppBarColor: Color(0xFF131313),
        ),
        darkTheme: ThemeData(
            fontFamily: "CalibreSemibold",
            scaffoldBackgroundColor: Colors.black,
            bottomAppBarColor: Color(0xFF131313),
        ),
        themeMode: ThemeMode.dark,
        home: SplashScreen(),
        routes: {
            '/home': (context) => Dashboard(),
            //'/home': (context) => DashboardPage(),
            '/profile': (context) => ProfilePage()
        },
        //debugShowMaterialGrid: true,
        debugShowCheckedModeBanner: false
    );
  }
}
