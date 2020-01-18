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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark
    ));

    return MaterialApp(
        title: 'Intranet Mobile',
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFecf0f1),
            bottomAppBarColor: Colors.white,
            cardColor: Colors.white,
            primaryColor: Color(0xFF131313),
            focusColor: Colors.blueAccent,
            disabledColor: Color(0xFF131313),
            buttonColor: Color(0xFF27ae60),
            primaryIconTheme: IconThemeData(
                color: Color(0xFF131313)
            ),
            textTheme: TextTheme(
                title: TextStyle(
                    fontFamily: "CalibreSemibold",
                    fontSize: 35,
                    letterSpacing: 1,
                    color: Color(0xFF131313)
                ),
                subtitle: TextStyle(
                    color: Color(0xFF131313),
                    fontSize: 20,
                    fontFamily: "CalibreSemibold",
                    letterSpacing: 1.0,
                ),
                button: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "CalibreSemibold",
                    letterSpacing: 1
                )
            )
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
