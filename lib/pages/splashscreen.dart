import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/pages/login/select.dart';
import 'package:mobile_intranet/utils/network/IntranetAPIUtils.dart';
import 'package:mobile_intranet/pages/login/webview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/utils/ConfigurationKeys.dart' as ConfigurationKeys;

/// SplashScreen extended from StatefulWidget
/// State
class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => _SplashScreenState();
}

/// _SplashScreenState extended from State<SplashScreen>
/// Display content
class _SplashScreenState extends State<SplashScreen> {

    /// Run async task to change view after given time
    Future<Timer> startTime() async {
        var duration = new Duration(seconds: 4);
        return new Timer(duration, checkUserLogged);
    }

    void configCacheEntry() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (prefs.getBool(ConfigurationKeys.CONFIG_KEY_SCHEDULE_FR) == null) {
            prefs.setBool(ConfigurationKeys.CONFIG_KEY_SCHEDULE_FR, false);
            prefs.setBool(ConfigurationKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_MODULES, false);
            prefs.setBool(ConfigurationKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_SESSIONS, false);
        }
    }

    /// Check if the user is connected, and redirect to correct home
    void checkUserLogged() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Check if autologin url exists in shared preferences and redirect to homepage
        if (prefs.getString("autolog_url") != null) {
            Navigator.of(context).pushReplacementNamed('/home');
            return;
        }

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SelectLogin(loginEmail: prefs.getString("email"))
        ));
    }

    /// Init state of the widget and start timer
    @override
    void initState() {
        super.initState();
        this.startTime();
        this.configCacheEntry();
    }

    /// Build widget and display content
    @override
    Widget build(BuildContext context) {
        return Container(
            decoration: BoxDecoration(
                color: Color(0xFF131313)
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Image.asset("assets/images/icons/logo_dark.png"),
                ],
            )
        );
    }

}