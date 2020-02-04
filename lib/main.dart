import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_intranet/pages/DashboardPage.dart';
import 'package:mobile_intranet/pages/ProfilePage.dart';
import 'package:mobile_intranet/pages/SplashScreen.dart';
import 'package:mobile_intranet/pages/SchedulePage.dart';
import 'package:mobile_intranet/pages/SettingsPage.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:background_fetch/background_fetch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/pages/splashscreen.dart';
import 'package:mobile_intranet/pages/dashboard.dart';
import 'package:mobile_intranet/pages/login/error.dart';
import 'package:mobile_intranet/pages/login/synchronization.dart';

void main() {
  runApp(EpitechMobile());
  BackgroundFetch.registerHeadlessTask(EpitechMobile.onBackgroundHeadlessFetch);
}

class EpitechMobile extends StatelessWidget {
  static final _deviceTokenKey = "device_token";
  String _deviceToken;

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

  void _onBackgroundFetch() {
    print("[BackgroundFetch EpiMobile] Background fetch event received.");
    http.post(
        "https://api.pushy.me/push?api_key=0b86578a2c575282a3f16edd1feb96c1acbb05c2ee7db9765f25d5845bd9ea4c",
        headers: {"Content-type": "application/json"},
        body: '''
      {
        "to": "${_deviceToken}",
        "data": {
          "message": "mdr"
        }
      }
      ''').then((resp) {
      print(resp.body);
    }, onError: (e) {
      print("http error: $e");
    });
    BackgroundFetch.finish();
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
    Pushy.listen();
    Pushy.requestStoragePermission();
    _pushyRegister().then((String deviceToken) {
      _deviceToken = deviceToken;
      SharedPreferences.getInstance().then((pref) {
        pref.setString(_deviceTokenKey, deviceToken);
      });

      BackgroundFetch.configure(
          BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            startOnBoot: true,
            requiredNetworkType: BackgroundFetchConfig.NETWORK_TYPE_ANY,
          ),
          _onBackgroundFetch);
    });

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
            '/profile': (context) => ProfilePage(),
          '/schedule': (context) => SchedulePage(),
          '/settings': (context) => SettingsPage()
        },
        //debugShowMaterialGrid: true,
        debugShowCheckedModeBanner: false
    );
  }
}
