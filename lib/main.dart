import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'package:mobile_intranet/pages/dashboard.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/pages/profile.dart';
import 'package:mobile_intranet/pages/splashscreen.dart';
import 'package:mobile_intranet/pages/schedule.dart';
import 'package:mobile_intranet/pages/notifications.dart';
import 'package:mobile_intranet/pages/settings.dart';
import 'package:mobile_intranet/pages/login/error.dart';
import 'package:mobile_intranet/pages/login/synchronization.dart';
import 'package:mobile_intranet/pages/testsResults.dart';
import 'package:http/http.dart' as http;
import 'package:background_fetch/background_fetch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile_intranet/utils/jobsUtils.dart' as Jobs;

/// Main application class
/// Extended from [StatelessWidget]
class EpitechMobile extends StatelessWidget {
//  FlutterLocalNotificationsPlugin localNotification;
  static final _deviceTokenKey = "device_token";
  String _deviceToken;

  static Future<void> notifyLastNotifs(String deviceToken) async {
    final pref = await SharedPreferences.getInstance();
    final parser = Parser(pref.getString("autolog_url"));
    final notifs = await parser.parseDashboardNotifications();

    final lastNotifID = pref.getString("last_notif_id");
    print(lastNotifID);
    var i = 0;

    for (; i < notifs.notifications.length; i++) {
      if (notifs.notifications[i].id == lastNotifID) {
        break;
      }
    }

    if (i >= notifs.notifications.length) {
      i--;
    }

    for (; i >= 0; i--) {
      final title = (notifs.notifications[i].title.contains('<'))
          ? notifs.notifications[i].title
              .substring(0, notifs.notifications[i].title.indexOf('<'))
          : notifs.notifications[i].title;
//      http.post(
//          "https://api.pushy.me/push?api_key=0b86578a2c575282a3f16edd1feb96c1acbb05c2ee7db9765f25d5845bd9ea4c",
//          headers: {"Content-type": "application/json"},
//          body: '''
//      {
//        "to": "${deviceToken}",
//        "data": {
//          "message": "${title}"
//        }
//      }
//      ''').then((resp) {
//        print(resp.body);
//      }, onError: (e) {
//        print("http error: $e");
//      });
    }

    await pref.setString("last_notif_id", notifs.notifications[i].id);
  }

  /*
  static void onBackgroundHeadlessFetch() {
    print('[BackgroundFetch EpiMobile] Headless event received.');
    SharedPreferences.getInstance().then((pref) {
      if (pref.getKeys().contains(_deviceTokenKey)) {
        final deviceToken = pref.getString(_deviceTokenKey);
        print("[BackgroundFetch]: Device token `${deviceToken}`.");

        http.post(
            "https://api.pushy.me/push?api_key=0b86578a2c575282a3f16edd1feb96c1acbb05c2ee7db9765f25d5845bd9ea4c",
            headers: {"Content-type": "application/json"},
            body: '''
      {
        "to": "${deviceToken}",
        "data": {
          "message": "coucou"
        }
      }
      ''').then((resp) {
          print(resp.body);
        }, onError: (e) {
          print("http error: $e");
        });
      } else {
        print("[Shared Preferences]: Missing `${_deviceTokenKey}` from keys.");
      }
      BackgroundFetch.finish();
    }, onError: (e) {
      print("[Shared Preferences]: Error `${e}`.");
      BackgroundFetch.finish();
    });
  }

  Future<void> _onBackgroundFetch() {
    print("[BackgroundFetch] Background fetch event received.");

    notifyLastNotifs(_deviceToken).then((_) {
      BackgroundFetch.finish();
    }, onError: (e) {
      print("[BackgroundFetch]: `${e}`.");
      BackgroundFetch.finish();
    });
*/

//    localNotification.show(0, "C'EST LE TITRE", "C'EST LE COPRS", NotificationDetails(AndroidNotificationDetails("", "", "", importance: Importance.Max,
//                    priority: Priority.High,
//                    ticker: 'ticker'),
//                IOSNotificationDetails()),
//            payload: "item x")
//        .then((x) {
//      print("[Local notification]: Success.");
//    }, onError: (e) {
//      print("[Local notification]: Error `${e}`.");
//    });
//  }

