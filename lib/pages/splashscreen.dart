import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/pages/login/select.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/utils/configKey.dart' as ConfigurationKeys;
import 'dart:io';
import 'package:mobile_intranet/utils/jobsUtils.dart' as Jobs;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
            prefs.setString(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_LAST_ID, null);
        }
    }

    /// Check if the user is connected, and redirect to correct home
    void checkUserLogged() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Check if autologin url exists in shared preferences and redirect to homepage
        if (prefs.getString("autolog_url") != null) {
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            return;
        }

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SelectLogin(loginEmail: prefs.getString("email"))
        ));
    }

    void configJobs() async {

        if (Platform.isAndroid) {
            await Jobs.setupAndroidJob();
        }

        /*
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var cron = new Cron();

        print("Config cron...");

        cron.schedule(new Schedule.parse('* * * * *'), () async {
            print("Enter cron...");
            // Get List of new notifications
            // Change prefs settings for number of new notifications
            var notifs = await Jobs.getNewNotifications(prefs);

            print("Process cron...");

            for (var n in notifs) {
                print(n.title + " " + n.content + " : " + n.id);
                print("--------------");
            }

            print("Exit cron...");
        });
        */
    }

    Future<dynamic> didReceive(int id, String title, String body, String payload) {
        print(id.toString() + " " + title);
    }

    void getNewNotifications() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var list = await Jobs.getNewNotifications(prefs);
        
        prefs.setInt(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_AMOUNT, list.length);
    }

    /// Init state of the widget and start timer
    @override
    void initState() {
        super.initState();
        this.startTime();
        this.configCacheEntry();
        this.configJobs();
        this.getNewNotifications();
    }

    /// Build widget and display content
    @override
    Widget build(BuildContext context) {
        return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                        Color(0xFF0072ff),
                        Color(0xFF2F80ED),
                    ]
                )
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    SvgPicture.asset("assets/images/icons/smartphone.svg",
                        width: MediaQuery.of(context).size.width / 2,
                    ),

                    SizedBox(height: 60),

                    SpinKitThreeBounce(
                        color: Colors.white,
                        size: 30,
                    )
                ],
            )
        );
    }

}