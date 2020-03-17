import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_intranet/pages/dashboard.dart';
import 'package:mobile_intranet/pages/profile.dart';
import 'package:mobile_intranet/pages/splashscreen.dart';
import 'package:mobile_intranet/pages/schedule.dart';
import 'package:mobile_intranet/pages/notifications.dart';
import 'package:mobile_intranet/pages/settings.dart';
import 'package:mobile_intranet/pages/login/error.dart';
import 'package:mobile_intranet/pages/login/synchronization.dart';
import 'package:mobile_intranet/pages/testsResults.dart';
import 'package:mobile_intranet/utils/backgroundNotifications.dart';

/// Main application class
/// Extended from [StatelessWidget]
class EpitechMobile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        //WidgetsFlutterBinding.ensureInitialized();
        //FlutterDownloader.initialize();
        return MaterialApp(
            title: 'MyEpitech',
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                cardColor: Colors.white,
                primaryColor: Color(0xFF565656),
                focusColor: Colors.blueAccent,
                bottomAppBarTheme: BottomAppBarTheme(
                    //color: Color(0xFF131313),
                ),
                appBarTheme: AppBarTheme(
                    color: Color(0xFF131313),
                    iconTheme: IconThemeData(color: Colors.white),
                    actionsIconTheme: IconThemeData(color: Colors.white)
                ),
                disabledColor: Color(0xFF131313),
                buttonColor: Color(0xFF27ae60),
                primaryIconTheme: IconThemeData(color: Color(0xFF131313)),
                textTheme: TextTheme(
                    title: TextStyle(
                        fontFamily: "Sarabun",
                        fontSize: 35,
                        letterSpacing: 1,
                        color: Color(0xFF131313)
                    ),
                    subtitle: TextStyle(
                        color: Color(0xFF131313),
                        fontSize: 20,
                        fontFamily: "Sarabun",
                        letterSpacing: 1.0,
                    ),
                    button: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Sarabun",
                        letterSpacing: 1
                    )
                )
            ),
            themeMode: ThemeMode.light,
            home: SplashScreen(),
            routes: {
                '/error_login': (_) => ErrorLogin(),
                '/synchronization': (_) => Synchronization(),
                '/home': (context) => DashboardPage(),
                '/tests_results': (context) => TestsResultsPage(),
                '/profile': (context) => ProfilePage(),
                '/schedule': (context) => SchedulePage(),
                '/settings': (context) => SettingsPage(),
                '/notifications': (context) => NotificationsPage()
            },
            //debugShowMaterialGrid: true,
            debugShowCheckedModeBanner: false
        );
    }

    static Future<void> makeNotif() async {
        return;
    }
}

/// Main application start
void main() {
    // Apply white statusbar color by force to all devices
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark)
    );

    // Start background notification manager
    BackgroundNotificationManager.initialize((payload) async {
        var route = "/home";
        switch (payload) {
            case "activity":
                {
                    route = "/schedule";
                }
                break;
            case "notification":
                {
                    route = "/notifications";
                }
                break;
        }
        // TODO find a way to push a route

        return;
    });

    // Run application
    runApp(EpitechMobile());
}