  static void onBackgroundHeadlessCheckForSessions(String taskId) {
      print('[BackgroundFetch EpiMobile] Headless event received.');
      SharedPreferences.getInstance().then((pref) async {
          var session = await Jobs.getNextSessionNotification(pref);

          if (session != null) {
              print("Session soon ! :" +  session.start + " " + session.title + " " + session.activityTitle);
          }
          BackgroundFetch.finish(taskId);
      }, onError: (e) {
          print("[Shared Preferences]: Error `$e`.");
          BackgroundFetch.finish(taskId);
      });
  }

  Future<String> _pushyRegister() async {
    String deviceToken;
    await Pushy.register().then((t) {
      Pushy.setNotificationListener(_pushyNotificationHandler);
      deviceToken = t;
      print("[Pushy]: Device token `${t}`");
    }, onError: (e) {
      print("[Pushy]: Error `${e}`");
    });

    return deviceToken;
  }

  void _pushyNotificationHandler(Map<String, dynamic> data) {
    print("[Pushy]: Got `${data}`.");
    Pushy.clearBadge();
  }

  @override
  Widget build(BuildContext context) {
    //WidgetsFlutterBinding.ensureInitialized();
    //FlutterDownloader.initialize();
    var localNotification = FlutterLocalNotificationsPlugin();
    localNotification.initialize(InitializationSettings(
        AndroidInitializationSettings('ic_launcher'),
        IOSInitializationSettings())).then((what) {
          print("[Local Notifications]: `${what}`");

          localNotification.show(0, "C'EST LE TITRE", "MANGE MA BITE IDE DE MERDE", NotificationDetails(AndroidNotificationDetails("", "", "", importance: Importance.Max,
                    priority: Priority.High,
                    ticker: 'ticker'),
                IOSNotificationDetails()),
            payload: "item x")
        .then((x) {
      print("[Local notification]: Success.");
    }, onError: (e) {
      print("[Local notification]: Error `${e}`.");
    });

    }, onError: (e) {
          print("[Local Notifications]: error `${e}`");
    });
//    Pushy.listen();
//    Pushy.requestStoragePermission();
//    _pushyRegister().then((String deviceToken) {
//      _deviceToken = deviceToken;
//      SharedPreferences.getInstance().then((pref) {
//        pref.setString(_deviceTokenKey, deviceToken);
//      });
//
//      BackgroundFetch.configure(
//          BackgroundFetchConfig(
//            minimumFetchInterval: 15,
//            stopOnTerminate: false,
//            enableHeadless: true,
//            requiresBatteryNotLow: false,
//            requiresCharging: false,
//            requiresStorageNotLow: false,
//            requiresDeviceIdle: false,
//            startOnBoot: true,
//            requiredNetworkType: BackgroundFetchConfig.NETWORK_TYPE_ANY,
//          ),
//          _onBackgroundFetch);
//    });

    return MaterialApp(
        title: 'EpiCompanion',
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFecf0f1),
            cardColor: Colors.white,
            primaryColor: Color(0xFF131313),
            focusColor: Colors.blueAccent,
            bottomAppBarTheme: BottomAppBarTheme(
              color: Color(0xFF131313),
            ),
            appBarTheme: AppBarTheme(
                color: Color(0xFF131313),
                iconTheme: IconThemeData(color: Colors.white),
                actionsIconTheme: IconThemeData(color: Colors.white)),
            disabledColor: Color(0xFF131313),
            buttonColor: Color(0xFF27ae60),
            primaryIconTheme: IconThemeData(color: Color(0xFF131313)),
            textTheme: TextTheme(
                title: TextStyle(
                    fontFamily: "CalibreSemibold",
                    fontSize: 35,
                    letterSpacing: 1,
                    color: Color(0xFF131313)),
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
                    letterSpacing: 1))),
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
        debugShowCheckedModeBanner: false);
  }
}

/// Main application start
void main() {
  runApp(EpitechMobile());
  //BackgroundFetch.registerHeadlessTask(EpitechMobile.onBackgroundHeadlessFetch);
}
