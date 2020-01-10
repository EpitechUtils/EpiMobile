import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_intranet/pages/DashboardPage.dart';
import 'package:mobile_intranet/pages/ProfilePage.dart';
import 'package:mobile_intranet/pages/splashscreen.dart';
import 'package:mobile_intranet/pages/dashboard.dart';
import 'package:mobile_intranet/pages/login/error.dart';
import 'package:mobile_intranet/pages/login/synchronization.dart';

void main() => runApp(EpitechMobile());

class EpitechMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light
    ));*/

    return MaterialApp(
        title: 'Intranet Mobile',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.black,
            bottomAppBarColor: Color(0xFF131313),
        ),
        darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            bottomAppBarColor: Color(0xFF131313),
        ),
        themeMode: ThemeMode.dark,
        home: SplashScreen(),
        routes: {
            '/error_login': (_) => ErrorLogin(),
            '/synchronization': (_) => Synchronization(),
            '/home': (context) => Dashboard(),
            //'/home': (context) => DashboardPage(),
            '/profile': (context) => ProfilePage()
        },
        //debugShowMaterialGrid: true,
        debugShowCheckedModeBanner: false
    );
  }
}
